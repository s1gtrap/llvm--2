@.str = global [5 x i8] c"Bbb:\00"

define i8* @foo (i8* %0) {
 %2 = alloca i8*
 %3 = alloca i8*
 %4 = alloca i32
 %5 = alloca i32
 store i8* %0, i8** %2
 store i32 1, i32* %4
 br label %6
6:
 %7 = load i8*, i8** %2
 %8 = load i8, i8* %7
 %9 = sext i8 %8 to i32
 store i32 %9, i32* %5
 %10 = load i32, i32* %5
 %11 = icmp sge i32 %10, 97
 br i1 %11, label %12, label %19
12:
 %13 = load i32, i32* %5
 %14 = icmp sle i32 %13, 122
 br i1 %14, label %15, label %19
15:
 %16 = load i32, i32* %5
 %17 = sub i32 %16, 97
 %18 = add i32 %17, 65
 br label %21
19:
 %20 = load i32, i32* %5
 br label %21
21:
 %22 = phi i32 [%18, %15], [%20, %19]
 store i32 %22, i32* %5
 %23 = load i32, i32* %5
 %24 = icmp eq i32 %23, 66
 br i1 %24, label %25, label %27
25:
 %26 = load i8*, i8** %2
 store i8* %26, i8** %3
 br label %43
27:
 %28 = load i32, i32* %5
 %29 = icmp eq i32 %28, 65
 br i1 %29, label %30, label %41
30:
 %31 = load i8*, i8** %2
 store i8* %31, i8** %3
 br label %32
32:
 %33 = load i8*, i8** %2
 %34 = getelementptr i8, i8* %33, i32 1
 store i8* %34, i8** %2
 br label %35
35:
 %36 = load i8*, i8** %2
 %37 = load i8, i8* %36
 %38 = sext i8 %37 to i32
 %39 = icmp eq i32 %38, 43
 br i1 %39, label %32, label %40
40:
 br label %42
41:
 br label %48
42:
 br label %43
43:
 %44 = load i8*, i8** %2
 %45 = getelementptr i8, i8* %44, i32 1
 store i8* %45, i8** %2
 %46 = load i32, i32* %4
 %47 = add i32 %46, 1
 store i32 %47, i32* %4
 br label %6
48:
 %49 = load i32, i32* %4
 %50 = icmp sgt i32 %49, 2
 br i1 %50, label %51, label %58
51:
 %52 = load i8*, i8** %2
 %53 = load i8, i8* %52
 %54 = sext i8 %53 to i32
 %55 = icmp eq i32 %54, 58
 br i1 %55, label %56, label %58
56:
 %57 = load i8*, i8** %3
 store i8* %57, i8** %2
 br label %58
58:
 %59 = load i8*, i8** %2
 ret i8* %59
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i8*
 store i32 0, i32* %1
 store i8* @.str, i8** %2
 %3 = load i8*, i8** %2
 %4 = call i8* @foo (i8* %3)
 %5 = load i8*, i8** %2
 %6 = getelementptr i8, i8* %5, i64 2
 %7 = icmp ne i8* %4, %6
 %8 = zext i1 %7 to i32
 ret i32 %8
}
