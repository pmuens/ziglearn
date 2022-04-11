const std = @import("std");

// Used to get monotonic time, as opposed to wall-clock time.
var timer: ?std.time.Timer = null;
fn nanotime() u64 {
    if (timer == null) {
        timer = std.time.Timer.start() catch unreachable;
    }
    return timer.?.read();
}

// Holds the frame, and the nanotime of when the frame
//  should be resumed.
const Delay = struct {
    frame: anyframe,
    expires: u64,
};

// Suspend the caller, to be resumed later by the event loop.
fn waitForTime(time_ms: u64) void {
    suspend timer_queue.add(Delay{
        .frame = @frame(),
        .expires = nanotime() + (time_ms * std.time.ns_per_ms),
    }) catch unreachable;
}

fn waitUntilAndPrint(
    time1: u64,
    time2: u64,
    name: []const u8,
) void {
    const start = nanotime();

    // Suspend self, to be woken up when `time1` has passed.
    waitForTime(time1);
    std.debug.print(
        "[{s}] it is now {} ms since start!\n",
        .{ name, (nanotime() - start) / std.time.ns_per_ms },
    );

    // Suspend self, to be woken up when `time2` has passed.
    waitForTime(time2);
    std.debug.print(
        "[{s}] it is now {} ms since start!\n",
        .{ name, (nanotime() - start) / std.time.ns_per_ms },
    );
}

fn asyncMain() void {
    // Stores the async frames of our tasks.
    var tasks = [_]@Frame(waitUntilAndPrint){
        async waitUntilAndPrint(1000, 1200, "task-pair a"),
        async waitUntilAndPrint(500, 1300, "task-pair b"),
    };
    // `|*t|` is used, as `|t|` would be a `*const @Frame(...)`
    //  which cannot be awaited upon.
    for (tasks) |*t| await t;
}

// Priority queue of tasks
//  lower `.expires` => higher priority => to be executed before.
var timer_queue: std.PriorityQueue(Delay) = undefined;
fn cmp(a: Delay, b: Delay) std.math.Order {
    return std.math.order(a.expires, b.expires);
}

pub fn main() !void {
    timer_queue = std.PriorityQueue(Delay).init(
        std.heap.page_allocator,
        cmp,
    );
    defer timer_queue.deinit();

    var main_task = async asyncMain();

    // The body of the event loop
    //  pops the task which is to be next executed.
    while (timer_queue.removeOrNull()) |delay| {
        // Wait until it is time to execute next task.
        const now = nanotime();
        if (now < delay.expires) {
            std.time.sleep(delay.expires - now);
        }
        // Execute next task.
        resume delay.frame;
    }

    nosuspend await main_task;
}
