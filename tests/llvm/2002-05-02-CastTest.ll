@.str = global [23 x i8] c"ubc0 = '%c'\09   [0x%x]\0A\00"
@.str.1 = global [21 x i8] c"ubs0 = %u\09   [0x%x]\0A\00"
@.str.2 = global [21 x i8] c"ubs1 = %u\09   [0x%x]\0A\00"
@.str.3 = global [21 x i8] c"bs0  = %d\09   [0x%x]\0A\00"
@.str.4 = global [21 x i8] c"bs1  = %d\09   [0x%x]\0A\00"
@.str.5 = global [23 x i8] c"c1   = '%c'\09   [0x%x]\0A\00"
@.str.6 = global [21 x i8] c"s1   = %d\09   [0x%x]\0A\00"
@.str.7 = global [23 x i8] c"uc2  = '%c'\09   [0x%x]\0A\00"
@.str.8 = global [21 x i8] c"us2  = %u\09   [0x%x]\0A\00"
@.str.9 = global [23 x i8] c"ic3  = '%c'\09   [0x%x]\0A\00"
@.str.10 = global [21 x i8] c"is3  = %d\09   [0x%x]\0A\00"
@.str.11 = global [21 x i8] c"is4  = %d\09   [0x%x]\0A\00"
@.str.12 = global [21 x i8] c"is5  = %d\09   [0x%x]\0A\00"
@.str.13 = global [23 x i8] c"uic4 = '%c'\09   [0x%x]\0A\00"
@.str.14 = global [19 x i8] c"uis4 = %u  [0x%x]\0A\00"

declare i32 @atoi(i8*)
declare i32 @printf(i8*, ...)

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 %6 = alloca i8
 %7 = alloca i16
 %8 = alloca i8
 %9 = alloca i8
 %10 = alloca i8
 %11 = alloca i8
 %12 = alloca i8
 %13 = alloca i8
 %14 = alloca i16
 %15 = alloca i32
 %16 = alloca i32
 %17 = alloca i32
 %18 = alloca i32
 %19 = alloca i32
 %20 = alloca i32
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 %21 = load i32, i32* %4
 %22 = icmp sge i32 %21, 2
 br i1 %22, label %23, label %28
23:
 %24 = load i8*, i8** %5
 %25 = getelementptr i8*, i8* %24, i64 1
 %26 = load i8*, i8** %25
 %27 = call i32 @atoi (i8* %26)
 br label %29
28:
 br label %29
29:
 %30 = phi i32 [%27, %23], [100, %28]
 %31 = trunc i32 %30 to i8
 store i8 %31, i8* %6
 %32 = load i32, i32* %4
 %33 = icmp sge i32 %32, 3
 br i1 %33, label %34, label %39
34:
 %35 = load i8*, i8** %5
 %36 = getelementptr i8*, i8* %35, i64 2
 %37 = load i8*, i8** %36
 %38 = call i32 @atoi (i8* %37)
 br label %40
39:
 br label %40
40:
 %41 = phi i32 [%38, %34], [-769, %39]
 %42 = trunc i32 %41 to i16
 store i16 %42, i16* %7
 %43 = load i8, i8* %6
 store i8 %43, i8* %8
 %44 = load i16, i16* %7
 %45 = trunc i16 %44 to i8
 store i8 %45, i8* %9
 %46 = load i8, i8* %9
 %47 = zext i8 %46 to i32
 %48 = add i32 %47, 1
 %49 = trunc i32 %48 to i8
 store i8 %49, i8* %10
 %50 = load i8, i8* %9
 store i8 %50, i8* %11
 %51 = load i8, i8* %9
 %52 = zext i8 %51 to i32
 %53 = add i32 %52, 1
 %54 = trunc i32 %53 to i8
 store i8 %54, i8* %12
 %55 = load i8, i8* %6
 store i8 %55, i8* %13
 %56 = load i16, i16* %7
 store i16 %56, i16* %14
 %57 = load i8, i8* %6
 %58 = sext i8 %57 to i32
 store i32 %58, i32* %15
 %59 = load i16, i16* %7
 %60 = sext i16 %59 to i32
 store i32 %60, i32* %16
 %61 = load i8, i8* %9
 %62 = zext i8 %61 to i32
 %63 = add i32 %62, 1
 store i32 %63, i32* %17
 %64 = load i8, i8* %11
 %65 = sext i8 %64 to i32
 %66 = add i32 %65, 1
 store i32 %66, i32* %18
 %67 = load i8, i8* %6
 %68 = sext i8 %67 to i32
 store i32 %68, i32* %19
 %69 = load i16, i16* %7
 %70 = sext i16 %69 to i32
 store i32 %70, i32* %20
 %71 = load i8, i8* %8
 %72 = zext i8 %71 to i32
 %73 = load i8, i8* %8
 %74 = zext i8 %73 to i32
 %75 = call i32 (i8*, ...) @printf (i8* @.str, i32 %72, i32 %74)
 %76 = load i8, i8* %9
 %77 = zext i8 %76 to i32
 %78 = load i8, i8* %9
 %79 = zext i8 %78 to i32
 %80 = call i32 (i8*, ...) @printf (i8* @.str.1, i32 %77, i32 %79)
 %81 = load i8, i8* %10
 %82 = zext i8 %81 to i32
 %83 = load i8, i8* %10
 %84 = zext i8 %83 to i32
 %85 = call i32 (i8*, ...) @printf (i8* @.str.2, i32 %82, i32 %84)
 %86 = load i8, i8* %11
 %87 = sext i8 %86 to i32
 %88 = load i8, i8* %11
 %89 = sext i8 %88 to i32
 %90 = call i32 (i8*, ...) @printf (i8* @.str.3, i32 %87, i32 %89)
 %91 = load i8, i8* %12
 %92 = sext i8 %91 to i32
 %93 = load i8, i8* %12
 %94 = sext i8 %93 to i32
 %95 = call i32 (i8*, ...) @printf (i8* @.str.4, i32 %92, i32 %94)
 %96 = load i8, i8* %6
 %97 = sext i8 %96 to i32
 %98 = load i8, i8* %6
 %99 = sext i8 %98 to i32
 %100 = call i32 (i8*, ...) @printf (i8* @.str.5, i32 %97, i32 %99)
 %101 = load i16, i16* %7
 %102 = sext i16 %101 to i32
 %103 = load i16, i16* %7
 %104 = sext i16 %103 to i32
 %105 = call i32 (i8*, ...) @printf (i8* @.str.6, i32 %102, i32 %104)
 %106 = load i8, i8* %13
 %107 = zext i8 %106 to i32
 %108 = load i8, i8* %13
 %109 = zext i8 %108 to i32
 %110 = call i32 (i8*, ...) @printf (i8* @.str.7, i32 %107, i32 %109)
 %111 = load i16, i16* %14
 %112 = zext i16 %111 to i32
 %113 = load i16, i16* %14
 %114 = zext i16 %113 to i32
 %115 = call i32 (i8*, ...) @printf (i8* @.str.8, i32 %112, i32 %114)
 %116 = load i32, i32* %15
 %117 = load i32, i32* %15
 %118 = call i32 (i8*, ...) @printf (i8* @.str.9, i32 %116, i32 %117)
 %119 = load i32, i32* %16
 %120 = load i32, i32* %16
 %121 = call i32 (i8*, ...) @printf (i8* @.str.10, i32 %119, i32 %120)
 %122 = load i32, i32* %17
 %123 = load i32, i32* %17
 %124 = call i32 (i8*, ...) @printf (i8* @.str.11, i32 %122, i32 %123)
 %125 = load i32, i32* %18
 %126 = load i32, i32* %18
 %127 = call i32 (i8*, ...) @printf (i8* @.str.12, i32 %125, i32 %126)
 %128 = load i32, i32* %19
 %129 = load i32, i32* %19
 %130 = call i32 (i8*, ...) @printf (i8* @.str.13, i32 %128, i32 %129)
 %131 = load i32, i32* %20
 %132 = load i32, i32* %20
 %133 = call i32 (i8*, ...) @printf (i8* @.str.14, i32 %131, i32 %132)
 ret i32 0
}
