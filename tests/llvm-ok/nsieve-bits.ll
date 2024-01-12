@.str = global [22 x i8] c"Primes up to %8d %8d\0A\00"

declare i8* @malloc(i64)
declare i8* @__memset_chk(i8*, i32, i64, i64)
declare i64 @llvm.objectsize.i64.p0(i8*, i1, i1, i1)
declare i32 @printf(i8*, ...)
declare void @free(i8*)

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 %6 = alloca i32
 %7 = alloca i32
 %8 = alloca i8*
 %9 = alloca i32
 %10 = alloca i32
 %11 = alloca i32
 %12 = alloca i32
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 store i32 40960000, i32* %7
 %13 = load i32, i32* %7
 %14 = udiv i32 %13, 8
 %15 = zext i32 %14 to i64
 %16 = add i64 %15, 4
 %17 = call i8* @malloc (i64 %16)
 store i8* %17, i8** %8
 %18 = load i8*, i8** %8
 %19 = icmp ne i8* %18, null
 br i1 %19, label %21, label %20
20:
 store i32 1, i32* %3
 br label %111
21:
 store i32 0, i32* %6
 br label %22
22:
 %23 = load i32, i32* %6
 %24 = icmp ule i32 %23, 2
 br i1 %24, label %25, label %109
25:
 store i32 0, i32* %11
 %26 = load i32, i32* %7
 %27 = load i32, i32* %6
 %28 = lshr i32 %26, %27
 store i32 %28, i32* %12
 %29 = load i8*, i8** %8
 %30 = load i32, i32* %12
 %31 = udiv i32 %30, 8
 %32 = zext i32 %31 to i64
 %33 = add i64 %32, 4
 %34 = load i8*, i8** %8
 %35 = call i64 @llvm.objectsize.i64.p0 (i8* %34, i1 0, i1 1, i1 0)
 %36 = call i8* @__memset_chk (i8* %29, i32 255, i64 %33, i64 %35)
 store i32 2, i32* %9
 br label %37
37:
 %38 = load i32, i32* %9
 %39 = load i32, i32* %12
 %40 = icmp ule i32 %38, %39
 br i1 %40, label %41, label %102
41:
 %42 = load i8*, i8** %8
 %43 = load i32, i32* %9
 %44 = zext i32 %43 to i64
 %45 = udiv i64 %44, 32
 %46 = getelementptr i32, i8* %42, i64 %45
 %47 = load i32, i32* %46
 %48 = load i32, i32* %9
 %49 = zext i32 %48 to i64
 %50 = urem i64 %49, 32
 %51 = trunc i64 %50 to i32
 %52 = shl i32 1, %51
 %53 = and i32 %47, %52
 %54 = icmp ne i32 %53, 0
 br i1 %54, label %55, label %98
55:
 %56 = load i32, i32* %11
 %57 = add i32 %56, 1
 store i32 %57, i32* %11
 %58 = load i32, i32* %9
 %59 = load i32, i32* %9
 %60 = add i32 %58, %59
 store i32 %60, i32* %10
 br label %61
61:
 %62 = load i32, i32* %10
 %63 = load i32, i32* %12
 %64 = icmp ule i32 %62, %63
 br i1 %64, label %65, label %97
65:
 %66 = load i8*, i8** %8
 %67 = load i32, i32* %10
 %68 = zext i32 %67 to i64
 %69 = udiv i64 %68, 32
 %70 = getelementptr i32, i8* %66, i64 %69
 %71 = load i32, i32* %70
 %72 = load i32, i32* %10
 %73 = zext i32 %72 to i64
 %74 = urem i64 %73, 32
 %75 = trunc i64 %74 to i32
 %76 = shl i32 1, %75
 %77 = and i32 %71, %76
 %78 = icmp ne i32 %77, 0
 br i1 %78, label %79, label %92
79:
 %80 = load i32, i32* %10
 %81 = zext i32 %80 to i64
 %82 = urem i64 %81, 32
 %83 = trunc i64 %82 to i32
 %84 = shl i32 1, %83
 %85 = load i8*, i8** %8
 %86 = load i32, i32* %10
 %87 = zext i32 %86 to i64
 %88 = udiv i64 %87, 32
 %89 = getelementptr i32, i8* %85, i64 %88
 %90 = load i32, i32* %89
 %91 = xor i32 %90, %84
 store i32 %91, i32* %89
 br label %92
92:
 br label %93
93:
 %94 = load i32, i32* %9
 %95 = load i32, i32* %10
 %96 = add i32 %95, %94
 store i32 %96, i32* %10
 br label %61
97:
 br label %98
98:
 br label %99
99:
 %100 = load i32, i32* %9
 %101 = add i32 %100, 1
 store i32 %101, i32* %9
 br label %37
102:
 %103 = load i32, i32* %12
 %104 = load i32, i32* %11
 %105 = call i32 (i8*, ...) @printf (i8* @.str, i32 %103, i32 %104)
 br label %106
106:
 %107 = load i32, i32* %6
 %108 = add i32 %107, 1
 store i32 %108, i32* %6
 br label %22
109:
 %110 = load i8*, i8** %8
 call void @free (i8* %110)
 store i32 0, i32* %3
 br label %111
111:
 %112 = load i32, i32* %3
 ret i32 %112
}
