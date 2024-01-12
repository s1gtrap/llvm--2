declare void @abort()

define i32 @main () {
 %1 = alloca i32
 %2 = alloca [10 x i32]
 %3 = alloca i8*
 %4 = alloca i8*
 store i32 0, i32* %1
 %5 = getelementptr [10 x i32], i8* %2, i64 0, i64 1
 store i8* %5, i8** %4
 %6 = load i8*, i8** %4
 %7 = getelementptr i32, i8* %6, i64 -1
 store i8* %7, i8** %3
 %8 = load i8*, i8** %3
 %9 = getelementptr [10 x i32], i8* %2, i64 0, i64 9
 %10 = icmp uge i8* %8, %9
 br i1 %10, label %11, label %12
11:
 call void @abort ()
 unreachable
12:
 ret i32 0
}
