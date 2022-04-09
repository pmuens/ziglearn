const std = @import("std");
const expectEqual = std.testing.expectEqual;

test "usize" {
    try expectEqual(@sizeOf(usize), @sizeOf(*u8));
    try expectEqual(@sizeOf(isize), @sizeOf(*u8));
}
