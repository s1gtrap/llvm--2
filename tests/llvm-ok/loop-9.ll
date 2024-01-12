declare void @abort()

define i32 @false () {
 ret i32 0
}

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 %6 = alloca i32
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 store i32 0, i32* %6
 br label %7
7:
 %8 = call i32 @false ()
 %9 = icmp ne i32 %8, 0
 br i1 %9, label %13, label %10
10:
 %11 = load i32, i32* %6
 %12 = icmp slt i32 %11, -123
 br label %13
13:
 %14 = phi i1 [1, %7], [%12, %10]
 br i1 %14, label %15, label %18
15:
 %16 = load i32, i32* %6
 %17 = add i32 %16, 1
 store i32 %17, i32* %6
 br label %7
18:
 %19 = load i32, i32* %6
 %20 = icmp ne i32 %19, 0
 br i1 %20, label %21, label %22
21:
 call void @abort ()
 unreachable
22:
 ret i32 0
}
