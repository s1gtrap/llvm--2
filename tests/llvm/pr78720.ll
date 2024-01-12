declare void @abort()

define i64 @foo (i8 %0) {
 %2 = alloca i8
 store i8 %0, i8* %2
 %3 = load i8, i8* %2
 %4 = sext i8 %3 to i32
 %5 = icmp slt i32 %4, 0
 %6 = zext i1 %5 to i64
 %7 = select i1 %5, i64 524288, i64 0
 ret i64 %7
}

define i64 @bar (i8 %0) {
 %2 = alloca i8
 store i8 %0, i8* %2
 %3 = load i8, i8* %2
 %4 = sext i8 %3 to i32
 %5 = icmp slt i32 %4, 0
 %6 = zext i1 %5 to i64
 %7 = select i1 %5, i64 128, i64 0
 ret i64 %7
}

define i64 @baz (i8 %0) {
 %2 = alloca i8
 store i8 %0, i8* %2
 %3 = load i8, i8* %2
 %4 = sext i8 %3 to i32
 %5 = icmp slt i32 %4, 0
 %6 = zext i1 %5 to i64
 %7 = select i1 %5, i64 32, i64 0
 ret i64 %7
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i64 @foo (i8 -1)
 %3 = icmp ne i64 %2, 524288
 br i1 %3, label %28, label %4
4:
 %5 = call i64 @bar (i8 -1)
 %6 = icmp ne i64 %5, 128
 br i1 %6, label %28, label %7
7:
 %8 = call i64 @baz (i8 -1)
 %9 = icmp ne i64 %8, 32
 br i1 %9, label %28, label %10
10:
 %11 = call i64 @foo (i8 0)
 %12 = icmp ne i64 %11, 0
 br i1 %12, label %28, label %13
13:
 %14 = call i64 @bar (i8 0)
 %15 = icmp ne i64 %14, 0
 br i1 %15, label %28, label %16
16:
 %17 = call i64 @baz (i8 0)
 %18 = icmp ne i64 %17, 0
 br i1 %18, label %28, label %19
19:
 %20 = call i64 @foo (i8 31)
 %21 = icmp ne i64 %20, 0
 br i1 %21, label %28, label %22
22:
 %23 = call i64 @bar (i8 31)
 %24 = icmp ne i64 %23, 0
 br i1 %24, label %28, label %25
25:
 %26 = call i64 @baz (i8 31)
 %27 = icmp ne i64 %26, 0
 br i1 %27, label %28, label %29
28:
 call void @abort ()
 unreachable
29:
 ret i32 0
}
