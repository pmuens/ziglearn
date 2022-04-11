const std = @import("std");
const w = std.os.windows;

/// **Opens a process**, giving you a handle to it.
/// [MSDN](https://docs.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-openprocess).
pub extern "kernel32" fn OpenProcess(
    /// [The desired process access rights](https://docs.microsoft.com/en-us/windows/win32/procthread/process-security-and-access-rights).
    dwDesiredAccess: w.DWORD,
    ///
    bInheritHandle: w.BOOL,
    dwProcessId: w.DWORD,
) callconv(w.WINAPI) ?w.HANDLE;

/// Spreadsheet position.
pub const Pos = struct {
    /// Row.
    x: u32,
    /// Column.
    y: u32,
};

pub const message = "hello!";

// Used to force analysis, as these things aren't otherwise referenced.
comptime {
    _ = OpenProcess;
    _ = Pos;
    _ = message;
}

const A = error{
    NotDir,

    /// A doc comment.
    PathNotFound,
};
const B = error{
    OutOfMemory,

    /// B doc comment.
    PathNotFound,
};

const C = A || B;
