const std = @import("std");

test "random numbers" {
    var prng = std.rand.DefaultPrng.init(blk: {
        var seed: u64 = undefined;
        try std.os.getrandom(std.mem.asBytes(&seed));
        break :blk seed;
    });
    const rand = prng.random();

    const a = rand.float(f32);
    const b = rand.boolean();
    const c = rand.int(u8);
    const d = rand.intRangeAtMost(u8, 0, 255);

    std.debug.print("\nPseudo Random Numbers:\n", .{});
    std.debug.print("a {}\n", .{a});
    std.debug.print("b {}\n", .{b});
    std.debug.print("c {}\n", .{c});
    std.debug.print("d {}\n", .{d});
}

test "crypto random numbers" {
    const rand = std.crypto.random;

    const a = rand.float(f32);
    const b = rand.boolean();
    const c = rand.int(u8);
    const d = rand.intRangeAtMost(u8, 0, 255);

    std.debug.print("\nCrypto Random Numbers:\n", .{});
    std.debug.print("a {}\n", .{a});
    std.debug.print("b {}\n", .{b});
    std.debug.print("c {}\n", .{c});
    std.debug.print("d {}\n", .{d});
}
