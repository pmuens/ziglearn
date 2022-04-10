const std = @import("std");
const expectEqual = std.testing.expectEqual;

test "inline for" {
    const types = [_]type{ i32, f32, u8, bool };
    var sum: usize = 0;

    inline for (types) |T| sum += @sizeOf(T);

    try expectEqual(sum, 10);
}
