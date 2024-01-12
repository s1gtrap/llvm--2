declare void @abort()

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @func_4 (i32 0)
 ret i32 0
}

define i32 @func_4 (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 0, i32* %4
 store i32 1, i32* %3
 br label %5
5:
 %6 = load i32, i32* %3
 %7 = icmp ult i32 %6, 3
 br i1 %7, label %8, label %23
8:
 %9 = load i32, i32* %4
 %10 = add i32 %9, 1
 store i32 %10, i32* %4
 %11 = icmp sgt i32 %9, 1
 br i1 %11, label %12, label %13
12:
 call void @abort ()
 unreachable
13:
 %14 = load i32, i32* %3
 %15 = load i32, i32* %3
 %16 = call i32 @my_shift (i32 %14, i32 %15)
 %17 = icmp ne i32 %16, 0
 br i1 %17, label %18, label %19
18:
 store i32 0, i32* %2
 br label %24
19:
 br label %20
20:
 %21 = load i32, i32* %3
 %22 = call i32 @my_add (i32 %21, i32 1)
 store i32 %22, i32* %3
 br label %5
23:
 store i32 0, i32* %2
 br label %24
24:
 %25 = load i32, i32* %2
 ret i32 %25
}

define i32 @my_shift (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %4
 %6 = icmp ugt i32 %5, 100
 br i1 %6, label %7, label %9
7:
 %8 = load i32, i32* %3
 br label %13
9:
 %10 = load i32, i32* %3
 %11 = load i32, i32* %4
 %12 = lshr i32 %10, %11
 br label %13
13:
 %14 = phi i32 [%8, %7], [%12, %9]
 ret i32 %14
}

define i32 @my_add (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %3
 %6 = load i32, i32* %4
 %7 = sub i32 50, %6
 %8 = icmp ugt i32 %5, %7
 br i1 %8, label %9, label %11
9:
 %10 = load i32, i32* %3
 br label %15
11:
 %12 = load i32, i32* %3
 %13 = load i32, i32* %4
 %14 = add i32 %12, %13
 br label %15
15:
 %16 = phi i32 [%10, %9], [%14, %11]
 ret i32 %16
}
