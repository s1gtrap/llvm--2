%struct.E = type { i32, i8* }
%struct.C = type { i8*, i16, i16 }

declare void @memset(i8*, i8, i64, i1)
declare void @abort()

define i8* @foo (i8* %0, i8* %1) {
 %3 = alloca i8*
 %4 = alloca i8*
 %5 = alloca i8*
 %6 = alloca i8*
 %7 = alloca i8*
 %8 = alloca i8*
 %9 = alloca i8*
 store i8* %0, i8** %3
 store i8* %1, i8** %4
 store i8* null, i8** %5
 store i8* %5, i8** %6
 store i8* null, i8** %7
 store i8* %7, i8** %8
 br label %10
10:
 %11 = load i8*, i8** %4
 %12 = icmp ne i8* %11, null
 br i1 %12, label %13, label %44
13:
 %14 = load i8*, i8** %4
 %15 = getelementptr %struct.E, i8* %14, i32 0, i32 1
 %16 = load i8*, i8** %15
 store i8* %16, i8** %9
 %17 = load i8*, i8** %4
 %18 = getelementptr %struct.E, i8* %17, i32 0, i32 0
 %19 = load i32, i32* %18
 %20 = and i32 %19, 1
 %21 = icmp eq i32 %20, 1
 br i1 %21, label %22, label %32
22:
 %23 = load i8*, i8** %3
 %24 = getelementptr %struct.C, i8* %23, i32 0, i32 2
 %25 = load i16, i16* %24
 %26 = add i16 %25, 1
 store i16 %26, i16* %24
 %27 = load i8*, i8** %4
 %28 = load i8*, i8** %6
 store i8* %27, i8** %28
 %29 = load i8*, i8** %6
 %30 = load i8*, i8** %29
 %31 = getelementptr %struct.E, i8* %30, i32 0, i32 1
 store i8* %31, i8** %6
 br label %42
32:
 %33 = load i8*, i8** %3
 %34 = getelementptr %struct.C, i8* %33, i32 0, i32 1
 %35 = load i16, i16* %34
 %36 = add i16 %35, 1
 store i16 %36, i16* %34
 %37 = load i8*, i8** %4
 %38 = load i8*, i8** %8
 store i8* %37, i8** %38
 %39 = load i8*, i8** %8
 %40 = load i8*, i8** %39
 %41 = getelementptr %struct.E, i8* %40, i32 0, i32 1
 store i8* %41, i8** %8
 br label %42
42:
 %43 = load i8*, i8** %9
 store i8* %43, i8** %4
 br label %10
44:
 %45 = load i8*, i8** %7
 %46 = load i8*, i8** %6
 store i8* %45, i8** %46
 %47 = load i8*, i8** %8
 store i8* null, i8** %47
 %48 = load i8*, i8** %5
 %49 = load i8*, i8** %3
 %50 = getelementptr %struct.C, i8* %49, i32 0, i32 0
 store i8* %48, i8** %50
 %51 = load i8*, i8** %3
 ret i8* %51
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca %struct.C
 %3 = alloca [2 x %struct.E]
 %4 = alloca i8*
 store i32 0, i32* %1
 call void @memset (i8* %2, i8 0, i64 16, i1 0)
 %5 = getelementptr [2 x %struct.E], i8* %3, i64 0, i64 0
 %6 = getelementptr %struct.E, i8* %5, i32 0, i32 0
 store i32 0, i32* %6
 %7 = getelementptr %struct.E, i8* %5, i32 0, i32 1
 %8 = getelementptr [2 x %struct.E], i8* %3, i64 0, i64 1
 store i8* %8, i8** %7
 %9 = getelementptr %struct.E, i8* %5, i64 1
 %10 = getelementptr %struct.E, i8* %9, i32 0, i32 0
 store i32 1, i32* %10
 %11 = getelementptr %struct.E, i8* %9, i32 0, i32 1
 store i8* null, i8** %11
 %12 = getelementptr [2 x %struct.E], i8* %3, i64 0, i64 0
 %13 = call i8* @foo (i8* %2, i8* %12)
 %14 = getelementptr %struct.C, i8* %2, i32 0, i32 1
 %15 = load i16, i16* %14
 %16 = sext i16 %15 to i32
 %17 = icmp ne i32 %16, 1
 br i1 %17, label %23, label %18
18:
 %19 = getelementptr %struct.C, i8* %2, i32 0, i32 2
 %20 = load i16, i16* %19
 %21 = sext i16 %20 to i32
 %22 = icmp ne i32 %21, 1
 br i1 %22, label %23, label %24
23:
 call void @abort ()
 unreachable
24:
 %25 = getelementptr %struct.C, i8* %2, i32 0, i32 0
 %26 = load i8*, i8** %25
 %27 = getelementptr [2 x %struct.E], i8* %3, i64 0, i64 1
 %28 = icmp ne i8* %26, %27
 br i1 %28, label %29, label %30
29:
 call void @abort ()
 unreachable
30:
 %31 = getelementptr [2 x %struct.E], i8* %3, i64 0, i64 1
 %32 = getelementptr %struct.E, i8* %31, i32 0, i32 1
 %33 = load i8*, i8** %32
 %34 = getelementptr [2 x %struct.E], i8* %3, i64 0, i64 0
 %35 = icmp ne i8* %33, %34
 br i1 %35, label %36, label %37
36:
 call void @abort ()
 unreachable
37:
 %38 = getelementptr [2 x %struct.E], i8* %3, i64 0, i64 0
 %39 = getelementptr %struct.E, i8* %38, i32 0, i32 1
 %40 = load i8*, i8** %39
 %41 = icmp ne i8* %40, null
 br i1 %41, label %42, label %43
42:
 call void @abort ()
 unreachable
43:
 ret i32 0
}
