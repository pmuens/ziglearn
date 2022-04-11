const std = @import("std");
const Table = @import("table-helper").Table;

pub fn main() anyerror!void {
    try std.io.getStdOut().writer().print("{}\n", .{Table(&[_][]const u8{ "Version", "Date" }){ .data = &[_][2][]const u8{
        .{ "0.7.1", "2020-12-13" },
        .{ "0.7.0", "2020-11-08" },
        .{ "0.6.0", "2020-04-13" },
        .{ "0.5.0", "2019-09-30" },
    } }});
}

test "basic test" {
    try std.testing.expectEqual(10, 3 + 7);
}
