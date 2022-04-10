const std = @import("std");
const expectEqual = std.testing.expectEqual;

test "anonymous struct literal" {
    const Point = struct { x: i32, y: i32 };

    var pt: Point = .{
        .x = 13,
        .y = 67,
    };

    try expectEqual(pt.x, 13);
    try expectEqual(pt.y, 67);
}

test "fully anonymous struct" {
    try dump(.{
        .int = @as(u32, 1234),
        .float = @as(f64, 12.34),
        .b = true,
        .s = "hi",
    });
}

fn dump(args: anytype) !void {
    try expectEqual(args.int, 1234);
    try expectEqual(args.float, 12.34);
    try expectEqual(args.b, true);
    try expectEqual(args.s[0], 'h');
    try expectEqual(args.s[1], 'i');
}

test "tuple" {
    const values = .{
        @as(u32, 1234),
        @as(f64, 12.34),
        true,
        "hi",
    } ++ .{false} ** 2;

    try expectEqual(values[0], 1234);
    try expectEqual(values[4], false);

    inline for (values) |v, i| {
        if (i != 2) continue;
        try expectEqual(v, true);
    }

    try expectEqual(values.len, 6);
    try expectEqual(values.@"3"[0], 'h');
}
