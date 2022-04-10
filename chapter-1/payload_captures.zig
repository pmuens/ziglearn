const std = @import("std");
const eql = std.mem.eql;
const expect = std.testing.expect;
const expectEqual = std.testing.expectEqual;

test "optional-if" {
    var maybe_num: ?usize = 10;

    if (maybe_num) |n| {
        try expectEqual(@TypeOf(n), usize);
        try expectEqual(n, 10);
    } else {
        unreachable;
    }
}

test "error union if" {
    var ent_num: error{UnknownEntity}!u32 = 5;

    if (ent_num) |entity| {
        try expectEqual(@TypeOf(entity), u32);
        try expectEqual(entity, 5);
    } else |err| {
        _ = err catch {};
        unreachable;
    }
}

test "while optional" {
    var i: ?u32 = 10;

    while (i) |num| : (i.? -= 1) {
        try expectEqual(@TypeOf(num), u32);
        if (num == 1) {
            i = null;
            break;
        }
    }

    try expectEqual(i, null);
}

var numbers_left2: u32 = undefined;

fn eventuallyErrorSequence() !u32 {
    return if (numbers_left2 == 0) error.ReachedZero else blk: {
        numbers_left2 -= 1;
        break :blk numbers_left2;
    };
}

test "while error union capture" {
    var sum: u32 = 0;
    numbers_left2 = 3;

    while (eventuallyErrorSequence()) |value| {
        sum += value;
    } else |err| {
        try expectEqual(err, error.ReachedZero);
    }
}

test "for capture" {
    const x = [_]i8{ 1, 5, 120, -5 };

    for (x) |v| try expectEqual(@TypeOf(v), i8);
}

const Info = union(enum) {
    a: u32,
    b: []const u8,
    c,
    d: u32,
};

test "switch capture" {
    var b = Info{ .a = 10 };

    const x = switch (b) {
        .b => |str| blk: {
            try expectEqual(@TypeOf(str), []const u8);
            break :blk 1;
        },
        .c => 2,
        .a, .d => |num| blk: {
            try expectEqual(@TypeOf(num), u32);
            break :blk num * 2;
        },
    };

    try expectEqual(x, 20);
}

test "for with pointer capture" {
    var data = [_]u8{ 1, 2, 3 };
    for (data) |*byte| byte.* += 1;
    try expect(eql(u8, &data, &[_]u8{ 2, 3, 4 }));
}
