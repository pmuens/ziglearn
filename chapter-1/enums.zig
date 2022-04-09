const std = @import("std");
const expectEqual = std.testing.expectEqual;

const Direction = enum { north, south, east, west };

const Value = enum(u2) { zero, one, two };

test "enum ordinal value" {
    try expectEqual(@enumToInt(Value.zero), 0);
    try expectEqual(@enumToInt(Value.one), 1);
    try expectEqual(@enumToInt(Value.two), 2);
}

const Value2 = enum(u32) {
    hundred = 100,
    thousand = 1000,
    million = 1000000,
    next,
};

test "set enum ordinal value" {
    try expectEqual(@enumToInt(Value2.hundred), 100);
    try expectEqual(@enumToInt(Value2.thousand), 1000);
    try expectEqual(@enumToInt(Value2.million), 1000000);
    try expectEqual(@enumToInt(Value2.next), 1000001);
}

const Suit = enum {
    clubs,
    spades,
    diamonds,
    hearts,
    pub fn isClubs(self: Suit) bool {
        return self == Suit.clubs;
    }
};

test "enum method" {
    try expectEqual(Suit.spades.isClubs(), Suit.isClubs(.spades));
}

const Mode = enum {
    var count: u32 = 0;
    on,
    off,
};

test "hmm" {
    Mode.count += 1;
    try expectEqual(Mode.count, 1);
}
