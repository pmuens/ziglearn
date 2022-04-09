const std = @import("std");
const expectEqual = std.testing.expectEqual;

test "optional" {
    var found_index: ?usize = null;
    const data = [_]i32{ 1, 2, 3, 4, 5, 6, 7, 8, 12 };
    for (data) |v, i| {
        if (v == 10) found_index = i;
    }

    try expectEqual(found_index, null);
}

test "orelse" {
    var a: ?f32 = null;
    var b = a orelse 0;

    try expectEqual(b, 0);
    try expectEqual(@TypeOf(b), f32);
}

test "orelse unreachable" {
    const a: ?f32 = 5;
    const b = a orelse unreachable;
    const c = a.?;

    try expectEqual(b, c);
    try expectEqual(@TypeOf(c), f32);
}

test "if optional payload capture" {
    const a: ?i32 = 5;
    if (a != null) {
        const value = a.?;
        _ = value;
    }

    var b: ?i32 = 5;
    if (b) |*value| {
        value.* += 1;
    }

    try expectEqual(b.?, 6);
}

var numbers_left: u32 = 4;
fn eventuallyNullSequence() ?u32 {
    if (numbers_left == 0) return null;
    numbers_left -= 1;
    return numbers_left;
}

test "while null capture" {
    var sum: u32 = 0;
    while (eventuallyNullSequence()) |value| {
        sum += value;
    }

    try expectEqual(sum, 6);
}
