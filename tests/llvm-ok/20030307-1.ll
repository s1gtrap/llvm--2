declare void @abort()

define i32 @vfswrap_lock (i8* %0, i32 %1, i32 %2, i64 %3, i64 %4, i32 %5) {
 %7 = alloca i8*
 %8 = alloca i32
 %9 = alloca i32
 %10 = alloca i64
 %11 = alloca i64
 %12 = alloca i32
 store i8* %0, i8** %7
 store i32 %1, i32* %8
 store i32 %2, i32* %9
 store i64 %3, i64* %10
 store i64 %4, i64* %11
 store i32 %5, i32* %12
 %13 = load i32, i32* %8
 %14 = load i32, i32* %9
 %15 = load i64, i64* %10
 %16 = load i64, i64* %11
 %17 = load i32, i32* %12
 %18 = call i32 @fcntl_lock (i32 %13, i32 %14, i64 %15, i64 %16, i32 %17)
 ret i32 %18
}

define i32 @fcntl_lock (i32 %0, i32 %1, i64 %2, i64 %3, i32 %4) {
 %6 = alloca i32
 %7 = alloca i32
 %8 = alloca i64
 %9 = alloca i64
 %10 = alloca i32
 store i32 %0, i32* %6
 store i32 %1, i32* %7
 store i64 %2, i64* %8
 store i64 %3, i64* %9
 store i32 %4, i32* %10
 %11 = load i32, i32* %10
 ret i32 %11
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @vfswrap_lock (i8* null, i32 1, i32 2, i64 3, i64 4, i32 5)
 %3 = icmp ne i32 %2, 5
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 ret i32 0
}
