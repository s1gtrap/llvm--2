@flag = global i32 0

declare void @abort()

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 store i32 0, i32* %1
 %3 = load i32, i32* @flag
 %4 = icmp ne i32 %3, 0
 br i1 %4, label %5, label %6
5:
 store i32 -1, i32* %2
 br label %9
6:
 %7 = load i32, i32* %2
 %8 = and i32 %7, 255
 store i32 %8, i32* %2
 br label %9
9:
 %10 = load i32, i32* %2
 %11 = and i32 %10, -256
 %12 = icmp ne i32 %11, 0
 br i1 %12, label %13, label %14
13:
 call void @abort ()
 unreachable
14:
 ret i32 0
}
