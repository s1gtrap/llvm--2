define void @test1 (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %3
 %6 = load i32, i32* %4
 %7 = icmp eq i32 %5, %6
 br i1 %7, label %8, label %13
8:
 %9 = load i32, i32* %3
 %10 = load i32, i32* %4
 %11 = icmp ne i32 %9, %10
 br i1 %11, label %12, label %13
12:
 call void @link_error0 ()
 br label %13
13:
 ret void
}

define void @test2 (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %3
 %6 = load i32, i32* %4
 %7 = icmp slt i32 %5, %6
 br i1 %7, label %8, label %13
8:
 %9 = load i32, i32* %3
 %10 = load i32, i32* %4
 %11 = icmp sgt i32 %9, %10
 br i1 %11, label %12, label %13
12:
 call void @link_error0 ()
 br label %13
13:
 ret void
}

define void @test3 (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %3
 %6 = load i32, i32* %4
 %7 = icmp slt i32 %5, %6
 br i1 %7, label %8, label %13
8:
 %9 = load i32, i32* %4
 %10 = load i32, i32* %3
 %11 = icmp slt i32 %9, %10
 br i1 %11, label %12, label %13
12:
 call void @link_error0 ()
 br label %13
13:
 ret void
}

define void @test4 (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %3
 %6 = load i32, i32* %4
 %7 = icmp eq i32 %5, %6
 br i1 %7, label %12, label %8
8:
 %9 = load i32, i32* %3
 %10 = load i32, i32* %4
 %11 = icmp ne i32 %9, %10
 br i1 %11, label %12, label %13
12:
 br label %14
13:
 call void @link_error1 ()
 br label %14
14:
 ret void
}

define void @test5 (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %3
 %6 = load i32, i32* %4
 %7 = icmp sge i32 %5, %6
 br i1 %7, label %12, label %8
8:
 %9 = load i32, i32* %3
 %10 = load i32, i32* %4
 %11 = icmp slt i32 %9, %10
 br i1 %11, label %12, label %13
12:
 br label %14
13:
 call void @link_error1 ()
 br label %14
14:
 ret void
}

define void @test6 (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %3
 %6 = load i32, i32* %4
 %7 = icmp sle i32 %5, %6
 br i1 %7, label %12, label %8
8:
 %9 = load i32, i32* %4
 %10 = load i32, i32* %3
 %11 = icmp slt i32 %9, %10
 br i1 %11, label %12, label %13
12:
 br label %14
13:
 call void @link_error1 ()
 br label %14
14:
 ret void
}

define void @all_tests (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %3
 %6 = load i32, i32* %4
 call void @test1 (i32 %5, i32 %6)
 %7 = load i32, i32* %3
 %8 = load i32, i32* %4
 call void @test2 (i32 %7, i32 %8)
 %9 = load i32, i32* %3
 %10 = load i32, i32* %4
 call void @test3 (i32 %9, i32 %10)
 %11 = load i32, i32* %3
 %12 = load i32, i32* %4
 call void @test4 (i32 %11, i32 %12)
 %13 = load i32, i32* %3
 %14 = load i32, i32* %4
 call void @test5 (i32 %13, i32 %14)
 %15 = load i32, i32* %3
 %16 = load i32, i32* %4
 call void @test6 (i32 %15, i32 %16)
 ret void
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @all_tests (i32 0, i32 0)
 call void @all_tests (i32 1, i32 2)
 call void @all_tests (i32 4, i32 3)
 ret i32 0
}

define void @link_error0 () {
 ret void
}

define void @link_error1 () {
 ret void
}
