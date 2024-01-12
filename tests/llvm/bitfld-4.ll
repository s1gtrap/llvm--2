@x = global { i8, i8, i8, i8 } {i8 -123, i8 -113, i8 -29, i8 -1}

declare void @abort()

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = load i32, i32* @x
 %3 = shl i32 %2, 20
 %4 = ashr i32 %3, 20
 %5 = icmp ne i32 %4, -123
 br i1 %5, label %10, label %6
6:
 %7 = load i32, i32* @x
 %8 = ashr i32 %7, 12
 %9 = icmp ne i32 %8, -456
 br i1 %9, label %10, label %11
10:
 call void @abort ()
 unreachable
11:
 ret i32 0
}
