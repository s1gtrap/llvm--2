@.str = global [4 x i8] c"%p\0A\00"
@.str.1 = global [4 x i8] c"%d\0A\00"
@.str.2 = global [5 x i8] c"%lld\00"
@.str.3 = global [6 x i8] c"%lld\0A\00"

declare i8* @malloc(i64)
declare i32 @printf(i8*, ...)
declare i32 @scanf(i8*, ...)
declare i8* @realloc(i8*, i64)
declare void @free(i8*)

define i32 @read_ints (i8* %0) {
 %2 = alloca i8*
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i32
 store i8* %0, i8** %2
 %6 = call i8* @malloc (i64 64)
 %7 = load i8*, i8** %2
 store i8* %6, i8** %7
 %8 = load i8*, i8** %2
 %9 = call i32 (i8*, ...) @printf (i8* @.str, i8* %8)
 %10 = load i8*, i8** %2
 %11 = load i8*, i8** %10
 %12 = call i32 (i8*, ...) @printf (i8* @.str, i8* %11)
 store i32 0, i32* %3
 store i32 0, i32* %4
 br label %13
13:
 %14 = load i32, i32* %4
 %15 = mul i32 %14, 8
 store i32 %15, i32* %5
 br label %16
16:
 %17 = load i32, i32* %5
 %18 = load i32, i32* %4
 %19 = add i32 %18, 1
 %20 = mul i32 %19, 8
 %21 = icmp slt i32 %17, %20
 br i1 %21, label %22, label %58
22:
 %23 = load i8*, i8** %2
 %24 = call i32 (i8*, ...) @printf (i8* @.str, i8* %23)
 %25 = load i8*, i8** %2
 %26 = load i8*, i8** %25
 %27 = call i32 (i8*, ...) @printf (i8* @.str, i8* %26)
 %28 = load i32, i32* %3
 %29 = call i32 (i8*, ...) @printf (i8* @.str.1, i32 %28)
 %30 = load i8*, i8** %2
 %31 = load i8*, i8** %30
 %32 = load i32, i32* %3
 %33 = sext i32 %32 to i64
 %34 = getelementptr i64, i8* %31, i64 %33
 %35 = call i32 (i8*, ...) @printf (i8* @.str, i8* %34)
 %36 = load i8*, i8** %2
 %37 = load i8*, i8** %36
 %38 = load i32, i32* %3
 %39 = sext i32 %38 to i64
 %40 = getelementptr i64, i8* %37, i64 %39
 %41 = call i32 (i8*, ...) @scanf (i8* @.str.2, i8* %40)
 %42 = icmp eq i32 %41, -1
 br i1 %42, label %43, label %45
43:
 %44 = load i32, i32* %3
 ret i32 %44
45:
 %46 = load i8*, i8** %2
 %47 = load i8*, i8** %46
 %48 = load i32, i32* %3
 %49 = sext i32 %48 to i64
 %50 = getelementptr i64, i8* %47, i64 %49
 %51 = load i64, i64* %50
 %52 = call i32 (i8*, ...) @printf (i8* @.str.3, i64 %51)
 br label %53
53:
 %54 = load i32, i32* %5
 %55 = add i32 %54, 1
 store i32 %55, i32* %5
 %56 = load i32, i32* %3
 %57 = add i32 %56, 1
 store i32 %57, i32* %3
 br label %16
58:
 %59 = load i8*, i8** %2
 %60 = load i8*, i8** %59
 %61 = load i32, i32* %4
 %62 = add i32 %61, 2
 %63 = mul i32 %62, 8
 %64 = sext i32 %63 to i64
 %65 = mul i64 %64, 8
 %66 = call i8* @realloc (i8* %60, i64 %65)
 %67 = load i8*, i8** %2
 store i8* %66, i8** %67
 %68 = load i8*, i8** %2
 %69 = load i8*, i8** %68
 %70 = call i32 (i8*, ...) @printf (i8* @.str, i8* %69)
 br label %71
71:
 %72 = load i32, i32* %4
 %73 = add i32 %72, 1
 store i32 %73, i32* %4
 br label %13
}

define void @print_ints (i8* %0, i32 %1) {
 %3 = alloca i8*
 %4 = alloca i32
 %5 = alloca i32
 store i8* %0, i8** %3
 store i32 %1, i32* %4
 store i32 0, i32* %5
 br label %6
6:
 %7 = load i32, i32* %5
 %8 = load i32, i32* %4
 %9 = icmp slt i32 %7, %8
 br i1 %9, label %10, label %20
10:
 %11 = load i8*, i8** %3
 %12 = load i32, i32* %5
 %13 = sext i32 %12 to i64
 %14 = getelementptr i64, i8* %11, i64 %13
 %15 = load i64, i64* %14
 %16 = call i32 (i8*, ...) @printf (i8* @.str.3, i64 %15)
 br label %17
17:
 %18 = load i32, i32* %5
 %19 = add i32 %18, 1
 store i32 %19, i32* %5
 br label %6
20:
 ret void
}

define i32 @main () {
 %1 = alloca i8*
 %2 = alloca i32
 %3 = call i32 @read_ints (i8* %1)
 store i32 %3, i32* %2
 %4 = load i8*, i8** %1
 %5 = load i32, i32* %2
 call void @print_ints (i8* %4, i32 %5)
 %6 = load i8*, i8** %1
 call void @free (i8* %6)
 ret i32 0
}
