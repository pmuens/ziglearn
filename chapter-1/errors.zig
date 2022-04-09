const std = @import("std");
const expectEqual = std.testing.expectEqual;

const FileOpenError = error{
    AccessDenied,
    OutOfMemory,
    FileNotFound,
};

const AllocationError = error{OutOfMemory};

test "coerce error from a subset to a superset" {
    const err: FileOpenError = AllocationError.OutOfMemory;

    try expectEqual(err, FileOpenError.OutOfMemory);
}

test "error union" {
    const maybe_error: AllocationError!u16 = 10;
    const no_error = maybe_error catch 0;

    try expectEqual(@TypeOf(no_error), u16);
    try expectEqual(no_error, 10);
}

fn failingFunction() error{Oops}!void {
    return error.Oops;
}

test "returning an error" {
    failingFunction() catch |err| {
        try expectEqual(err, error.Oops);
        return;
    };
}

fn failFn() error{Oops}!i32 {
    try failingFunction();
    return 12;
}

test "try" {
    _ = failFn() catch |err| {
        try expectEqual(err, error.Oops);
        return;
    };
    // try expect(_ == 12); // never reached
}

var problems: u32 = 98;

fn failFnCounter() error{Oops}!void {
    errdefer problems += 1;
    try failingFunction();
}

test "errdefer" {
    failFnCounter() catch |err| {
        try expectEqual(err, error.Oops);
        try expectEqual(problems, 99);
        return;
    };
}

fn createFile() !void {
    return error.AccessDenied;
}

test "inferred error set" {
    const x: error{AccessDenied}!void = createFile();

    _ = x catch {};
}

test "merged error sets" {
    const A = error{ NotDir, PathNotFound };
    const B = error{ OutOfMemory, PathNotFound };
    const C = A || B;

    try expectEqual(C.NotDir, A.NotDir);
}
