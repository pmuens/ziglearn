const std = @import("std");
const expectEqual = std.testing.expectEqual;

test "arrays" {
    const a = [5]u8{ 'h', 'e', 'l', 'l', 'o' };
    const b = [_]u8{ 'w', 'o', 'r', 'l', 'd' };

    const length = b.len;

    try expectEqual(a[0], 'h');
    try expectEqual(a[4], 'o');
    try expectEqual(length, 5);
}
