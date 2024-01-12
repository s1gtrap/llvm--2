@a = global i32 0

declare void @memset(i8*, i8, i64, i1)

define i32 @main () {
 %1 = alloca i32
 %2 = alloca [2 x i8]
 %3 = alloca i8
 store i32 0, i32* %1
 call void @memset (i8* %2, i8 0, i64 2, i1 0)
 store i8 0, i8* %3
 %4 = load i32, i32* @a
 %5 = icmp eq i32 %4, 131072
 br i1 %5, label %6, label %11
6:
 %7 = load i32, i32* @a
 %8 = sext i32 %7 to i64
 %9 = getelementptr [2 x i8], i8* %2, i64 0, i64 %8
 %10 = load i8, i8* %9
 store i8 %10, i8* %3
 br label %11
11:
 %12 = load i8, i8* %3
 %13 = sext i8 %12 to i32
 ret i32 %13
}
