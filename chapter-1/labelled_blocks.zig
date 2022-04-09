const std = @import("std");
const expectEqual = std.testing.expectEqual;

test "labelled blocks" {
    const count = blk: {
        var sum: u32 = 0;
        var i: u32 = 0;
        while (i < 10) : (i += 1) sum += i;
        break :blk sum;
    };

    try expectEqual(count, 45);
    try expectEqual(@TypeOf(count), u32);
}
