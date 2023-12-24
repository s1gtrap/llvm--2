@.str = global [4 x i8] c"%d \00"

declare i32 @atoi(void*)
declare void* @malloc(i64)
declare i32 @printf(void*)
declare void @free(void*)

define i32 @main (i32 %0, void* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca void*
 %6 = alloca i32
 %7 = alloca void*
 %8 = alloca i32
 %9 = alloca i32
 %10 = alloca i32
 %11 = alloca i32
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store void* %1, void** %5
 %12 = load void*, void** %5
 %13 = getelementptr void*, void** %12, i64 1
 %14 = load void*, void** %13
 %15 = call i32 @atoi (void* %14)
 store i32 %15, i32* %6
 %16 = load i32, i32* %6
 %17 = add i32 %16, 1
 %18 = sext i32 %17 to i64
 %19 = mul i64 1, %18
 %20 = call void* @malloc (i64 %19)
 store void* %20, void** %7
 store i32 2, i32* %8
 br label %21
21:
 %22 = load i32, i32* %8
 %23 = load i32, i32* %6
 %24 = icmp sle i32 %22, %23
 br i1 %24, label %25, label %33
25:
 %26 = load void*, void** %7
 %27 = load i32, i32* %8
 %28 = sext i32 %27 to i64
 %29 = getelementptr i8, i8* %26, i64 %28
 store i8 1, i8* %29
 br label %30
30:
 %31 = load i32, i32* %8
 %32 = add i32 %31, 1
 store i32 %32, i32* %8
 br label %21
33:
 store i32 2, i32* %9
 br label %34
34:
 %35 = load i32, i32* %9
 %36 = load i32, i32* %9
 %37 = mul i32 %35, %36
 %38 = load i32, i32* %6
 %39 = icmp sle i32 %37, %38
 br i1 %39, label %40, label %69
40:
 %41 = load void*, void** %7
 %42 = load i32, i32* %9
 %43 = sext i32 %42 to i64
 %44 = getelementptr i8, i8* %41, i64 %43
 %45 = load i8, i8* %44
 %46 = trunc i8 %45 to i1
 br i1 %46, label %47, label %65
47:
 %48 = load i32, i32* %9
 %49 = load i32, i32* %9
 %50 = mul i32 %48, %49
 store i32 %50, i32* %10
 br label %51
51:
 %52 = load i32, i32* %10
 %53 = load i32, i32* %6
 %54 = icmp sle i32 %52, %53
 br i1 %54, label %55, label %64
55:
 %56 = load void*, void** %7
 %57 = load i32, i32* %10
 %58 = sext i32 %57 to i64
 %59 = getelementptr i8, i8* %56, i64 %58
 store i8 0, i8* %59
 br label %60
60:
 %61 = load i32, i32* %9
 %62 = load i32, i32* %10
 %63 = add i32 %62, %61
 store i32 %63, i32* %10
 br label %51
64:
 br label %65
65:
 br label %66
66:
 %67 = load i32, i32* %9
 %68 = add i32 %67, 1
 store i32 %68, i32* %9
 br label %34
69:
 store i32 2, i32* %11
 br label %70
70:
 %71 = load i32, i32* %11
 %72 = load i32, i32* %6
 %73 = icmp sle i32 %71, %72
 br i1 %73, label %74, label %88
74:
 %75 = load void*, void** %7
 %76 = load i32, i32* %11
 %77 = sext i32 %76 to i64
 %78 = getelementptr i8, i8* %75, i64 %77
 %79 = load i8, i8* %78
 %80 = trunc i8 %79 to i1
 br i1 %80, label %81, label %84
81:
 %82 = load i32, i32* %11
 %83 = call i32( void* ) @printf (void* @.str, i32 %82)
 br label %84
84:
 br label %85
85:
 %86 = load i32, i32* %11
 %87 = add i32 %86, 1
 store i32 %87, i32* %11
 br label %70
88:
 %89 = load void*, void** %7
 call void @free (void* %89)
 ret i32 0
}
