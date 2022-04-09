const std = @import("std");
const expectEqual = std.testing.expectEqual;

test "if statement" {
    const a = true;
    var x: u16 = 0;

    if (a) {
        x += 1;
    } else {
        x += 2;
    }

    try expectEqual(x, 1);
}

test "if statement expression" {
    const a = true;
    var x: u16 = 0;

    x += if (a) 1 else 2;

    try expectEqual(x, 1);
}
