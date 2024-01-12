declare void @abort()
declare void @exit(i32)

define void @foo (i8* %0, i32 %1) {
 %3 = alloca i8*
 %4 = alloca i32
 %5 = alloca i8
 %6 = alloca i8*
 %7 = alloca i8*
 store i8* %0, i8** %3
 store i32 %1, i32* %4
 %8 = load i8*, i8** %3
 %9 = load i32, i32* %4
 %10 = zext i32 %9 to i64
 %11 = getelementptr i8, i8* %8, i64 %10
 store i8* %11, i8** %6
 br label %12
12:
 %13 = load i8*, i8** %3
 %14 = load i8*, i8** %6
 %15 = icmp ult i8* %13, %14
 br i1 %15, label %16, label %39
16:
 %17 = load i8*, i8** %3
 %18 = getelementptr i8, i8* %17, i64 3
 store i8* %18, i8** %7
 %19 = load i8*, i8** %7
 %20 = load i8, i8* %19
 store i8 %20, i8* %5
 %21 = load i8*, i8** %3
 %22 = load i8, i8* %21
 %23 = load i8*, i8** %7
 store i8 %22, i8* %23
 %24 = load i8, i8* %5
 %25 = load i8*, i8** %3
 %26 = getelementptr i8, i8* %25, i32 1
 store i8* %26, i8** %3
 store i8 %24, i8* %25
 %27 = load i8*, i8** %3
 %28 = getelementptr i8, i8* %27, i64 1
 store i8* %28, i8** %7
 %29 = load i8*, i8** %7
 %30 = load i8, i8* %29
 store i8 %30, i8* %5
 %31 = load i8*, i8** %3
 %32 = load i8, i8* %31
 %33 = load i8*, i8** %7
 store i8 %32, i8* %33
 %34 = load i8, i8* %5
 %35 = load i8*, i8** %3
 %36 = getelementptr i8, i8* %35, i32 1
 store i8* %36, i8** %3
 store i8 %34, i8* %35
 %37 = load i8*, i8** %3
 %38 = getelementptr i8, i8* %37, i64 2
 store i8* %38, i8** %3
 br label %12
39:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 store i32 0, i32* %1
 store i32 1, i32* %2
 call void @foo (i8* %2, i32 4)
 call void @foo (i8* %2, i32 4)
 %3 = load i32, i32* %2
 %4 = icmp ne i32 %3, 1
 br i1 %4, label %5, label %6
5:
 call void @abort ()
 unreachable
6:
 call void @exit (i32 0)
 unreachable
}
