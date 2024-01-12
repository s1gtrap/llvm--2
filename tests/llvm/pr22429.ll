declare void @abort()

define i32 @f (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 store i32 %0, i32* %3
 %4 = load i32, i32* %3
 %5 = icmp sle i32 -1073741824, %4
 br i1 %5, label %6, label %10
6:
 %7 = load i32, i32* %3
 %8 = icmp sle i32 %7, 1073741823
 br i1 %8, label %9, label %10
9:
 store i32 1, i32* %2
 br label %11
10:
 store i32 0, i32* %2
 br label %11
11:
 %12 = load i32, i32* %2
 ret i32 %12
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @f (i32 1073741824)
 %3 = icmp ne i32 %2, 0
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 ret i32 0
}
