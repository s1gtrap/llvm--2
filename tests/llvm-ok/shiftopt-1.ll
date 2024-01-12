declare void @abort()

define void @utest (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = lshr i32 %3, 0
 %5 = load i32, i32* %2
 %6 = icmp ne i32 %4, %5
 br i1 %6, label %7, label %8
7:
 call void @link_error ()
 br label %8
8:
 %9 = load i32, i32* %2
 %10 = shl i32 %9, 0
 %11 = load i32, i32* %2
 %12 = icmp ne i32 %10, %11
 br i1 %12, label %13, label %14
13:
 call void @link_error ()
 br label %14
14:
 %15 = load i32, i32* %2
 %16 = shl i32 0, %15
 %17 = icmp ne i32 %16, 0
 br i1 %17, label %18, label %19
18:
 call void @link_error ()
 br label %19
19:
 %20 = load i32, i32* %2
 %21 = ashr i32 0, %20
 %22 = icmp ne i32 %21, 0
 br i1 %22, label %23, label %24
23:
 call void @link_error ()
 br label %24
24:
 %25 = load i32, i32* %2
 %26 = ashr i32 -1, %25
 %27 = icmp ne i32 %26, -1
 br i1 %27, label %28, label %29
28:
 call void @link_error ()
 br label %29
29:
 %30 = load i32, i32* %2
 %31 = ashr i32 -1, %30
 %32 = icmp ne i32 %31, -1
 br i1 %32, label %33, label %34
33:
 call void @link_error ()
 br label %34
34:
 ret void
}

define void @link_error () {
 call void @abort ()
 unreachable
}

define void @stest (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = ashr i32 %3, 0
 %5 = load i32, i32* %2
 %6 = icmp ne i32 %4, %5
 br i1 %6, label %7, label %8
7:
 call void @link_error ()
 br label %8
8:
 %9 = load i32, i32* %2
 %10 = shl i32 %9, 0
 %11 = load i32, i32* %2
 %12 = icmp ne i32 %10, %11
 br i1 %12, label %13, label %14
13:
 call void @link_error ()
 br label %14
14:
 %15 = load i32, i32* %2
 %16 = shl i32 0, %15
 %17 = icmp ne i32 %16, 0
 br i1 %17, label %18, label %19
18:
 call void @link_error ()
 br label %19
19:
 %20 = load i32, i32* %2
 %21 = ashr i32 0, %20
 %22 = icmp ne i32 %21, 0
 br i1 %22, label %23, label %24
23:
 call void @link_error ()
 br label %24
24:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @utest (i32 9)
 call void @utest (i32 0)
 call void @stest (i32 9)
 call void @stest (i32 0)
 ret i32 0
}
