const std = @import("std");
const expectEqual = std.testing.expectEqual;

fn addFive(x: u32) u32 {
    return x + 5;
}

test "function" {
    const y = addFive(0);

    try expectEqual(@TypeOf(y), u32);
    try expectEqual(y, 5);
}

fn fibonacci(n: u16) u16 {
    if (n == 0 or n == 1) return n;
    return fibonacci(n - 1) + fibonacci(n - 2);
}

test "function recursion" {
    const x = fibonacci(10);

    try expectEqual(x, 55);
}
