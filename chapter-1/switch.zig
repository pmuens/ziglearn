const std = @import("std");
const expectEqual = std.testing.expectEqual;

test "switch statement" {
    var x: i8 = 10;

    switch (x) {
        -1...1 => {
            x = -x;
        },
        10, 100 => {
            x = @divExact(x, 10);
        },
        else => {},
    }

    try expectEqual(x, 1);
}

test "switch expression" {
    var x: i8 = 10;

    x = switch (x) {
        -1...1 => -x,
        10, 100 => @divExact(x, 10),
        else => x,
    };

    try expectEqual(x, 1);
}
