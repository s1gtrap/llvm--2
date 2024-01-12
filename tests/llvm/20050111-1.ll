declare void @abort()

define i32 @foo (i64 %0) {
 %2 = alloca i32
 %3 = alloca i64
 %4 = alloca i32
 store i64 %0, i64* %3
 %5 = load i64, i64* %3
 %6 = icmp eq i64 %5, 0
 br i1 %6, label %7, label %8
7:
 store i32 0, i32* %2
 br label %13
8:
 %9 = load i64, i64* %3
 %10 = lshr i64 %9, 32
 %11 = trunc i64 %10 to i32
 store i32 %11, i32* %4
 %12 = load i32, i32* %4
 store i32 %12, i32* %2
 br label %13
13:
 %14 = load i32, i32* %2
 ret i32 %14
}

define i64 @bar (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = zext i16 %3 to i64
 %5 = shl i64 %4, 32
 ret i64 %5
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @foo (i64 0)
 %3 = icmp ne i32 %2, 0
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 %6 = call i32 @foo (i64 4294967295)
 %7 = icmp ne i32 %6, 0
 br i1 %7, label %8, label %9
8:
 call void @abort ()
 unreachable
9:
 %10 = call i32 @foo (i64 163192045312)
 %11 = icmp ne i32 %10, 37
 br i1 %11, label %12, label %13
12:
 call void @abort ()
 unreachable
13:
 %14 = call i64 @bar (i16 0)
 %15 = icmp ne i64 %14, 0
 br i1 %15, label %16, label %17
16:
 call void @abort ()
 unreachable
17:
 %18 = call i64 @bar (i16 37)
 %19 = icmp ne i64 %18, 158913789952
 br i1 %19, label %20, label %21
20:
 call void @abort ()
 unreachable
21:
 ret i32 0
}
