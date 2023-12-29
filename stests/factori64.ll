@.str = global [3 x i8] c"2 \00"
@.str.1 = global [6 x i8] c"%llu \00"

declare i32 @printf(i8*, ...)
declare i64 @strtoull(i8*, i8*, i32)

define i32 @fac (i64 %0) {
 %2 = alloca i64
 %3 = alloca i32
 %4 = alloca i64
 store i64 %0, i64* %2
 store i32 0, i32* %3
 br label %5
5:
 %6 = load i64, i64* %2
 %7 = and i64 %6, 1
 %8 = icmp eq i64 %7, 0
 br i1 %8, label %9, label %16
9:
 %10 = call i32 (i8*, ...) @printf (i8* @.str)
 br label %11
11:
 %12 = load i64, i64* %2
 %13 = udiv i64 %12, 2
 store i64 %13, i64* %2
 %14 = load i32, i32* %3
 %15 = add i32 %14, 1
 store i32 %15, i32* %3
 br label %5
16:
 store i64 3, i64* %4
 br label %17
17:
 %18 = load i64, i64* %4
 %19 = load i64, i64* %4
 %20 = mul i64 %18, %19
 %21 = load i64, i64* %2
 %22 = icmp ule i64 %20, %21
 br i1 %22, label %23, label %42
23:
 br label %24
24:
 %25 = load i64, i64* %2
 %26 = load i64, i64* %4
 %27 = urem i64 %25, %26
 %28 = icmp eq i64 %27, 0
 br i1 %28, label %29, label %38
29:
 %30 = load i64, i64* %4
 %31 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %30)
 br label %32
32:
 %33 = load i64, i64* %4
 %34 = load i64, i64* %2
 %35 = udiv i64 %34, %33
 store i64 %35, i64* %2
 %36 = load i32, i32* %3
 %37 = add i32 %36, 1
 store i32 %37, i32* %3
 br label %24
38:
 br label %39
39:
 %40 = load i64, i64* %4
 %41 = add i64 %40, 2
 store i64 %41, i64* %4
 br label %17
42:
 %43 = load i64, i64* %2
 %44 = icmp ugt i64 %43, 2
 br i1 %44, label %45, label %50
45:
 %46 = load i64, i64* %2
 %47 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %46)
 %48 = load i32, i32* %3
 %49 = add i32 %48, 1
 store i32 %49, i32* %3
 br label %50
50:
 %51 = load i32, i32* %3
 ret i32 %51
}

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 %6 = load i8*, i8** %5
 %7 = getelementptr i8*, i8** %6, i64 1
 %8 = load i8*, i8** %7
 %9 = call i64 @strtoull (i8* %8, i8* null, i32 10)
 %10 = call i32 @fac (i64 %9)
 ret i32 %10
}
