const std = @import("std");
const expectEqual = std.testing.expectEqual;

test "unreachable" {
    const x: i32 = 1;
    const y: u32 = if (x == 2) 5 else unreachable;
}

fn asciiToUpper(x: u8) u8 {
    return switch (x) {
        'a'...'z' => x + 'A' - 'a',
        'A'...'Z' => x,
        else => unreachable,
    };
}

test "unreachable switch" {
    try expectEqual(asciiToUpper('a'), 'A');
    try expectEqual(asciiToUpper('A'), 'A');
}
