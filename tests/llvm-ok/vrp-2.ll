declare void @abort()
declare void @exit(i32)

define i32 @f (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 store i32 %0, i32* %3
 %4 = load i32, i32* %3
 %5 = icmp ne i32 %4, 2
 br i1 %5, label %6, label %20
6:
 %7 = load i32, i32* %3
 %8 = icmp sgt i32 %7, 0
 br i1 %8, label %9, label %11
9:
 %10 = load i32, i32* %3
 br label %14
11:
 %12 = load i32, i32* %3
 %13 = sub i32 0, %12
 br label %14
14:
 %15 = phi i32 [%10, %9], [%13, %11]
 store i32 %15, i32* %3
 %16 = load i32, i32* %3
 %17 = icmp eq i32 %16, 2
 br i1 %17, label %18, label %19
18:
 store i32 0, i32* %2
 br label %21
19:
 store i32 1, i32* %2
 br label %21
20:
 store i32 1, i32* %2
 br label %21
21:
 %22 = load i32, i32* %2
 ret i32 %22
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
