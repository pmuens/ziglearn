const std = @import("std");
const eql = std.mem.eql;
const ArrayList = std.ArrayList;
const expect = std.testing.expect;
const expectEqual = std.testing.expectEqual;
const test_allocator = std.testing.allocator;

const Place = struct { lat: f32, long: f32 };

test "json parse" {
    var stream = std.json.TokenStream.init(
        \\{ "lat": 40.684540, "long": -74.401422 }
    );
    const x = try std.json.parse(Place, &stream, .{});

    try expectEqual(x.lat, 40.684540);
    try expectEqual(x.long, -74.401422);
}

test "json stringify" {
    const x = Place{
        .lat = 51.997664,
        .long = -0.740687,
    };

    var buf: [100]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buf);
    var string = ArrayList(u8).init(fba.allocator());
    try std.json.stringify(x, .{}, string.writer());

    try expect(eql(u8, string.items,
        \\{"lat":5.19976654e+01,"long":-7.40687012e-01}
    ));
}

test "json parse with strings" {
    var stream = std.json.TokenStream.init(
        \\{ "name": "Joe", "age": 25 }
    );

    const User = struct { name: []u8, age: u16 };

    const x = try std.json.parse(
        User,
        &stream,
        .{ .allocator = test_allocator },
    );

    defer std.json.parseFree(
        User,
        x,
        .{ .allocator = test_allocator },
    );

    try expect(eql(u8, x.name, "Joe"));
    try expectEqual(x.age, 25);
}
