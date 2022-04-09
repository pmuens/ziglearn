const std = @import("std");
const expectEqual = std.testing.expectEqual;

fn rangeHasNumber(begin: usize, end: usize, number: usize) bool {
    var i = begin;
    return while (i < end) : (i += 1) {
        if (i == number) {
            break true;
        }
    } else false;
}

test "while loop expression" {
    try expectEqual(rangeHasNumber(0, 10, 3), true);
}
