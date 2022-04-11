const std = @import("std");
const expect = std.testing.expect;

const a1: u8 align(8) = 100;
const as align(8) = @as(u8, 100);

const b1: u64 align(1) = 100;
const b2 align(1) = @as(u64, 100);

test "aligned pointers" {
    const a: u32 align(8) = 5;
    try expect(@TypeOf(&a) == *align(8) const u32);
}

fn total(a: *align(64) const [64]u8) u32 {
    var sum: u32 = 0;
    for (a) |elem| sum += elem;
    return sum;
}

test "passing aligned data" {
    const x align(64) = [_]u8{10} ** 64;
    try expect(total(&x) == 640);
}
