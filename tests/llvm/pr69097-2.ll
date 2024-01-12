declare void @abort()

define i32 @f1 (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %3
 %6 = load i32, i32* %4
 %7 = srem i32 %5, %6
 ret i32 %7
}

define i32 @f2 (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %3
 %6 = load i32, i32* %4
 %7 = sub i32 0, %6
 %8 = srem i32 %5, %7
 ret i32 %8
}

define i32 @f3 (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %6 = load i32, i32* %4
 %7 = sub i32 0, %6
 store i32 %7, i32* %5
 %8 = load i32, i32* %3
 %9 = load i32, i32* %5
 %10 = srem i32 %8, %9
 ret i32 %10
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @f1 (i32 -2147483648, i32 1)
 %3 = icmp ne i32 %2, 0
 br i1 %3, label %10, label %4
4:
 %5 = call i32 @f2 (i32 -2147483648, i32 -1)
 %6 = icmp ne i32 %5, 0
 br i1 %6, label %10, label %7
7:
 %8 = call i32 @f3 (i32 -2147483648, i32 -1)
 %9 = icmp ne i32 %8, 0
 br i1 %9, label %10, label %11
10:
 call void @abort ()
 unreachable
11:
 ret i32 0
}
