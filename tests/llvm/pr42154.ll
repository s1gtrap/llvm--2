%struct.A = type { [1 x i8] }

declare void @abort()

define void @foo (i8 %0) {
 %2 = alloca %struct.A
 %3 = getelementptr %struct.A, i8* %2, i32 0, i32 0
 store i8 %0, i8* %3
 %4 = getelementptr %struct.A, i8* %2, i32 0, i32 0
 %5 = getelementptr [1 x i8], i8* %4, i64 0, i64 0
 %6 = load i8, i8* %5
 %7 = sext i8 %6 to i32
 %8 = icmp ne i32 %7, 97
 br i1 %8, label %9, label %10
9:
 call void @abort ()
 unreachable
10:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca %struct.A
 %3 = alloca i32
 store i32 0, i32* %1
 store i32 0, i32* %3
 br label %4
4:
 %5 = load i32, i32* %3
 %6 = icmp slt i32 %5, 1
 br i1 %6, label %7, label %15
7:
 %8 = getelementptr %struct.A, i8* %2, i32 0, i32 0
 %9 = load i32, i32* %3
 %10 = sext i32 %9 to i64
 %11 = getelementptr [1 x i8], i8* %8, i64 0, i64 %10
 store i8 97, i8* %11
 br label %12
12:
 %13 = load i32, i32* %3
 %14 = add i32 %13, 1
 store i32 %14, i32* %3
 br label %4
15:
 %16 = getelementptr %struct.A, i8* %2, i32 0, i32 0
 %17 = load i8, i8* %16
 call void @foo (i8 %17)
 ret i32 0
}
