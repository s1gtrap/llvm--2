@__const.main.a = global [18 x i64] [i64 4, i64 2, i64 -200, i64 200, i64 2, i64 -400, i64 400, i64 3, i64 -600, i64 0, i64 600, i64 5, i64 -100, i64 -66, i64 0, i64 66, i64 100, i64 1152921504606846976]

declare void @llvm.memcpy.p0.p0.i64(i8*, i8*, i64, i1)
declare void @abort()

define i64 @bar (i8* %0) {
 %2 = alloca i8*
 %3 = alloca i64
 %4 = alloca i64
 %5 = alloca i64
 %6 = alloca i8*
 %7 = alloca i64
 %8 = alloca i64
 %9 = alloca i64
 store i8* %0, i8** %2
 store i64 1, i64* %4
 store i64 0, i64* %8
 %10 = load i8*, i8** %2
 %11 = load i64, i64* %10
 %12 = sub i64 %11, 1
 store i64 %12, i64* %5
 br label %13
13:
 %14 = load i64, i64* %5
 %15 = icmp ugt i64 %14, 0
 br i1 %15, label %16, label %66
16:
 %17 = load i8*, i8** %2
 %18 = getelementptr i64, i8* %17, i64 1
 %19 = call i8* @foo (i8* %18)
 store i8* %19, i8** %6
 store i64 1, i64* %9
 br label %20
20:
 %21 = load i64, i64* %9
 %22 = load i64, i64* %5
 %23 = icmp ult i64 %21, %22
 br i1 %23, label %24, label %30
24:
 %25 = load i8*, i8** %6
 %26 = call i8* @foo (i8* %25)
 store i8* %26, i8** %6
 br label %27
27:
 %28 = load i64, i64* %9
 %29 = add i64 %28, 1
 store i64 %29, i64* %9
 br label %20
30:
 %31 = load i8*, i8** %6
 %32 = load i64, i64* %31
 store i64 %32, i64* %3
 %33 = load i64, i64* %3
 %34 = icmp eq i64 %33, 2
 br i1 %34, label %35, label %38
35:
 %36 = load i64, i64* %4
 %37 = mul i64 %36, 2
 store i64 %37, i64* %4
 br label %62
38:
 %39 = load i64, i64* %3
 %40 = sub i64 %39, 1
 %41 = udiv i64 %40, 2
 %42 = sub i64 %41, 1
 store i64 %42, i64* %9
 %43 = load i64, i64* %9
 %44 = mul i64 2, %43
 %45 = add i64 %44, 1
 %46 = load i64, i64* %4
 %47 = add i64 %46, 1
 %48 = mul i64 %45, %47
 %49 = load i64, i64* %4
 %50 = mul i64 2, %49
 %51 = add i64 %50, 1
 %52 = add i64 %48, %51
 store i64 %52, i64* %7
 %53 = load i64, i64* %7
 %54 = load i64, i64* %8
 %55 = icmp ugt i64 %53, %54
 br i1 %55, label %56, label %58
56:
 %57 = load i64, i64* %7
 store i64 %57, i64* %8
 br label %58
58:
 %59 = load i64, i64* %3
 %60 = load i64, i64* %4
 %61 = mul i64 %60, %59
 store i64 %61, i64* %4
 br label %62
62:
 br label %63
63:
 %64 = load i64, i64* %5
 %65 = add i64 %64, -1
 store i64 %65, i64* %5
 br label %13
66:
 %67 = load i64, i64* %8
 ret i64 %67
}

define i8* @foo (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 %3 = load i8*, i8** %2
 %4 = load i8*, i8** %2
 %5 = load i64, i64* %4
 %6 = add i64 1, %5
 %7 = getelementptr i64, i8* %3, i64 %6
 ret i8* %7
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca [18 x i64]
 store i32 0, i32* %1
 call void @memcpy (i8* %2, i8* @__const.main.a, i64 144, i1 0)
 %3 = getelementptr [18 x i64], i8* %2, i64 0, i64 0
 %4 = call i64 @bar (i8* %3)
 %5 = icmp ne i64 %4, 17
 br i1 %5, label %6, label %7
6:
 call void @abort ()
 unreachable
7:
 ret i32 0
}
