@.str = global [3 x i8] c"%i\00"

declare i32 @atoi(i8*)
declare i8* @malloc(i64)
declare i32 @printf(i8*, ...)
declare void @free(i8*)

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 %6 = alloca i32
 %7 = alloca i8*
 %8 = alloca i32
 %9 = alloca i32
 %10 = alloca i32
 %11 = alloca i32
 %12 = alloca i32
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 %13 = load i8*, i8** %5
 %14 = getelementptr i8*, i8* %13, i64 1
 %15 = load i8*, i8** %14
 %16 = call i32 @atoi (i8* %15)
 store i32 %16, i32* %6
 %17 = load i32, i32* %6
 %18 = add i32 %17, 1
 %19 = sext i32 %18 to i64
 %20 = mul i64 1, %19
 %21 = call i8* @malloc (i64 %20)
 store i8* %21, i8** %7
 store i32 2, i32* %8
 br label %22
22:
 %23 = load i32, i32* %8
 %24 = load i32, i32* %6
 %25 = icmp sle i32 %23, %24
 br i1 %25, label %26, label %34
26:
 %27 = load i8*, i8** %7
 %28 = load i32, i32* %8
 %29 = sext i32 %28 to i64
 %30 = getelementptr i8, i8* %27, i64 %29
 store i8 1, i8* %30
 br label %31
31:
 %32 = load i32, i32* %8
 %33 = add i32 %32, 1
 store i32 %33, i32* %8
 br label %22
34:
 store i32 2, i32* %9
 br label %35
35:
 %36 = load i32, i32* %9
 %37 = load i32, i32* %9
 %38 = mul i32 %36, %37
 %39 = load i32, i32* %6
 %40 = icmp sle i32 %38, %39
 br i1 %40, label %41, label %70
41:
 %42 = load i8*, i8** %7
 %43 = load i32, i32* %9
 %44 = sext i32 %43 to i64
 %45 = getelementptr i8, i8* %42, i64 %44
 %46 = load i8, i8* %45
 %47 = trunc i8 %46 to i1
 br i1 %47, label %48, label %66
48:
 %49 = load i32, i32* %9
 %50 = load i32, i32* %9
 %51 = mul i32 %49, %50
 store i32 %51, i32* %10
 br label %52
52:
 %53 = load i32, i32* %10
 %54 = load i32, i32* %6
 %55 = icmp sle i32 %53, %54
 br i1 %55, label %56, label %65
56:
 %57 = load i8*, i8** %7
 %58 = load i32, i32* %10
 %59 = sext i32 %58 to i64
 %60 = getelementptr i8, i8* %57, i64 %59
 store i8 0, i8* %60
 br label %61
61:
 %62 = load i32, i32* %9
 %63 = load i32, i32* %10
 %64 = add i32 %63, %62
 store i32 %64, i32* %10
 br label %52
65:
 br label %66
66:
 br label %67
67:
 %68 = load i32, i32* %9
 %69 = add i32 %68, 1
 store i32 %69, i32* %9
 br label %35
70:
 store i32 0, i32* %11
 store i32 2, i32* %12
 br label %71
71:
 %72 = load i32, i32* %12
 %73 = load i32, i32* %6
 %74 = icmp sle i32 %72, %73
 br i1 %74, label %75, label %89
75:
 %76 = load i8*, i8** %7
 %77 = load i32, i32* %12
 %78 = sext i32 %77 to i64
 %79 = getelementptr i8, i8* %76, i64 %78
 %80 = load i8, i8* %79
 %81 = trunc i8 %80 to i1
 br i1 %81, label %82, label %85
82:
 %83 = load i32, i32* %11
 %84 = add i32 %83, 1
 store i32 %84, i32* %11
 br label %85
85:
 br label %86
86:
 %87 = load i32, i32* %12
 %88 = add i32 %87, 1
 store i32 %88, i32* %12
 br label %71
89:
 %90 = load i32, i32* %11
 %91 = call i32 (i8*, ...) @printf (i8* @.str, i32 %90)
 %92 = load i8*, i8** %7
 call void @free (i8* %92)
 ret i32 0
}
