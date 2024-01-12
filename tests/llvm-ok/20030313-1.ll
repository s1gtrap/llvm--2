%struct.A = type { i64, i64, i64, i64 }

@x = global %struct.A {i64 13, i64 14, i64 15, i64 16}

declare void @abort()
declare void @exit(i32)

define void @foo (i8* %0, i32 %1) {
 %3 = alloca i8*
 %4 = alloca i32
 store i8* %0, i8** %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %4
 %6 = icmp ne i32 %5, 12
 br i1 %6, label %7, label %8
7:
 call void @abort ()
 unreachable
8:
 %9 = load i8*, i8** %3
 %10 = getelementptr i64, i8* %9, i64 0
 %11 = load i64, i64* %10
 %12 = icmp ne i64 %11, 1
 br i1 %12, label %18, label %13
13:
 %14 = load i8*, i8** %3
 %15 = getelementptr i64, i8* %14, i64 1
 %16 = load i64, i64* %15
 %17 = icmp ne i64 %16, 11
 br i1 %17, label %18, label %19
18:
 call void @abort ()
 unreachable
19:
 %20 = load i8*, i8** %3
 %21 = getelementptr i64, i8* %20, i64 2
 %22 = load i64, i64* %21
 %23 = icmp ne i64 %22, 2
 br i1 %23, label %29, label %24
24:
 %25 = load i8*, i8** %3
 %26 = getelementptr i64, i8* %25, i64 3
 %27 = load i64, i64* %26
 %28 = icmp ne i64 %27, 12
 br i1 %28, label %29, label %30
29:
 call void @abort ()
 unreachable
30:
 %31 = load i8*, i8** %3
 %32 = getelementptr i64, i8* %31, i64 4
 %33 = load i64, i64* %32
 %34 = icmp ne i64 %33, 3
 br i1 %34, label %40, label %35
35:
 %36 = load i8*, i8** %3
 %37 = getelementptr i64, i8* %36, i64 5
 %38 = load i64, i64* %37
 %39 = icmp ne i64 %38, 13
 br i1 %39, label %40, label %41
40:
 call void @abort ()
 unreachable
41:
 %42 = load i8*, i8** %3
 %43 = getelementptr i64, i8* %42, i64 6
 %44 = load i64, i64* %43
 %45 = icmp ne i64 %44, 4
 br i1 %45, label %51, label %46
46:
 %47 = load i8*, i8** %3
 %48 = getelementptr i64, i8* %47, i64 7
 %49 = load i64, i64* %48
 %50 = icmp ne i64 %49, 14
 br i1 %50, label %51, label %52
51:
 call void @abort ()
 unreachable
52:
 %53 = load i8*, i8** %3
 %54 = getelementptr i64, i8* %53, i64 8
 %55 = load i64, i64* %54
 %56 = icmp ne i64 %55, 5
 br i1 %56, label %62, label %57
57:
 %58 = load i8*, i8** %3
 %59 = getelementptr i64, i8* %58, i64 9
 %60 = load i64, i64* %59
 %61 = icmp ne i64 %60, 15
 br i1 %61, label %62, label %63
62:
 call void @abort ()
 unreachable
63:
 %64 = load i8*, i8** %3
 %65 = getelementptr i64, i8* %64, i64 10
 %66 = load i64, i64* %65
 %67 = icmp ne i64 %66, 6
 br i1 %67, label %73, label %68
68:
 %69 = load i8*, i8** %3
 %70 = getelementptr i64, i8* %69, i64 11
 %71 = load i64, i64* %70
 %72 = icmp ne i64 %71, 16
 br i1 %72, label %73, label %74
73:
 call void @abort ()
 unreachable
74:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca [40 x i64]
 %3 = alloca i32
 store i32 0, i32* %1
 store i32 0, i32* %3
 %4 = load i32, i32* %3
 %5 = add i32 %4, 1
 store i32 %5, i32* %3
 %6 = sext i32 %4 to i64
 %7 = getelementptr [40 x i64], i8* %2, i64 0, i64 %6
 store i64 1, i64* %7
 %8 = load i32, i32* %3
 %9 = add i32 %8, 1
 store i32 %9, i32* %3
 %10 = sext i32 %8 to i64
 %11 = getelementptr [40 x i64], i8* %2, i64 0, i64 %10
 store i64 11, i64* %11
 %12 = load i32, i32* %3
 %13 = add i32 %12, 1
 store i32 %13, i32* %3
 %14 = sext i32 %12 to i64
 %15 = getelementptr [40 x i64], i8* %2, i64 0, i64 %14
 store i64 2, i64* %15
 %16 = load i32, i32* %3
 %17 = add i32 %16, 1
 store i32 %17, i32* %3
 %18 = sext i32 %16 to i64
 %19 = getelementptr [40 x i64], i8* %2, i64 0, i64 %18
 store i64 12, i64* %19
 %20 = load i32, i32* %3
 %21 = add i32 %20, 1
 store i32 %21, i32* %3
 %22 = sext i32 %20 to i64
 %23 = getelementptr [40 x i64], i8* %2, i64 0, i64 %22
 store i64 3, i64* %23
 %24 = call i8* @bar ()
 %25 = getelementptr %struct.A, i8* %24, i32 0, i32 0
 %26 = load i64, i64* %25
 %27 = load i32, i32* %3
 %28 = add i32 %27, 1
 store i32 %28, i32* %3
 %29 = sext i32 %27 to i64
 %30 = getelementptr [40 x i64], i8* %2, i64 0, i64 %29
 store i64 %26, i64* %30
 %31 = load i32, i32* %3
 %32 = add i32 %31, 1
 store i32 %32, i32* %3
 %33 = sext i32 %31 to i64
 %34 = getelementptr [40 x i64], i8* %2, i64 0, i64 %33
 store i64 4, i64* %34
 %35 = call i8* @bar ()
 %36 = getelementptr %struct.A, i8* %35, i32 0, i32 1
 %37 = load i64, i64* %36
 %38 = load i32, i32* %3
 %39 = add i32 %38, 1
 store i32 %39, i32* %3
 %40 = sext i32 %38 to i64
 %41 = getelementptr [40 x i64], i8* %2, i64 0, i64 %40
 store i64 %37, i64* %41
 %42 = load i32, i32* %3
 %43 = add i32 %42, 1
 store i32 %43, i32* %3
 %44 = sext i32 %42 to i64
 %45 = getelementptr [40 x i64], i8* %2, i64 0, i64 %44
 store i64 5, i64* %45
 %46 = call i8* @bar ()
 %47 = getelementptr %struct.A, i8* %46, i32 0, i32 2
 %48 = load i64, i64* %47
 %49 = load i32, i32* %3
 %50 = add i32 %49, 1
 store i32 %50, i32* %3
 %51 = sext i32 %49 to i64
 %52 = getelementptr [40 x i64], i8* %2, i64 0, i64 %51
 store i64 %48, i64* %52
 %53 = load i32, i32* %3
 %54 = add i32 %53, 1
 store i32 %54, i32* %3
 %55 = sext i32 %53 to i64
 %56 = getelementptr [40 x i64], i8* %2, i64 0, i64 %55
 store i64 6, i64* %56
 %57 = call i8* @bar ()
 %58 = getelementptr %struct.A, i8* %57, i32 0, i32 3
 %59 = load i64, i64* %58
 %60 = load i32, i32* %3
 %61 = add i32 %60, 1
 store i32 %61, i32* %3
 %62 = sext i32 %60 to i64
 %63 = getelementptr [40 x i64], i8* %2, i64 0, i64 %62
 store i64 %59, i64* %63
 %64 = getelementptr [40 x i64], i8* %2, i64 0, i64 0
 %65 = load i32, i32* %3
 call void @foo (i8* %64, i32 %65)
 call void @exit (i32 0)
 unreachable
}

define i8* @bar () {
 %1 = alloca i8*
 store i8* @x, i8** %1
 %2 = load i8*, i8** %1
 ret i8* %2
}
