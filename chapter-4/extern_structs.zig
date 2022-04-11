const std = @import("std");
const expect = std.testing.expect;

const Data = extern struct { a: i32, b: u8, c: f32, d: bool, e: bool };

test "hmm" {
    const x = Data{
        .a = 10005,
        .b = 42,
        .c = -10.5,
        .d = false,
        .e = true,
    };

    const z = @ptrCast([*]const u8, &x);

    try expect(@ptrCast(*const i32, z).* == 10005);
    try expect(@ptrCast(*const u8, z + 4).* == 42);
    try expect(@ptrCast(*const f32, z + 8).* == -10.5);
    try expect(@ptrCast(*const bool, z + 12).* == false);
    try expect(@ptrCast(*const bool, z + 13).* == true);
}
