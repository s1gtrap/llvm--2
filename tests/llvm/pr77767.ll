declare void @abort()

define void @foo (i32 %0, i8* %1, i32 %2, i8* %3) {
 %5 = alloca i32
 %6 = alloca i8*
 %7 = alloca i32
 %8 = alloca i8*
 store i32 %0, i32* %5
 store i8* %1, i8** %6
 store i32 %2, i32* %7
 store i8* %3, i8** %8
 %9 = load i32, i32* %5
 %10 = add i32 %9, 1
 store i32 %10, i32* %5
 %11 = zext i32 %9 to i64
 %12 = load i32, i32* %7
 %13 = add i32 %12, 1
 store i32 %13, i32* %7
 %14 = zext i32 %12 to i64
 %15 = load i32, i32* %5
 %16 = icmp ne i32 %15, 2
 br i1 %16, label %20, label %17
17:
 %18 = load i32, i32* %7
 %19 = icmp ne i32 %18, 2
 br i1 %19, label %20, label %21
20:
 call void @abort ()
 unreachable
21:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca [10 x i32]
 store i32 0, i32* %1
 %3 = getelementptr [10 x i32], i8* %2, i64 0, i64 0
 %4 = getelementptr [10 x i32], i8* %2, i64 0, i64 0
 call void @foo (i32 1, i8* %3, i32 1, i8* %4)
 ret i32 0
}
