@a = global i32 1

declare void @abort()

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 %3 = alloca i32
 %4 = alloca i32
 store i32 0, i32* %1
 store i32 -942519458, i32* %3
 %5 = load i32, i32* @a
 %6 = or i32 %5, -2
 store i32 %6, i32* %4
 %7 = load i32, i32* %4
 %8 = icmp eq i32 %7, 0
 br i1 %8, label %9, label %11
9:
 %10 = load i32, i32* %3
 br label %15
11:
 %12 = load i32, i32* %3
 %13 = load i32, i32* %4
 %14 = urem i32 %12, %13
 br label %15
15:
 %16 = phi i32 [%10, %9], [%14, %11]
 store i32 %16, i32* %2
 %17 = load i32, i32* %2
 %18 = load i32, i32* %3
 %19 = icmp ne i32 %17, %18
 br i1 %19, label %20, label %21
20:
 call void @abort ()
 unreachable
21:
 ret i32 0
}
