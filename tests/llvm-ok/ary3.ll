@.str = global [7 x i8] c"%d %d\0A\00"

declare i32 @atoi(i8*)
declare i8* @calloc(i64, i64)
declare i32 @printf(i8*, ...)
declare void @free(i8*)

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 %6 = alloca i32
 %7 = alloca i32
 %8 = alloca i32
 %9 = alloca i8*
 %10 = alloca i8*
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 %11 = load i32, i32* %4
 %12 = icmp eq i32 %11, 2
 br i1 %12, label %13, label %18
13:
 %14 = load i8*, i8** %5
 %15 = getelementptr i8*, i8* %14, i64 1
 %16 = load i8*, i8** %15
 %17 = call i32 @atoi (i8* %16)
 br label %19
18:
 br label %19
19:
 %20 = phi i32 [%17, %13], [1500000, %18]
 store i32 %20, i32* %6
 %21 = load i32, i32* %6
 %22 = sext i32 %21 to i64
 %23 = call i8* @calloc (i64 %22, i64 4)
 store i8* %23, i8** %9
 %24 = load i32, i32* %6
 %25 = sext i32 %24 to i64
 %26 = call i8* @calloc (i64 %25, i64 4)
 store i8* %26, i8** %10
 store i32 0, i32* %7
 br label %27
27:
 %28 = load i32, i32* %7
 %29 = load i32, i32* %6
 %30 = icmp slt i32 %28, %29
 br i1 %30, label %31, label %41
31:
 %32 = load i32, i32* %7
 %33 = add i32 %32, 1
 %34 = load i8*, i8** %9
 %35 = load i32, i32* %7
 %36 = sext i32 %35 to i64
 %37 = getelementptr i32, i8* %34, i64 %36
 store i32 %33, i32* %37
 br label %38
38:
 %39 = load i32, i32* %7
 %40 = add i32 %39, 1
 store i32 %40, i32* %7
 br label %27
41:
 store i32 0, i32* %8
 br label %42
42:
 %43 = load i32, i32* %8
 %44 = icmp slt i32 %43, 1000
 br i1 %44, label %45, label %70
45:
 %46 = load i32, i32* %6
 %47 = sub i32 %46, 1
 store i32 %47, i32* %7
 br label %48
48:
 %49 = load i32, i32* %7
 %50 = icmp sge i32 %49, 0
 br i1 %50, label %51, label %66
51:
 %52 = load i8*, i8** %9
 %53 = load i32, i32* %7
 %54 = sext i32 %53 to i64
 %55 = getelementptr i32, i8* %52, i64 %54
 %56 = load i32, i32* %55
 %57 = load i8*, i8** %10
 %58 = load i32, i32* %7
 %59 = sext i32 %58 to i64
 %60 = getelementptr i32, i8* %57, i64 %59
 %61 = load i32, i32* %60
 %62 = add i32 %61, %56
 store i32 %62, i32* %60
 br label %63
63:
 %64 = load i32, i32* %7
 %65 = add i32 %64, -1
 store i32 %65, i32* %7
 br label %48
66:
 br label %67
67:
 %68 = load i32, i32* %8
 %69 = add i32 %68, 1
 store i32 %69, i32* %8
 br label %42
70:
 %71 = load i8*, i8** %10
 %72 = getelementptr i32, i8* %71, i64 0
 %73 = load i32, i32* %72
 %74 = load i8*, i8** %10
 %75 = load i32, i32* %6
 %76 = sub i32 %75, 1
 %77 = sext i32 %76 to i64
 %78 = getelementptr i32, i8* %74, i64 %77
 %79 = load i32, i32* %78
 %80 = call i32 (i8*, ...) @printf (i8* @.str, i32 %73, i32 %79)
 %81 = load i8*, i8** %9
 call void @free (i8* %81)
 %82 = load i8*, i8** %10
 call void @free (i8* %82)
 ret i32 0
}
