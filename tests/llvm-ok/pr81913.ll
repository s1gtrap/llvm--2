declare void @abort()

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 store i32 0, i32* %1
 %3 = call i32 @b (i8 1, i32 -3639044, i32 -12215549)
 store i32 %3, i32* %2
 %4 = load i32, i32* %2
 %5 = icmp ne i32 %4, -651063088
 br i1 %5, label %6, label %7
6:
 call void @abort ()
 unreachable
7:
 ret i32 0
}

define i32 @b (i8 %0, i32 %1, i32 %2) {
 %4 = alloca i8
 %5 = alloca i32
 %6 = alloca i32
 store i8 %0, i8* %4
 store i32 %1, i32* %5
 store i32 %2, i32* %6
 br label %7
7:
 %8 = load i32, i32* %6
 %9 = add i32 %8, 1
 %10 = load i32, i32* %5
 %11 = add i32 %10, %9
 store i32 %11, i32* %5
 %12 = load i8, i8* %4
 %13 = add i8 %12, -1
 store i8 %13, i8* %4
 br label %14
14:
 %15 = load i8, i8* %4
 %16 = zext i8 %15 to i32
 %17 = load i32, i32* %5
 %18 = trunc i32 %17 to i8
 %19 = zext i8 %18 to i32
 %20 = icmp sge i32 %16, %19
 br i1 %20, label %7, label %21
21:
 %22 = load i32, i32* %5
 ret i32 %22
}
