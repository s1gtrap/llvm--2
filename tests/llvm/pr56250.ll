declare void @abort()

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 %3 = alloca i32
 store i32 0, i32* %1
 store i32 2, i32* %2
 %4 = load i32, i32* %2
 %5 = udiv i32 %4, 2
 %6 = sub i32 0, %5
 %7 = udiv i32 %6, 2
 store i32 %7, i32* %3
 %8 = load i32, i32* %2
 %9 = udiv i32 -1, %8
 %10 = load i32, i32* %3
 %11 = icmp ne i32 %9, %10
 br i1 %11, label %12, label %13
12:
 call void @abort ()
 unreachable
13:
 ret i32 0
}
