const std = @import("std");
const expectEqual = std.testing.expectEqual;

fn func() u32 {
    return 5;
}

test "async / await" {
    var frame = async func();

    try expectEqual(await frame, 5);
}
