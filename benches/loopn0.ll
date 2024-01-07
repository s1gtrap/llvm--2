declare i64 @strtoull(i8*, i8*, i32)

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 %6 = alloca i64
 %7 = alloca i32
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 %8 = load i8*, i8** %5
 %9 = getelementptr i8*, i8* %8, i64 1
 %10 = load i8*, i8** %9
 %11 = call i64 @strtoull (i8* %10, i8* null, i32 10)
 store i64 %11, i64* %6
 store i32 0, i32* %7
 br label %12
12:
 %13 = load i32, i32* %7
 %14 = sext i32 %13 to i64
 %15 = load i64, i64* %6
 %16 = icmp ult i64 %14, %15
 br i1 %16, label %17, label %20
17:
 %18 = load i32, i32* %7
 %19 = add i32 %18, 1
 store i32 %19, i32* %7
 br label %12
20:
 ret i32 0
}
