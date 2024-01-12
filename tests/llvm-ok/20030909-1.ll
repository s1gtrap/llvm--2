declare void @abort()
declare void @exit(i32)

define void @test (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %3
 %6 = load i32, i32* %4
 %7 = icmp eq i32 %5, %6
 br i1 %7, label %8, label %9
8:
 call void @abort ()
 unreachable
9:
 ret void
}

define void @foo (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %3
 %6 = load i32, i32* %4
 %7 = icmp eq i32 %5, %6
 br i1 %7, label %8, label %9
8:
 br label %10
9:
 br label %10
10:
 %11 = load i32, i32* %3
 %12 = load i32, i32* %4
 %13 = icmp eq i32 %11, %12
 br i1 %13, label %14, label %15
14:
 br label %16
15:
 br label %16
16:
 %17 = load i32, i32* %3
 %18 = load i32, i32* %4
 %19 = icmp ne i32 %17, %18
 br i1 %19, label %20, label %23
20:
 %21 = load i32, i32* %3
 %22 = load i32, i32* %4
 call void @test (i32 %21, i32 %22)
 br label %23
23:
 br label %24
24:
 br label %25
25:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @foo (i32 0, i32 0)
 call void @exit (i32 0)
 unreachable
}
