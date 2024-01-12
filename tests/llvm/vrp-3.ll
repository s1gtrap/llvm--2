declare void @abort()
declare void @exit(i32)

define i32 @f (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 store i32 %0, i32* %3
 %4 = load i32, i32* %3
 %5 = icmp slt i32 %4, 12
 br i1 %5, label %6, label %24
6:
 %7 = load i32, i32* %3
 %8 = icmp sgt i32 %7, -15
 br i1 %8, label %9, label %23
9:
 %10 = load i32, i32* %3
 %11 = icmp sgt i32 %10, 0
 br i1 %11, label %12, label %14
12:
 %13 = load i32, i32* %3
 br label %17
14:
 %15 = load i32, i32* %3
 %16 = sub i32 0, %15
 br label %17
17:
 %18 = phi i32 [%13, %12], [%16, %14]
 store i32 %18, i32* %3
 %19 = load i32, i32* %3
 %20 = icmp eq i32 %19, 2
 br i1 %20, label %21, label %22
21:
 store i32 0, i32* %2
 br label %25
22:
 store i32 1, i32* %2
 br label %25
23:
 br label %24
24:
 store i32 1, i32* %2
 br label %25
25:
 %26 = load i32, i32* %2
 ret i32 %26
}

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 %6 = call i32 @f (i32 -2)
 %7 = icmp ne i32 %6, 0
 br i1 %7, label %8, label %9
8:
 call void @abort ()
 unreachable
9:
 call void @exit (i32 0)
 unreachable
}
