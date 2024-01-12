declare void @abort()

define void @foo (i8* %0, i8* %1) {
 %3 = alloca i8*
 %4 = alloca i8*
 store i8* %0, i8** %3
 store i8* %1, i8** %4
 %5 = load i8*, i8** %4
 %6 = getelementptr i32, i8* %5, i32 1
 store i8* %6, i8** %4
 %7 = load i32, i32* %5
 %8 = load i8*, i8** %3
 %9 = getelementptr i8*, i8* %8, i32 1
 store i8* %9, i8** %3
 %10 = load i8*, i8** %8
 %11 = getelementptr i32, i8* %10, i32 1
 store i8* %11, i8** %8
 store i32 %7, i32* %10
 ret void
}

define void @bar (i8* %0, i8* %1) {
 %3 = alloca i8*
 %4 = alloca i8*
 store i8* %0, i8** %3
 store i8* %1, i8** %4
 %5 = load i8*, i8** %4
 %6 = getelementptr i32, i8* %5, i32 1
 store i8* %6, i8** %4
 %7 = load i32, i32* %5
 %8 = load i8*, i8** %3
 %9 = load i8*, i8** %8
 store i32 %7, i32* %9
 %10 = load i8*, i8** %3
 %11 = getelementptr i8*, i8* %10, i32 1
 store i8* %11, i8** %3
 %12 = load i8*, i8** %10
 %13 = getelementptr i32, i8* %12, i32 1
 store i8* %13, i8** %10
 %14 = load i32, i32* %12
 ret void
}

define void @baz (i8* %0, i8* %1) {
 %3 = alloca i8*
 %4 = alloca i8*
 store i8* %0, i8** %3
 store i8* %1, i8** %4
 %5 = load i8*, i8** %4
 %6 = getelementptr i32, i8* %5, i32 1
 store i8* %6, i8** %4
 %7 = load i32, i32* %5
 %8 = load i8*, i8** %3
 %9 = load i8*, i8** %8
 store i32 %7, i32* %9
 %10 = load i8*, i8** %3
 %11 = getelementptr i8*, i8* %10, i32 1
 store i8* %11, i8** %3
 %12 = load i8*, i8** %10
 %13 = getelementptr i32, i8* %12, i32 1
 store i8* %13, i8** %10
 ret void
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 %3 = alloca i32
 %4 = alloca i8*
 store i32 0, i32* %1
 store i32 42, i32* %2
 store i32 0, i32* %3
 store i8* %2, i8** %4
 call void @foo (i8* %4, i8* %3)
 %5 = load i8*, i8** %4
 %6 = getelementptr i32, i8* %5, i64 -1
 %7 = icmp ne i8* %6, %2
 br i1 %7, label %14, label %8
8:
 %9 = load i32, i32* %3
 %10 = icmp ne i32 %9, 0
 br i1 %10, label %14, label %11
11:
 %12 = load i32, i32* %2
 %13 = icmp ne i32 %12, 0
 br i1 %13, label %14, label %15
14:
 call void @abort ()
 unreachable
15:
 store i32 43, i32* %2
 store i8* %2, i8** %4
 call void @bar (i8* %4, i8* %3)
 %16 = load i8*, i8** %4
 %17 = getelementptr i32, i8* %16, i64 -1
 %18 = icmp ne i8* %17, %2
 br i1 %18, label %25, label %19
19:
 %20 = load i32, i32* %3
 %21 = icmp ne i32 %20, 0
 br i1 %21, label %25, label %22
22:
 %23 = load i32, i32* %2
 %24 = icmp ne i32 %23, 0
 br i1 %24, label %25, label %26
25:
 call void @abort ()
 unreachable
26:
 store i32 44, i32* %2
 store i8* %2, i8** %4
 call void @baz (i8* %4, i8* %3)
 %27 = load i8*, i8** %4
 %28 = getelementptr i32, i8* %27, i64 -1
 %29 = icmp ne i8* %28, %2
 br i1 %29, label %36, label %30
30:
 %31 = load i32, i32* %3
 %32 = icmp ne i32 %31, 0
 br i1 %32, label %36, label %33
33:
 %34 = load i32, i32* %2
 %35 = icmp ne i32 %34, 0
 br i1 %35, label %36, label %37
36:
 call void @abort ()
 unreachable
37:
 ret i32 0
}
