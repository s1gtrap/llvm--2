declare void @abort()

define i32 @foo (i32 %0) {
 %2 = alloca i32
 %3 = alloca [32 x i32]
 store i32 %0, i32* %2
 %4 = getelementptr [32 x i32], i8* %3, i64 0, i64 1
 store i32 3, i32* %4
 %5 = getelementptr [32 x i32], i8* %3, i64 0, i64 0
 store i32 1, i32* %5
 %6 = load i32, i32* %2
 %7 = sext i32 %6 to i64
 %8 = getelementptr [32 x i32], i8* %3, i64 0, i64 %7
 store i32 2, i32* %8
 %9 = getelementptr [32 x i32], i8* %3, i64 0, i64 0
 %10 = load i32, i32* %9
 ret i32 %10
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @foo (i32 0)
 %3 = icmp ne i32 %2, 2
 br i1 %3, label %7, label %4
4:
 %5 = call i32 @foo (i32 1)
 %6 = icmp ne i32 %5, 1
 br i1 %6, label %7, label %8
7:
 call void @abort ()
 unreachable
8:
 ret i32 0
}
