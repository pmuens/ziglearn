const std = @import("std");
const expectEqual = std.testing.expectEqual;

test "defer" {
    var x: i16 = 5;

    {
        defer x += 2;

        try expectEqual(x, 5);
    }

    try expectEqual(x, 7);
}

test "multi defer" {
    var x: f32 = 5;
    {
        defer x += 2;
        defer x /= 2;
    }

    try expectEqual(x, 4.5);
}
