const std = @import("std");
const expectEqual = std.testing.expectEqual;

var foo: i32 = 1;

test "suspend with no resume" {
    var frame = async func();
    _ = frame;

    try expectEqual(foo, 2);
}

fn func() void {
    foo += 1;
    suspend {}
    foo += 1;
}

var bar: i32 = 1;

test "suspend with resume" {
    var frame = async func2();
    resume frame;

    try expectEqual(bar, 3);
}

fn func2() void {
    bar += 1;
    suspend {}
    bar += 1;
}
