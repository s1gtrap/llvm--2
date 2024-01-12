declare void @abort()
declare void @exit(i32)

define void @test (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %3
 %6 = icmp ult i32 %5, 5
 br i1 %6, label %7, label %8
7:
 call void @abort ()
 unreachable
8:
 %9 = load i32, i32* %4
 %10 = icmp ult i32 %9, 5
 br i1 %10, label %11, label %12
11:
 call void @abort ()
 unreachable
12:
 %13 = load i32, i32* %3
 %14 = load i32, i32* %4
 %15 = add i32 %13, %14
 %16 = icmp ne i32 %15, 0
 br i1 %16, label %17, label %18
17:
 call void @abort ()
 unreachable
18:
 ret void
}

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 %6 = alloca i32
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 store i32 -2147483648, i32* %6
 %7 = load i32, i32* %6
 %8 = load i32, i32* %6
 call void @test (i32 %7, i32 %8)
 call void @exit (i32 0)
 unreachable
}
