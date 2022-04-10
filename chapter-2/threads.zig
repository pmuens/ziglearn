const std = @import("std");
const expectEqual = std.testing.expectEqual;

fn ticker(step: u8) void {
    while (true) {
        std.time.sleep(1 * std.time.ns_per_s);
        tick += @as(isize, step);
    }
}

var tick: isize = 0;

test "threading" {
    var thread = try std.Thread.spawn(.{}, ticker, .{@as(u8, 1)});
    _ = thread;

    try expectEqual(tick, 0);

    std.time.sleep(3 * std.time.ns_per_s / 2);

    try expectEqual(tick, 1);
}
