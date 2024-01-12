declare void @abort()

define i32 @g (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i32
 store i32 %0, i32* %4
 store i32 %1, i32* %5
 %6 = load i32, i32* %4
 %7 = icmp sgt i32 %6, -1
 br i1 %7, label %8, label %22
8:
 %9 = load i32, i32* %4
 %10 = icmp slt i32 %9, 2
 br i1 %10, label %11, label %21
11:
 %12 = load i32, i32* %4
 %13 = load i32, i32* %5
 %14 = icmp ne i32 %12, %13
 br i1 %14, label %15, label %20
15:
 %16 = load i32, i32* %5
 %17 = icmp ne i32 %16, 0
 br i1 %17, label %18, label %19
18:
 store i32 0, i32* %3
 br label %23
19:
 br label %20
20:
 br label %21
21:
 br label %22
22:
 store i32 1, i32* %3
 br label %23
23:
 %24 = load i32, i32* %3
 ret i32 %24
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @g (i32 1, i32 0)
 %3 = icmp ne i32 %2, 0
 br i1 %3, label %5, label %4
4:
 call void @abort ()
 unreachable
5:
 ret i32 0
}
