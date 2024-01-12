@.str = global [13 x i8] c"%d %d %d %d\0A\00"

declare i8* @malloc(i64)
declare void @free(i8*)
declare i32 @atoi(i8*)
declare i32 @printf(i8*, ...)

define i8* @mkmatrix (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i32
 %7 = alloca i32
 %8 = alloca i8*
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 store i32 1, i32* %7
 %9 = load i32, i32* %3
 %10 = sext i32 %9 to i64
 %11 = mul i64 %10, 8
 %12 = call i8* @malloc (i64 %11)
 store i8* %12, i8** %8
 store i32 0, i32* %5
 br label %13
13:
 %14 = load i32, i32* %5
 %15 = load i32, i32* %3
 %16 = icmp slt i32 %14, %15
 br i1 %16, label %17, label %48
17:
 %18 = load i32, i32* %4
 %19 = sext i32 %18 to i64
 %20 = mul i64 %19, 4
 %21 = call i8* @malloc (i64 %20)
 %22 = load i8*, i8** %8
 %23 = load i32, i32* %5
 %24 = sext i32 %23 to i64
 %25 = getelementptr i8*, i8* %22, i64 %24
 store i8* %21, i8** %25
 store i32 0, i32* %6
 br label %26
26:
 %27 = load i32, i32* %6
 %28 = load i32, i32* %4
 %29 = icmp slt i32 %27, %28
 br i1 %29, label %30, label %44
30:
 %31 = load i32, i32* %7
 %32 = add i32 %31, 1
 store i32 %32, i32* %7
 %33 = load i8*, i8** %8
 %34 = load i32, i32* %5
 %35 = sext i32 %34 to i64
 %36 = getelementptr i8*, i8* %33, i64 %35
 %37 = load i8*, i8** %36
 %38 = load i32, i32* %6
 %39 = sext i32 %38 to i64
 %40 = getelementptr i32, i8* %37, i64 %39
 store i32 %31, i32* %40
 br label %41
41:
 %42 = load i32, i32* %6
 %43 = add i32 %42, 1
 store i32 %43, i32* %6
 br label %26
44:
 br label %45
45:
 %46 = load i32, i32* %5
 %47 = add i32 %46, 1
 store i32 %47, i32* %5
 br label %13
48:
 %49 = load i8*, i8** %8
 ret i8* %49
}

define void @zeromatrix (i32 %0, i32 %1, i8* %2) {
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i8*
 %7 = alloca i32
 %8 = alloca i32
 store i32 %0, i32* %4
 store i32 %1, i32* %5
 store i8* %2, i8** %6
 store i32 0, i32* %7
 br label %9
9:
 %10 = load i32, i32* %7
 %11 = load i32, i32* %4
 %12 = icmp slt i32 %10, %11
 br i1 %12, label %13, label %34
13:
 store i32 0, i32* %8
 br label %14
14:
 %15 = load i32, i32* %8
 %16 = load i32, i32* %5
 %17 = icmp slt i32 %15, %16
 br i1 %17, label %18, label %30
18:
 %19 = load i8*, i8** %6
 %20 = load i32, i32* %7
 %21 = sext i32 %20 to i64
 %22 = getelementptr i8*, i8* %19, i64 %21
 %23 = load i8*, i8** %22
 %24 = load i32, i32* %8
 %25 = sext i32 %24 to i64
 %26 = getelementptr i32, i8* %23, i64 %25
 store i32 0, i32* %26
 br label %27
27:
 %28 = load i32, i32* %8
 %29 = add i32 %28, 1
 store i32 %29, i32* %8
 br label %14
30:
 br label %31
31:
 %32 = load i32, i32* %7
 %33 = add i32 %32, 1
 store i32 %33, i32* %7
 br label %9
34:
 ret void
}

define void @freematrix (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i8*
 store i32 %0, i32* %3
 store i8* %1, i8** %4
 br label %5
5:
 %6 = load i32, i32* %3
 %7 = add i32 %6, -1
 store i32 %7, i32* %3
 %8 = icmp sgt i32 %7, -1
 br i1 %8, label %9, label %15
9:
 %10 = load i8*, i8** %4
 %11 = load i32, i32* %3
 %12 = sext i32 %11 to i64
 %13 = getelementptr i8*, i8* %10, i64 %12
 %14 = load i8*, i8** %13
 call void @free (i8* %14)
 br label %5
15:
 %16 = load i8*, i8** %4
 call void @free (i8* %16)
 ret void
}

define i8* @mmult (i32 %0, i32 %1, i8* %2, i8* %3, i8* %4) {
 %6 = alloca i32
 %7 = alloca i32
 %8 = alloca i8*
 %9 = alloca i8*
 %10 = alloca i8*
 %11 = alloca i32
 %12 = alloca i32
 %13 = alloca i32
 %14 = alloca i32
 store i32 %0, i32* %6
 store i32 %1, i32* %7
 store i8* %2, i8** %8
 store i8* %3, i8** %9
 store i8* %4, i8** %10
 store i32 0, i32* %11
 br label %15
15:
 %16 = load i32, i32* %11
 %17 = load i32, i32* %6
 %18 = icmp slt i32 %16, %17
 br i1 %18, label %19, label %71
19:
 store i32 0, i32* %12
 br label %20
20:
 %21 = load i32, i32* %12
 %22 = load i32, i32* %7
 %23 = icmp slt i32 %21, %22
 br i1 %23, label %24, label %67
24:
 store i32 0, i32* %14
 store i32 0, i32* %13
 br label %25
25:
 %26 = load i32, i32* %13
 %27 = load i32, i32* %7
 %28 = icmp slt i32 %26, %27
 br i1 %28, label %29, label %54
29:
 %30 = load i8*, i8** %8
 %31 = load i32, i32* %11
 %32 = sext i32 %31 to i64
 %33 = getelementptr i8*, i8* %30, i64 %32
 %34 = load i8*, i8** %33
 %35 = load i32, i32* %13
 %36 = sext i32 %35 to i64
 %37 = getelementptr i32, i8* %34, i64 %36
 %38 = load i32, i32* %37
 %39 = load i8*, i8** %9
 %40 = load i32, i32* %13
 %41 = sext i32 %40 to i64
 %42 = getelementptr i8*, i8* %39, i64 %41
 %43 = load i8*, i8** %42
 %44 = load i32, i32* %12
 %45 = sext i32 %44 to i64
 %46 = getelementptr i32, i8* %43, i64 %45
 %47 = load i32, i32* %46
 %48 = mul i32 %38, %47
 %49 = load i32, i32* %14
 %50 = add i32 %49, %48
 store i32 %50, i32* %14
 br label %51
51:
 %52 = load i32, i32* %13
 %53 = add i32 %52, 1
 store i32 %53, i32* %13
 br label %25
54:
 %55 = load i32, i32* %14
 %56 = load i8*, i8** %10
 %57 = load i32, i32* %11
 %58 = sext i32 %57 to i64
 %59 = getelementptr i8*, i8* %56, i64 %58
 %60 = load i8*, i8** %59
 %61 = load i32, i32* %12
 %62 = sext i32 %61 to i64
 %63 = getelementptr i32, i8* %60, i64 %62
 store i32 %55, i32* %63
 br label %64
64:
 %65 = load i32, i32* %12
 %66 = add i32 %65, 1
 store i32 %66, i32* %12
 br label %20
67:
 br label %68
68:
 %69 = load i32, i32* %11
 %70 = add i32 %69, 1
 store i32 %70, i32* %11
 br label %15
71:
 %72 = load i8*, i8** %10
 ret i8* %72
}

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 %6 = alloca i32
 %7 = alloca i32
 %8 = alloca i8*
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
 %20 = phi i32 [%17, %13], [3000000, %18]
 store i32 %20, i32* %7
 %21 = call i8* @mkmatrix (i32 10, i32 10)
 store i8* %21, i8** %8
 %22 = call i8* @mkmatrix (i32 10, i32 10)
 store i8* %22, i8** %9
 %23 = call i8* @mkmatrix (i32 10, i32 10)
 store i8* %23, i8** %10
 store i32 0, i32* %6
 br label %24
24:
 %25 = load i32, i32* %6
 %26 = load i32, i32* %7
 %27 = icmp slt i32 %25, %26
 br i1 %27, label %28, label %36
28:
 %29 = load i8*, i8** %8
 %30 = load i8*, i8** %9
 %31 = load i8*, i8** %10
 %32 = call i8* @mmult (i32 10, i32 10, i8* %29, i8* %30, i8* %31)
 store i8* %32, i8** %10
 br label %33
33:
 %34 = load i32, i32* %6
 %35 = add i32 %34, 1
 store i32 %35, i32* %6
 br label %24
36:
 %37 = load i8*, i8** %10
 %38 = getelementptr i8*, i8* %37, i64 0
 %39 = load i8*, i8** %38
 %40 = getelementptr i32, i8* %39, i64 0
 %41 = load i32, i32* %40
 %42 = load i8*, i8** %10
 %43 = getelementptr i8*, i8* %42, i64 2
 %44 = load i8*, i8** %43
 %45 = getelementptr i32, i8* %44, i64 3
 %46 = load i32, i32* %45
 %47 = load i8*, i8** %10
 %48 = getelementptr i8*, i8* %47, i64 3
 %49 = load i8*, i8** %48
 %50 = getelementptr i32, i8* %49, i64 2
 %51 = load i32, i32* %50
 %52 = load i8*, i8** %10
 %53 = getelementptr i8*, i8* %52, i64 4
 %54 = load i8*, i8** %53
 %55 = getelementptr i32, i8* %54, i64 4
 %56 = load i32, i32* %55
 %57 = call i32 (i8*, ...) @printf (i8* @.str, i32 %41, i32 %46, i32 %51, i32 %56)
 %58 = load i8*, i8** %8
 call void @freematrix (i32 10, i8* %58)
 %59 = load i8*, i8** %9
 call void @freematrix (i32 10, i8* %59)
 %60 = load i8*, i8** %10
 call void @freematrix (i32 10, i8* %60)
 ret i32 0
}
