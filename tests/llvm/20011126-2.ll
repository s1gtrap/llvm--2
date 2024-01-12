@.str = global [4 x i8] c"aab\00"

define i32 @main () {
 %1 = alloca i32
 %2 = alloca [4 x i8]
 store i32 0, i32* %1
 %3 = getelementptr [4 x i8], i8* %2, i64 0, i64 0
 %4 = call i8* @test (i8* @.str, i8* %3)
 ret i32 0
}

define i8* @test (i8* %0, i8* %1) {
 %3 = alloca i8*
 %4 = alloca i8*
 %5 = alloca i8*
 store i8* %0, i8** %3
 store i8* %1, i8** %4
 br label %6
6:
 %7 = load i8*, i8** %3
 %8 = load i8, i8* %7
 %9 = sext i8 %8 to i32
 %10 = icmp eq i32 %9, 97
 br i1 %10, label %11, label %41
11:
 %12 = load i8*, i8** %3
 %13 = getelementptr i8, i8* %12, i64 1
 store i8* %13, i8** %5
 br label %14
14:
 %15 = load i8*, i8** %5
 %16 = load i8, i8* %15
 %17 = sext i8 %16 to i32
 %18 = icmp eq i32 %17, 120
 br i1 %18, label %19, label %22
19:
 %20 = load i8*, i8** %5
 %21 = getelementptr i8, i8* %20, i32 1
 store i8* %21, i8** %5
 br label %14
22:
 %23 = load i8*, i8** %5
 %24 = load i8, i8* %23
 %25 = sext i8 %24 to i32
 %26 = icmp eq i32 %25, 98
 br i1 %26, label %27, label %29
27:
 %28 = load i8*, i8** %5
 ret i8* %28
29:
 br label %30
30:
 %31 = load i8*, i8** %3
 %32 = load i8*, i8** %5
 %33 = icmp ult i8* %31, %32
 br i1 %33, label %34, label %40
34:
 %35 = load i8*, i8** %3
 %36 = getelementptr i8, i8* %35, i32 1
 store i8* %36, i8** %3
 %37 = load i8, i8* %35
 %38 = load i8*, i8** %4
 %39 = getelementptr i8, i8* %38, i32 1
 store i8* %39, i8** %4
 store i8 %37, i8* %38
 br label %30
40:
 br label %41
41:
 br label %6
}
