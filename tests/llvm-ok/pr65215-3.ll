%struct.S = type { i64 }

@__const.main.s = global { i8, i8, i8, i8, i8, i8, i8, i8 } {i8 -66, i8 -83, i8 -34, i8 -17, i8 -88, i8 -66, i8 -19, i8 -2}

declare void @llvm.memcpy.p0.p0.i64(i8*, i8*, i64, i1)
declare void @abort()

define i64 @bar (i8* %0) {
 %2 = alloca i8*
 %3 = alloca i64
 %4 = alloca i64
 store i8* %0, i8** %2
 %5 = load i8*, i8** %2
 %6 = load i64, i64* %5
 %7 = and i64 %6, 16777215
 %8 = trunc i64 %7 to i32
 %9 = shl i32 %8, 8
 %10 = load i8*, i8** %2
 %11 = load i64, i64* %10
 %12 = lshr i64 %11, 24
 %13 = and i64 %12, 255
 %14 = trunc i64 %13 to i32
 %15 = or i32 %9, %14
 %16 = call i32 @foo (i32 %15)
 %17 = zext i32 %16 to i64
 store i64 %17, i64* %3
 %18 = load i8*, i8** %2
 %19 = load i64, i64* %18
 %20 = lshr i64 %19, 32
 %21 = trunc i64 %20 to i32
 %22 = call i32 @foo (i32 %21)
 %23 = zext i32 %22 to i64
 store i64 %23, i64* %4
 %24 = load i64, i64* %4
 %25 = shl i64 %24, 32
 %26 = load i64, i64* %3
 %27 = or i64 %25, %26
 ret i64 %27
}

define i32 @foo (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = lshr i32 %3, 24
 %5 = load i32, i32* %2
 %6 = lshr i32 %5, 8
 %7 = and i32 %6, 65280
 %8 = or i32 %4, %7
 %9 = load i32, i32* %2
 %10 = shl i32 %9, 8
 %11 = and i32 %10, 16711680
 %12 = or i32 %8, %11
 %13 = load i32, i32* %2
 %14 = shl i32 %13, 24
 %15 = or i32 %12, %14
 ret i32 %15
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca %struct.S
 %3 = alloca i64
 store i32 0, i32* %1
 call void @memcpy (i8* %2, i8* @__const.main.s, i64 8, i1 0)
 %4 = call i64 @bar (i8* %2)
 store i64 %4, i64* %3
 %5 = load i64, i64* %3
 %6 = lshr i64 %5, 32
 %7 = trunc i64 %6 to i32
 %8 = call i32 @foo (i32 %7)
 %9 = load i64, i64* %2
 %10 = lshr i64 %9, 32
 %11 = trunc i64 %10 to i32
 %12 = icmp ne i32 %8, %11
 br i1 %12, label %32, label %13
13:
 %14 = load i64, i64* %3
 %15 = trunc i64 %14 to i32
 %16 = call i32 @foo (i32 %15)
 %17 = lshr i32 %16, 8
 %18 = load i64, i64* %2
 %19 = and i64 %18, 16777215
 %20 = trunc i64 %19 to i32
 %21 = icmp ne i32 %17, %20
 br i1 %21, label %32, label %22
22:
 %23 = load i64, i64* %3
 %24 = trunc i64 %23 to i32
 %25 = call i32 @foo (i32 %24)
 %26 = and i32 %25, 255
 %27 = load i64, i64* %2
 %28 = lshr i64 %27, 24
 %29 = and i64 %28, 255
 %30 = trunc i64 %29 to i32
 %31 = icmp ne i32 %26, %30
 br i1 %31, label %32, label %33
32:
 call void @abort ()
 unreachable
33:
 ret i32 0
}
