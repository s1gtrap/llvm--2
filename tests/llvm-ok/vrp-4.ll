declare void @abort()
declare void @exit(i32)

define void @test (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %6 = load i32, i32* %3
 %7 = icmp eq i32 %6, 1
 br i1 %7, label %8, label %9
8:
 call void @abort ()
 unreachable
9:
 %10 = load i32, i32* %4
 %11 = icmp eq i32 %10, 1
 br i1 %11, label %12, label %13
12:
 call void @abort ()
 unreachable
13:
 %14 = load i32, i32* %3
 %15 = load i32, i32* %4
 %16 = sdiv i32 %14, %15
 store i32 %16, i32* %5
 %17 = load i32, i32* %5
 %18 = icmp ne i32 %17, 1
 br i1 %18, label %19, label %20
19:
 call void @abort ()
 unreachable
20:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @test (i32 2, i32 2)
 call void @exit (i32 0)
 unreachable
}
