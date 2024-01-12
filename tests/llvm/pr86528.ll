@test.appended = global [4 x i8] c"/./\00"
@.str = global [12 x i8] c"test1234/./\00"
@.str.1 = global [10 x i8] c"test1234/\00"

declare void @memcpy(i8*, i8*, i64, i1)
declare i8* @strcpy(i8*, i8*)
declare i32 @strcmp(i8*, i8*)
declare void @abort()
declare i64 @strlen(i8*)

define void @test (i8* %0, i64 %1) {
 %3 = alloca i8*
 %4 = alloca i64
 %5 = alloca i8*
 store i8* %0, i8** %3
 store i64 %1, i64* %4
 %6 = load i64, i64* %4
 %7 = add i64 %6, 4
 %8 = alloca i8, i64 %7
 store i8* %8, i8** %5
 %9 = load i8*, i8** %5
 %10 = load i8*, i8** %3
 %11 = load i64, i64* %4
 call void @memcpy (i8* %9, i8* %10, i64 %11, i1 0)
 %12 = load i8*, i8** %5
 %13 = load i64, i64* %4
 %14 = getelementptr i8, i8* %12, i64 %13
 %15 = load i8*, i8** %3
 %16 = load i64, i64* %4
 %17 = sub i64 %16, 1
 %18 = getelementptr i8, i8* %15, i64 %17
 %19 = load i8, i8* %18
 %20 = sext i8 %19 to i32
 %21 = icmp eq i32 %20, 47
 %22 = zext i1 %21 to i32
 %23 = sext i32 %22 to i64
 %24 = getelementptr [4 x i8], i8* @test.appended, i64 0, i64 %23
 %25 = call i8* @strcpy (i8* %14, i8* %24)
 %26 = load i8*, i8** %5
 %27 = call i32 @strcmp (i8* %26, i8* @.str)
 %28 = icmp ne i32 %27, 0
 br i1 %28, label %29, label %30
29:
 call void @abort ()
 unreachable
30:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i8*
 store i32 0, i32* %1
 store i8* @.str.1, i8** %2
 %3 = load i8*, i8** %2
 %4 = load i8*, i8** %2
 %5 = call i64 @strlen (i8* %4)
 call void @test (i8* %3, i64 %5)
 ret i32 0
}
