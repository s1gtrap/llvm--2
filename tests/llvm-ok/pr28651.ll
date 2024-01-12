declare void @abort()

define i32 @foo (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = add i32 %3, 4
 %5 = load i32, i32* %2
 %6 = icmp slt i32 %4, %5
 %7 = zext i1 %6 to i32
 ret i32 %7
}

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 %6 = alloca i32
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 store i32 2147483647, i32* %6
 %7 = load i32, i32* %6
 %8 = call i32 @foo (i32 %7)
 %9 = icmp eq i32 %8, 0
 br i1 %9, label %10, label %11
10:
 call void @abort ()
 unreachable
11:
 ret i32 0
}
