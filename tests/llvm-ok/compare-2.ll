declare void @abort()

define i32 @foo (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %3
 %6 = load i32, i32* %4
 %7 = icmp sle i32 %5, %6
 br i1 %7, label %8, label %12
8:
 %9 = load i32, i32* %3
 %10 = load i32, i32* %4
 %11 = icmp uge i32 %9, %10
 br label %12
12:
 %13 = phi i1 [0, %2], [%11, %8]
 %14 = zext i1 %13 to i32
 ret i32 %14
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @foo (i32 -1, i32 0)
 %3 = icmp ne i32 %2, 0
 br i1 %3, label %5, label %4
4:
 call void @abort ()
 unreachable
5:
 ret i32 0
}
