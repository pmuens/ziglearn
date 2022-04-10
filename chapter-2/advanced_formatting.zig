const std = @import("std");
const eql = std.mem.eql;
const expect = std.testing.expect;
const bufPrint = std.fmt.bufPrint;

test "position" {
    var b: [3]u8 = undefined;

    try expect(eql(u8, try bufPrint(&b, "{0s}{0s}{1s}", .{ "a", "b" }), "aab"));
}

test "fill, alignment, width" {
    var b: [5]u8 = undefined;

    try expect(eql(
        u8,
        try bufPrint(&b, "{s: <5}", .{"hi!"}),
        "hi!  ",
    ));

    try expect(eql(
        u8,
        try bufPrint(&b, "{s:_^5}", .{"hi!"}),
        "_hi!_",
    ));

    try expect(eql(
        u8,
        try bufPrint(&b, "{s:!>4}", .{"hi!"}),
        "!hi!",
    ));
}

test "precision" {
    var b: [4]u8 = undefined;

    try expect(eql(u8, try bufPrint(&b, "{d:.2}", .{3.14159}), "3.14"));
}
