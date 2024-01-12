declare void @abort()

define i32 @f (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i32
 store i32 %0, i32* %4
 store i32 %1, i32* %5
 %6 = load i32, i32* %4
 %7 = icmp eq i32 %6, 1
 br i1 %7, label %8, label %9
8:
 store i32 0, i32* %4
 br label %9
9:
 %10 = load i32, i32* %5
 %11 = icmp eq i32 %10, 0
 br i1 %11, label %12, label %13
12:
 store i32 1, i32* %4
 br label %13
13:
 %14 = load i32, i32* %4
 %15 = icmp ne i32 %14, 0
 br i1 %15, label %16, label %17
16:
 store i32 0, i32* %3
 br label %18
17:
 store i32 1, i32* %3
 br label %18
18:
 %19 = load i32, i32* %3
 ret i32 %19
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @f (i32 1, i32 1)
 %3 = icmp ne i32 %2, 1
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 ret i32 0
}
