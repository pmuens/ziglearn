const std = @import("std");
const eql = std.mem.eql;
const expect = std.testing.expect;
const expectEqual = std.testing.expectEqual;
const test_allocator = std.testing.allocator;

test "split iterator" {
    const text = "robust, optimal, reusable, maintainable, ";

    var iter = std.mem.split(u8, text, ", ");

    try expect(eql(u8, iter.next().?, "robust"));
    try expect(eql(u8, iter.next().?, "optimal"));
    try expect(eql(u8, iter.next().?, "reusable"));
    try expect(eql(u8, iter.next().?, "maintainable"));
    try expect(eql(u8, iter.next().?, ""));
    try expectEqual(iter.next(), null);
}

test "iterator looping" {
    var iter = (try std.fs.cwd().openDir(
        ".",
        .{ .iterate = true },
    )).iterate();

    var file_count: usize = 0;
    while (try iter.next()) |entry| {
        if (entry.kind == .File) file_count += 1;
    }

    try expect(file_count > 0);
}

test "arg iteration" {
    var arg_characters: usize = 0;
    var iter = std.process.args();

    while (try iter.next(test_allocator)) |arg| {
        arg_characters += arg.len;
        test_allocator.free(arg);
    }

    try expect(arg_characters > 0);
}

const ContainsIterator = struct {
    strings: []const []const u8,
    needle: []const u8,
    index: usize = 0,

    fn next(self: *ContainsIterator) ?[]const u8 {
        const index = self.index;
        for (self.strings[index..]) |string| {
            self.index += 1;
            if (std.mem.indexOf(u8, string, self.needle)) |_| {
                return string;
            }
        }
        return null;
    }
};

test "custom iterator" {
    var iter = ContainsIterator{
        .strings = &[_][]const u8{ "one", "two", "three" },
        .needle = "e",
    };

    try expect(eql(u8, iter.next().?, "one"));
    try expect(eql(u8, iter.next().?, "three"));
    try expectEqual(iter.next(), null);
}
