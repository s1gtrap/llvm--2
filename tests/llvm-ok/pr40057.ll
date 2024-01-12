declare void @abort()

define i32 @foo (i64 %0) {
 %2 = alloca i32
 %3 = alloca i64
 %4 = alloca i64
 store i64 %0, i64* %3
 %5 = load i64, i64* %3
 %6 = lshr i64 %5, 31
 %7 = and i64 %6, 1
 store i64 %7, i64* %4
 %8 = load i64, i64* %4
 %9 = icmp eq i64 %8, 0
 br i1 %9, label %10, label %11
10:
 store i32 0, i32* %2
 br label %12
11:
 store i32 -1, i32* %2
 br label %12
12:
 %13 = load i32, i32* %2
 ret i32 %13
}

define i32 @bar (i64 %0) {
 %2 = alloca i32
 %3 = alloca i64
 %4 = alloca i64
 store i64 %0, i64* %3
 %5 = load i64, i64* %3
 %6 = ashr i64 %5, 31
 %7 = and i64 %6, 1
 store i64 %7, i64* %4
 %8 = load i64, i64* %4
 %9 = icmp eq i64 %8, 0
 br i1 %9, label %10, label %11
10:
 store i32 0, i32* %2
 br label %12
11:
 store i32 -1, i32* %2
 br label %12
12:
 %13 = load i32, i32* %2
 ret i32 %13
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @foo (i64 6042589866)
 %3 = icmp ne i32 %2, 0
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 %6 = call i32 @foo (i64 6579460778)
 %7 = icmp ne i32 %6, 0
 br i1 %7, label %9, label %8
8:
 call void @abort ()
 unreachable
9:
 %10 = call i32 @bar (i64 6042589866)
 %11 = icmp ne i32 %10, 0
 br i1 %11, label %12, label %13
12:
 call void @abort ()
 unreachable
13:
 %14 = call i32 @bar (i64 6579460778)
 %15 = icmp ne i32 %14, 0
 br i1 %15, label %17, label %16
16:
 call void @abort ()
 unreachable
17:
 ret i32 0
}
