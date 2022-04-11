const std = @import("std");

// `main` cannot be `async`.
// pub fn main() !void {
//     suspend {}
// }

fn doTicksDuration(ticker: *u32) i64 {
    const start = std.time.milliTimestamp();

    while (ticker.* > 0) {
        suspend {}
        ticker.* -= 1;
    }

    return std.time.milliTimestamp() - start;
}

pub fn main() !void {
    var ticker: u32 = 0;
    _ = nosuspend doTicksDuration(&ticker);
}
