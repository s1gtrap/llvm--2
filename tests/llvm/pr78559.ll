@g = global i32 20
@d = global i32 0

declare void @abort()

define i16 @fn2 (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %4
 %6 = icmp sge i32 %5, 2
 br i1 %6, label %11, label %7
7:
 %8 = load i32, i32* %4
 %9 = ashr i32 5, %8
 %10 = icmp ne i32 %9, 0
 br i1 %10, label %11, label %13
11:
 %12 = load i32, i32* %3
 br label %17
13:
 %14 = load i32, i32* %3
 %15 = load i32, i32* %4
 %16 = shl i32 %14, %15
 br label %17
17:
 %18 = phi i32 [%12, %11], [%16, %13]
 %19 = trunc i32 %18 to i16
 ret i16 %19
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 %3 = alloca i32
 %4 = alloca i32
 store i32 0, i32* %1
 store i32 0, i32* %2
 br label %5
5:
 %6 = load i32, i32* @g
 %7 = icmp ne i32 %6, 0
 br i1 %7, label %8, label %20
8:
 store i32 -3, i32* %3
 br label %9
9:
 %10 = load i32, i32* %3
 %11 = icmp ne i32 %10, 0
 br i1 %11, label %12, label %19
12:
 %13 = load i32, i32* @g
 %14 = call i16 @fn2 (i32 1, i32 %13)
 %15 = sext i16 %14 to i32
 store i32 %15, i32* %2
 br label %16
16:
 %17 = load i32, i32* %3
 %18 = add i32 %17, 1
 store i32 %18, i32* %3
 br label %9
19:
 br label %33
20:
 store i32 0, i32* %4
 br label %21
21:
 %22 = load i32, i32* %4
 %23 = icmp slt i32 %22, 2
 br i1 %23, label %24, label %32
24:
 %25 = load i32, i32* @d
 %26 = icmp ne i32 %25, 0
 br i1 %26, label %27, label %28
27:
 br label %5
28:
 br label %29
29:
 %30 = load i32, i32* %4
 %31 = add i32 %30, 2
 store i32 %31, i32* %4
 br label %21
32:
 br label %33
33:
 %34 = load i32, i32* %2
 %35 = icmp ne i32 %34, 1
 br i1 %35, label %36, label %37
36:
 call void @abort ()
 unreachable
37:
 ret i32 0
}
