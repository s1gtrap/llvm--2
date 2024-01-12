declare void @abort()

define i32 @tar (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = icmp ne i32 %3, 36863
 br i1 %4, label %5, label %6
5:
 call void @abort ()
 unreachable
6:
 ret i32 -1
}

define void @bug (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 store i32 0, i32* %5
 store i32 0, i32* %6
 br label %7
7:
 %8 = load i32, i32* %5
 %9 = icmp ne i32 %8, -1
 br i1 %9, label %10, label %25
10:
 %11 = load i32, i32* %6
 %12 = add i32 %11, 1
 store i32 %12, i32* %6
 %13 = load i32, i32* %6
 %14 = load i32, i32* %3
 %15 = sub i32 %14, 1
 %16 = icmp sgt i32 %13, %15
 br i1 %16, label %17, label %20
17:
 %18 = load i32, i32* %3
 %19 = sub i32 %18, 1
 store i32 %19, i32* %6
 br label %20
20:
 %21 = load i32, i32* %6
 %22 = load i32, i32* %4
 %23 = mul i32 %21, %22
 %24 = call i32 @tar (i32 %23)
 store i32 %24, i32* %5
 br label %7
25:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @bug (i32 5, i32 36863)
 ret i32 0
}
