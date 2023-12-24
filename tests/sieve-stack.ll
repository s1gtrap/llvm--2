@.str = global [4 x i8] c"%d \00"

declare i32 @atoi(i8*)
declare i32 @printf(i8*, ...)
declare void @llvm.stackrestore(i8*)

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 %6 = alloca i32
 %7 = alloca i8*
 %8 = alloca i64
 %9 = alloca i32
 %10 = alloca i32
 %11 = alloca i32
 %12 = alloca i32
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 %13 = load i8*, i8** %5
 %14 = getelementptr i8*, i8** %13, i64 1
 %15 = load i8*, i8** %14
 %16 = call i32 @atoi (i8* %15)
 store i32 %16, i32* %6
 %17 = load i32, i32* %6
 %18 = add i32 %17, 1
 %19 = zext i32 %18 to i64
 %20 = add i32 0, 0
 %21 = alloca i8, i64 %19
 store i64 %19, i64* %8
 store i32 2, i32* %9
 br label %22
22:
 %23 = load i32, i32* %9
 %24 = load i32, i32* %6
 %25 = icmp sle i32 %23, %24
 br i1 %25, label %26, label %33
26:
 %27 = load i32, i32* %9
 %28 = sext i32 %27 to i64
 %29 = getelementptr i8, i8* %21, i64 %28
 store i8 1, i8* %29
 br label %30
30:
 %31 = load i32, i32* %9
 %32 = add i32 %31, 1
 store i32 %32, i32* %9
 br label %22
33:
 store i32 2, i32* %10
 br label %34
34:
 %35 = load i32, i32* %10
 %36 = load i32, i32* %10
 %37 = mul i32 %35, %36
 %38 = load i32, i32* %6
 %39 = icmp sle i32 %37, %38
 br i1 %39, label %40, label %67
40:
 %41 = load i32, i32* %10
 %42 = sext i32 %41 to i64
 %43 = getelementptr i8, i8* %21, i64 %42
 %44 = load i8, i8* %43
 %45 = trunc i8 %44 to i1
 br i1 %45, label %46, label %63
46:
 %47 = load i32, i32* %10
 %48 = load i32, i32* %10
 %49 = mul i32 %47, %48
 store i32 %49, i32* %11
 br label %50
50:
 %51 = load i32, i32* %11
 %52 = load i32, i32* %6
 %53 = icmp sle i32 %51, %52
 br i1 %53, label %54, label %62
54:
 %55 = load i32, i32* %11
 %56 = sext i32 %55 to i64
 %57 = getelementptr i8, i8* %21, i64 %56
 store i8 0, i8* %57
 br label %58
58:
 %59 = load i32, i32* %10
 %60 = load i32, i32* %11
 %61 = add i32 %60, %59
 store i32 %61, i32* %11
 br label %50
62:
 br label %63
63:
 br label %64
64:
 %65 = load i32, i32* %10
 %66 = add i32 %65, 1
 store i32 %66, i32* %10
 br label %34
67:
 store i32 2, i32* %12
 br label %68
68:
 %69 = load i32, i32* %12
 %70 = load i32, i32* %6
 %71 = icmp sle i32 %69, %70
 br i1 %71, label %72, label %85
72:
 %73 = load i32, i32* %12
 %74 = sext i32 %73 to i64
 %75 = getelementptr i8, i8* %21, i64 %74
 %76 = load i8, i8* %75
 %77 = trunc i8 %76 to i1
 br i1 %77, label %78, label %81
78:
 %79 = load i32, i32* %12
 %80 = call i32( i8*, ... ) @printf (i8* @.str, i32 %79)
 br label %81
81:
 br label %82
82:
 %83 = load i32, i32* %12
 %84 = add i32 %83, 1
 store i32 %84, i32* %12
 br label %68
85:
 store i32 0, i32* %3
 %86 = add i32 0, 0
 %87 = load i32, i32* %3
 ret i32 %87
}
