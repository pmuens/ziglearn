const std = @import("std");
const expectEqual = std.testing.expectEqual;

fn total(values: []const u8) usize {
    var sum: usize = 0;
    for (values) |v| sum += v;
    return sum;
}

test "slices" {
    const array = [_]u8{ 1, 2, 3, 4, 5 };
    const slice_1 = array[0..3];
    const slice_2 = array[0..];

    try expectEqual(total(slice_1), 6);
    try expectEqual(total(slice_2), 15);
    try expectEqual(@TypeOf(slice_1), *const [3]u8);
}
