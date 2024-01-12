declare void @abort()

define void @bar (i64 %0) {
 %2 = alloca i64
 store i64 %0, i64* %2
 %3 = load i64, i64* %2
 %4 = icmp ne i64 %3, 0
 br i1 %4, label %5, label %6
5:
 call void @abort ()
 unreachable
6:
 ret void
}

define void @do_test (i8* %0) {
 %2 = alloca i8*
 %3 = alloca i32
 %4 = alloca i8*
 %5 = alloca i32
 store i8* %0, i8** %4
 store i32 0, i32* %5
 br label %6
6:
 %7 = load i32, i32* %5
 %8 = icmp slt i32 %7, 2
 br i1 %8, label %9, label %29
9:
 %10 = load i8*, i8** %4
 store i8* %10, i8** %2
 store i32 0, i32* %3
 br label %11
11:
 %12 = load i8*, i8** %2
 %13 = load i64, i64* %12
 %14 = load i32, i32* %3
 %15 = sub i32 63, %14
 %16 = zext i32 %15 to i64
 %17 = shl i64 1, %16
 %18 = and i64 %13, %17
 %19 = icmp ne i64 %18, 0
 br i1 %19, label %23, label %20
20:
 %21 = load i32, i32* %3
 %22 = add i32 %21, 1
 store i32 %22, i32* %3
 br label %11
23:
 %24 = load i32, i32* %3
 %25 = sext i32 %24 to i64
 call void @bar (i64 %25)
 br label %26
26:
 %27 = load i32, i32* %5
 %28 = add i32 %27, 1
 store i32 %28, i32* %5
 br label %6
29:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i64
 store i32 0, i32* %1
 store i64 -9223372036854775807, i64* %2
 call void @do_test (i8* %2)
 ret i32 0
}
