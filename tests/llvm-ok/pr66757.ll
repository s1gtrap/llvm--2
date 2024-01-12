@b = global i32 0
@a = global i32 0

declare void @abort()

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 store i32 0, i32* %1
 %3 = load i32, i32* @b
 %4 = xor i32 %3, -1
 %5 = trunc i32 %4 to i8
 %6 = zext i8 %5 to i32
 store i32 %6, i32* %2
 %7 = load i32, i32* %2
 %8 = xor i32 %7, 1
 %9 = udiv i32 %8, 255
 %10 = icmp ne i32 %9, 0
 br i1 %10, label %11, label %12
11:
 call void @abort ()
 unreachable
12:
 ret i32 0
}
