@.str = global [11 x i8] c"0123456789\00"

declare i8* @strcpy(i8*, i8*)
declare void @abort()

define i8 @test (i32 %0) {
 %2 = alloca i32
 %3 = alloca [16 x i8]
 %4 = alloca i8*
 store i32 %0, i32* %2
 %5 = getelementptr [16 x i8], i8* %3, i64 0, i64 0
 store i8* %5, i8** %4
 %6 = getelementptr [16 x i8], i8* %3, i64 0, i64 0
 %7 = call i8* @strcpy (i8* %6, i8* @.str)
 %8 = load i32, i32* %2
 %9 = load i8*, i8** %4
 %10 = sext i32 %8 to i64
 %11 = getelementptr i8, i8* %9, i64 %10
 store i8* %11, i8** %4
 %12 = load i8*, i8** %4
 %13 = getelementptr i8, i8* %12, i64 -1
 store i8* %13, i8** %4
 %14 = load i8*, i8** %4
 %15 = getelementptr i8, i8* %14, i64 0
 %16 = load i8, i8* %15
 ret i8 %16
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i8 @test (i32 2)
 %3 = sext i8 %2 to i32
 %4 = icmp ne i32 %3, 49
 br i1 %4, label %5, label %6
5:
 call void @abort ()
 unreachable
6:
 ret i32 0
}
