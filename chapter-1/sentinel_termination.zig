const std = @import("std");
const expectEqual = std.testing.expectEqual;

test "sentinel termination" {
    const terminated = [3:0]u8{ 3, 2, 1 };

    try expectEqual(terminated.len, 3);
    try expectEqual(@bitCast([4]u8, terminated)[3], 0);
}

test "string literal" {
    try expectEqual(@TypeOf("hello"), *const [5:0]u8);
}

test "C string" {
    const c_string: [*:0]const u8 = "hello";
    var array: [5]u8 = undefined;

    var i: usize = 0;
    while (c_string[i] != 0) : (i += 1) {
        array[i] = c_string[i];
    }
}

test "coercion" {
    var a: [*:0]u8 = undefined;
    const b: [*]u8 = a;
    _ = b;

    var c: [5:0]u8 = undefined;
    const d: [5]u8 = c;
    _ = d;

    var e: [:10]f32 = undefined;
    const f = e;
    _ = f;
}

test "sentinel terminated slicing" {
    var x = [_:0]u8{255} ** 3;
    const y = x[0..3 :0];
    _ = y;
}
