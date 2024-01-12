declare void @abort()

define i32 @foo (i8* %0, i32 %1) {
 %3 = alloca i8*
 %4 = alloca i32
 %5 = alloca i8*
 %6 = alloca i8*
 %7 = alloca i32
 %8 = alloca i32
 store i8* %0, i8** %3
 store i32 %1, i32* %4
 %9 = load i8*, i8** %3
 %10 = getelementptr i32, i8* %9, i64 1
 store i8* %10, i8** %5
 %11 = load i8*, i8** %5
 %12 = load i32, i32* %4
 %13 = sext i32 %12 to i64
 %14 = sub i64 0, %13
 %15 = getelementptr i32, i8* %11, i64 %14
 store i8* %15, i8** %6
 %16 = load i8*, i8** %6
 %17 = load i32, i32* %16
 store i32 %17, i32* %7
 %18 = load i8*, i8** %3
 store i32 1, i32* %18
 %19 = load i8*, i8** %6
 %20 = load i32, i32* %19
 store i32 %20, i32* %8
 %21 = load i32, i32* %7
 %22 = load i32, i32* %8
 %23 = add i32 %21, %22
 ret i32 %23
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 store i32 0, i32* %1
 store i32 0, i32* %2
 %3 = call i32 @foo (i8* %2, i32 1)
 %4 = icmp ne i32 %3, 1
 br i1 %4, label %5, label %6
5:
 call void @abort ()
 unreachable
6:
 ret i32 0
}
