%struct.DLL = type { i32, i8*, i8* }

@.str = global [12 x i8] c"length: %d\0A\00"
@.str.1 = global [28 x i8] c"i:%3d  v:%3d  n:%3d  p:%3d\0A\00"
@.str.2 = global [34 x i8] c"[last entry points to list head]\0A\00"
@.str.3 = global [31 x i8] c"[val of next of tail is:  %d]\0A\00"
@.str.4 = global [27 x i8] c"li2 and li1 are not equal\0A\00"
@.str.5 = global [25 x i8] c"li2 should be empty now\0A\00"
@.str.6 = global [25 x i8] c"li3 should be empty now\0A\00"
@.str.7 = global [42 x i8] c"li1 first value wrong, wanted %d, got %d\0A\00"
@.str.8 = global [37 x i8] c"last value wrong, wanted %d, got %d\0A\00"
@.str.9 = global [42 x i8] c"li2 first value wrong, wanted %d, got %d\0A\00"
@.str.10 = global [35 x i8] c"li1 size wrong, wanted %d, got %d\0A\00"
@.str.11 = global [27 x i8] c"li1 and li2 are not equal\0A\00"
@.str.12 = global [4 x i8] c"%d\0A\00"

declare i32 @puts(i8*)
declare i32 @printf(i8*, ...)
declare i8* @malloc(i64)
declare void @exit(i32)
declare void @free(i8*)
declare i32 @atoi(i8*)

define void @list_push_tail (i8* %0, i8* %1) {
 %3 = alloca i8*
 %4 = alloca i8*
 %5 = alloca i8*
 store i8* %0, i8** %3
 store i8* %1, i8** %4
 %6 = load i8*, i8** %3
 %7 = getelementptr %struct.DLL, i8* %6, i32 0, i32 2
 %8 = load i8*, i8** %7
 store i8* %8, i8** %5
 %9 = load i8*, i8** %4
 %10 = load i8*, i8** %5
 %11 = getelementptr %struct.DLL, i8* %10, i32 0, i32 1
 store i8* %9, i8** %11
 %12 = load i8*, i8** %3
 %13 = load i8*, i8** %4
 %14 = getelementptr %struct.DLL, i8* %13, i32 0, i32 1
 store i8* %12, i8** %14
 %15 = load i8*, i8** %4
 %16 = load i8*, i8** %3
 %17 = getelementptr %struct.DLL, i8* %16, i32 0, i32 2
 store i8* %15, i8** %17
 %18 = load i8*, i8** %5
 %19 = load i8*, i8** %4
 %20 = getelementptr %struct.DLL, i8* %19, i32 0, i32 2
 store i8* %18, i8** %20
 %21 = load i8*, i8** %3
 %22 = getelementptr %struct.DLL, i8* %21, i32 0, i32 0
 %23 = load i32, i32* %22
 %24 = add i32 %23, 1
 store i32 %24, i32* %22
 ret void
}

define i8* @list_pop_tail (i8* %0) {
 %2 = alloca i8*
 %3 = alloca i8*
 %4 = alloca i8*
 %5 = alloca i8*
 store i8* %0, i8** %3
 %6 = load i8*, i8** %3
 %7 = call i32 @list_empty (i8* %6)
 %8 = icmp ne i32 %7, 0
 br i1 %8, label %9, label %10
9:
 store i8* null, i8** %2
 br label %28
10:
 %11 = load i8*, i8** %3
 %12 = getelementptr %struct.DLL, i8* %11, i32 0, i32 2
 %13 = load i8*, i8** %12
 store i8* %13, i8** %5
 %14 = load i8*, i8** %5
 %15 = getelementptr %struct.DLL, i8* %14, i32 0, i32 2
 %16 = load i8*, i8** %15
 store i8* %16, i8** %4
 %17 = load i8*, i8** %3
 %18 = load i8*, i8** %4
 %19 = getelementptr %struct.DLL, i8* %18, i32 0, i32 1
 store i8* %17, i8** %19
 %20 = load i8*, i8** %4
 %21 = load i8*, i8** %3
 %22 = getelementptr %struct.DLL, i8* %21, i32 0, i32 2
 store i8* %20, i8** %22
 %23 = load i8*, i8** %3
 %24 = getelementptr %struct.DLL, i8* %23, i32 0, i32 0
 %25 = load i32, i32* %24
 %26 = add i32 %25, -1
 store i32 %26, i32* %24
 %27 = load i8*, i8** %5
 store i8* %27, i8** %2
 br label %28
28:
 %29 = load i8*, i8** %2
 ret i8* %29
}

define i32 @list_empty (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 %3 = load i8*, i8** %2
 %4 = call i32 @list_length (i8* %3)
 %5 = icmp eq i32 %4, 0
 %6 = zext i1 %5 to i32
 ret i32 %6
}

define void @list_push_head (i8* %0, i8* %1) {
 %3 = alloca i8*
 %4 = alloca i8*
 %5 = alloca i8*
 store i8* %0, i8** %3
 store i8* %1, i8** %4
 %6 = load i8*, i8** %3
 %7 = getelementptr %struct.DLL, i8* %6, i32 0, i32 1
 %8 = load i8*, i8** %7
 store i8* %8, i8** %5
 %9 = load i8*, i8** %4
 %10 = load i8*, i8** %3
 %11 = getelementptr %struct.DLL, i8* %10, i32 0, i32 1
 store i8* %9, i8** %11
 %12 = load i8*, i8** %4
 %13 = load i8*, i8** %5
 %14 = getelementptr %struct.DLL, i8* %13, i32 0, i32 2
 store i8* %12, i8** %14
 %15 = load i8*, i8** %5
 %16 = load i8*, i8** %4
 %17 = getelementptr %struct.DLL, i8* %16, i32 0, i32 1
 store i8* %15, i8** %17
 %18 = load i8*, i8** %3
 %19 = load i8*, i8** %4
 %20 = getelementptr %struct.DLL, i8* %19, i32 0, i32 2
 store i8* %18, i8** %20
 %21 = load i8*, i8** %3
 %22 = getelementptr %struct.DLL, i8* %21, i32 0, i32 0
 %23 = load i32, i32* %22
 %24 = add i32 %23, 1
 store i32 %24, i32* %22
 ret void
}

define i8* @list_pop_head (i8* %0) {
 %2 = alloca i8*
 %3 = alloca i8*
 %4 = alloca i8*
 store i8* %0, i8** %3
 %5 = load i8*, i8** %3
 %6 = call i32 @list_empty (i8* %5)
 %7 = icmp ne i32 %6, 0
 br i1 %7, label %8, label %9
8:
 store i8* null, i8** %2
 br label %28
9:
 %10 = load i8*, i8** %3
 %11 = getelementptr %struct.DLL, i8* %10, i32 0, i32 1
 %12 = load i8*, i8** %11
 store i8* %12, i8** %4
 %13 = load i8*, i8** %4
 %14 = getelementptr %struct.DLL, i8* %13, i32 0, i32 1
 %15 = load i8*, i8** %14
 %16 = load i8*, i8** %3
 %17 = getelementptr %struct.DLL, i8* %16, i32 0, i32 1
 store i8* %15, i8** %17
 %18 = load i8*, i8** %3
 %19 = load i8*, i8** %4
 %20 = getelementptr %struct.DLL, i8* %19, i32 0, i32 1
 %21 = load i8*, i8** %20
 %22 = getelementptr %struct.DLL, i8* %21, i32 0, i32 2
 store i8* %18, i8** %22
 %23 = load i8*, i8** %3
 %24 = getelementptr %struct.DLL, i8* %23, i32 0, i32 0
 %25 = load i32, i32* %24
 %26 = add i32 %25, -1
 store i32 %26, i32* %24
 %27 = load i8*, i8** %4
 store i8* %27, i8** %2
 br label %28
28:
 %29 = load i8*, i8** %2
 ret i8* %29
}

define i32 @list_equal (i8* %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i8*
 %5 = alloca i8*
 %6 = alloca i8*
 %7 = alloca i8*
 store i8* %0, i8** %4
 store i8* %1, i8** %5
 %8 = load i8*, i8** %4
 store i8* %8, i8** %6
 %9 = load i8*, i8** %5
 store i8* %9, i8** %7
 br label %10
10:
 %11 = load i8*, i8** %6
 %12 = getelementptr %struct.DLL, i8* %11, i32 0, i32 1
 %13 = load i8*, i8** %12
 %14 = load i8*, i8** %4
 %15 = icmp ne i8* %13, %14
 br i1 %15, label %16, label %33
16:
 %17 = load i8*, i8** %6
 %18 = getelementptr %struct.DLL, i8* %17, i32 0, i32 0
 %19 = load i32, i32* %18
 %20 = load i8*, i8** %7
 %21 = getelementptr %struct.DLL, i8* %20, i32 0, i32 0
 %22 = load i32, i32* %21
 %23 = icmp ne i32 %19, %22
 br i1 %23, label %24, label %25
24:
 store i32 0, i32* %3
 br label %49
25:
 br label %26
26:
 %27 = load i8*, i8** %6
 %28 = getelementptr %struct.DLL, i8* %27, i32 0, i32 1
 %29 = load i8*, i8** %28
 store i8* %29, i8** %6
 %30 = load i8*, i8** %7
 %31 = getelementptr %struct.DLL, i8* %30, i32 0, i32 1
 %32 = load i8*, i8** %31
 store i8* %32, i8** %7
 br label %10
33:
 %34 = load i8*, i8** %6
 %35 = getelementptr %struct.DLL, i8* %34, i32 0, i32 0
 %36 = load i32, i32* %35
 %37 = load i8*, i8** %7
 %38 = getelementptr %struct.DLL, i8* %37, i32 0, i32 0
 %39 = load i32, i32* %38
 %40 = icmp ne i32 %36, %39
 br i1 %40, label %41, label %42
41:
 store i32 0, i32* %3
 br label %49
42:
 %43 = load i8*, i8** %7
 %44 = getelementptr %struct.DLL, i8* %43, i32 0, i32 1
 %45 = load i8*, i8** %44
 %46 = load i8*, i8** %5
 %47 = icmp eq i8* %45, %46
 %48 = zext i1 %47 to i32
 store i32 %48, i32* %3
 br label %49
49:
 %50 = load i32, i32* %3
 ret i32 %50
}

define void @list_print (i8* %0, i8* %1) {
 %3 = alloca i8*
 %4 = alloca i8*
 %5 = alloca i8*
 %6 = alloca i8*
 %7 = alloca i32
 store i8* %0, i8** %3
 store i8* %1, i8** %4
 %8 = load i8*, i8** %4
 %9 = getelementptr %struct.DLL, i8* %8, i32 0, i32 1
 %10 = load i8*, i8** %9
 store i8* %10, i8** %6
 store i32 0, i32* %7
 %11 = load i8*, i8** %3
 %12 = call i32 @puts (i8* %11)
 %13 = load i8*, i8** %4
 %14 = call i32 @list_length (i8* %13)
 %15 = call i32 (i8*, ...) @printf (i8* @.str, i32 %14)
 %16 = load i8*, i8** %4
 %17 = getelementptr %struct.DLL, i8* %16, i32 0, i32 1
 %18 = load i8*, i8** %17
 store i8* %18, i8** %5
 br label %19
19:
 %20 = load i8*, i8** %5
 %21 = getelementptr %struct.DLL, i8* %20, i32 0, i32 1
 %22 = load i8*, i8** %21
 %23 = load i8*, i8** %6
 %24 = icmp ne i8* %22, %23
 br i1 %24, label %25, label %46
25:
 %26 = load i32, i32* %7
 %27 = add i32 %26, 1
 store i32 %27, i32* %7
 %28 = load i8*, i8** %5
 %29 = getelementptr %struct.DLL, i8* %28, i32 0, i32 0
 %30 = load i32, i32* %29
 %31 = load i8*, i8** %5
 %32 = getelementptr %struct.DLL, i8* %31, i32 0, i32 1
 %33 = load i8*, i8** %32
 %34 = getelementptr %struct.DLL, i8* %33, i32 0, i32 0
 %35 = load i32, i32* %34
 %36 = load i8*, i8** %5
 %37 = getelementptr %struct.DLL, i8* %36, i32 0, i32 2
 %38 = load i8*, i8** %37
 %39 = getelementptr %struct.DLL, i8* %38, i32 0, i32 0
 %40 = load i32, i32* %39
 %41 = call i32 (i8*, ...) @printf (i8* @.str.1, i32 %27, i32 %30, i32 %35, i32 %40)
 br label %42
42:
 %43 = load i8*, i8** %5
 %44 = getelementptr %struct.DLL, i8* %43, i32 0, i32 1
 %45 = load i8*, i8** %44
 store i8* %45, i8** %5
 br label %19
46:
 %47 = call i32 (i8*, ...) @printf (i8* @.str.2)
 %48 = load i8*, i8** %5
 %49 = getelementptr %struct.DLL, i8* %48, i32 0, i32 1
 %50 = load i8*, i8** %49
 %51 = getelementptr %struct.DLL, i8* %50, i32 0, i32 0
 %52 = load i32, i32* %51
 %53 = call i32 (i8*, ...) @printf (i8* @.str.3, i32 %52)
 ret void
}

define i32 @list_length (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 %3 = load i8*, i8** %2
 %4 = getelementptr %struct.DLL, i8* %3, i32 0, i32 0
 %5 = load i32, i32* %4
 ret i32 %5
}

define i8* @list_new () {
 %1 = alloca i8*
 %2 = call i8* @malloc (i64 24)
 store i8* %2, i8** %1
 %3 = load i8*, i8** %1
 %4 = load i8*, i8** %1
 %5 = getelementptr %struct.DLL, i8* %4, i32 0, i32 1
 store i8* %3, i8** %5
 %6 = load i8*, i8** %1
 %7 = load i8*, i8** %1
 %8 = getelementptr %struct.DLL, i8* %7, i32 0, i32 2
 store i8* %6, i8** %8
 %9 = load i8*, i8** %1
 %10 = getelementptr %struct.DLL, i8* %9, i32 0, i32 0
 store i32 0, i32* %10
 %11 = load i8*, i8** %1
 ret i8* %11
}

define i8* @list_sequence (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i32
 %7 = alloca i32
 %8 = alloca i32
 %9 = alloca i8*
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %10 = load i32, i32* %3
 %11 = load i32, i32* %4
 %12 = icmp sgt i32 %10, %11
 br i1 %12, label %13, label %17
13:
 %14 = load i32, i32* %3
 store i32 %14, i32* %6
 %15 = load i32, i32* %4
 store i32 %15, i32* %3
 %16 = load i32, i32* %6
 store i32 %16, i32* %4
 br label %17
17:
 %18 = load i32, i32* %4
 %19 = load i32, i32* %3
 %20 = sub i32 %18, %19
 %21 = add i32 %20, 1
 store i32 %21, i32* %5
 %22 = load i32, i32* %5
 %23 = add i32 %22, 1
 %24 = sext i32 %23 to i64
 %25 = mul i64 %24, 24
 %26 = call i8* @malloc (i64 %25)
 store i8* %26, i8** %9
 %27 = load i32, i32* %3
 %28 = add i32 %27, -1
 store i32 %28, i32* %3
 store i32 0, i32* %7
 store i32 1, i32* %8
 br label %29
29:
 %30 = load i32, i32* %7
 %31 = load i32, i32* %5
 %32 = icmp slt i32 %30, %31
 br i1 %32, label %33, label %66
33:
 %34 = load i8*, i8** %9
 %35 = load i32, i32* %7
 %36 = add i32 %35, 1
 %37 = sext i32 %36 to i64
 %38 = getelementptr %struct.DLL, i8* %34, i64 %37
 %39 = load i8*, i8** %9
 %40 = load i32, i32* %7
 %41 = sext i32 %40 to i64
 %42 = getelementptr %struct.DLL, i8* %39, i64 %41
 %43 = getelementptr %struct.DLL, i8* %42, i32 0, i32 1
 store i8* %38, i8** %43
 %44 = load i8*, i8** %9
 %45 = load i32, i32* %8
 %46 = sub i32 %45, 1
 %47 = sext i32 %46 to i64
 %48 = getelementptr %struct.DLL, i8* %44, i64 %47
 %49 = load i8*, i8** %9
 %50 = load i32, i32* %8
 %51 = sext i32 %50 to i64
 %52 = getelementptr %struct.DLL, i8* %49, i64 %51
 %53 = getelementptr %struct.DLL, i8* %52, i32 0, i32 2
 store i8* %48, i8** %53
 %54 = load i32, i32* %3
 %55 = add i32 %54, 1
 store i32 %55, i32* %3
 %56 = load i8*, i8** %9
 %57 = load i32, i32* %7
 %58 = sext i32 %57 to i64
 %59 = getelementptr %struct.DLL, i8* %56, i64 %58
 %60 = getelementptr %struct.DLL, i8* %59, i32 0, i32 0
 store i32 %54, i32* %60
 br label %61
61:
 %62 = load i32, i32* %7
 %63 = add i32 %62, 1
 store i32 %63, i32* %7
 %64 = load i32, i32* %8
 %65 = add i32 %64, 1
 store i32 %65, i32* %8
 br label %29
66:
 %67 = load i8*, i8** %9
 %68 = load i32, i32* %5
 %69 = sext i32 %68 to i64
 %70 = getelementptr %struct.DLL, i8* %67, i64 %69
 %71 = load i8*, i8** %9
 %72 = getelementptr %struct.DLL, i8* %71, i64 0
 %73 = getelementptr %struct.DLL, i8* %72, i32 0, i32 2
 store i8* %70, i8** %73
 %74 = load i8*, i8** %9
 %75 = getelementptr %struct.DLL, i8* %74, i64 0
 %76 = load i8*, i8** %9
 %77 = load i32, i32* %5
 %78 = sext i32 %77 to i64
 %79 = getelementptr %struct.DLL, i8* %76, i64 %78
 %80 = getelementptr %struct.DLL, i8* %79, i32 0, i32 1
 store i8* %75, i8** %80
 %81 = load i8*, i8** %9
 %82 = load i32, i32* %5
 %83 = sub i32 %82, 1
 %84 = sext i32 %83 to i64
 %85 = getelementptr %struct.DLL, i8* %81, i64 %84
 %86 = load i8*, i8** %9
 %87 = load i32, i32* %5
 %88 = sext i32 %87 to i64
 %89 = getelementptr %struct.DLL, i8* %86, i64 %88
 %90 = getelementptr %struct.DLL, i8* %89, i32 0, i32 2
 store i8* %85, i8** %90
 %91 = load i32, i32* %3
 %92 = load i8*, i8** %9
 %93 = load i32, i32* %5
 %94 = sext i32 %93 to i64
 %95 = getelementptr %struct.DLL, i8* %92, i64 %94
 %96 = getelementptr %struct.DLL, i8* %95, i32 0, i32 0
 store i32 %91, i32* %96
 %97 = load i32, i32* %5
 %98 = load i8*, i8** %9
 %99 = getelementptr %struct.DLL, i8* %98, i64 0
 %100 = getelementptr %struct.DLL, i8* %99, i32 0, i32 0
 store i32 %97, i32* %100
 %101 = load i8*, i8** %9
 ret i8* %101
}

define i8* @list_copy (i8* %0) {
 %2 = alloca i8*
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i8*
 %7 = alloca i8*
 store i8* %0, i8** %2
 %8 = load i8*, i8** %2
 %9 = call i32 @list_length (i8* %8)
 store i32 %9, i32* %5
 %10 = load i32, i32* %5
 %11 = add i32 %10, 1
 %12 = sext i32 %11 to i64
 %13 = mul i64 %12, 24
 %14 = call i8* @malloc (i64 %13)
 store i8* %14, i8** %7
 store i32 0, i32* %3
 store i32 1, i32* %4
 %15 = load i8*, i8** %2
 store i8* %15, i8** %6
 br label %16
16:
 %17 = load i32, i32* %3
 %18 = load i32, i32* %5
 %19 = icmp slt i32 %17, %18
 br i1 %19, label %20, label %55
20:
 %21 = load i8*, i8** %7
 %22 = load i32, i32* %4
 %23 = sext i32 %22 to i64
 %24 = getelementptr %struct.DLL, i8* %21, i64 %23
 %25 = load i8*, i8** %7
 %26 = load i32, i32* %3
 %27 = sext i32 %26 to i64
 %28 = getelementptr %struct.DLL, i8* %25, i64 %27
 %29 = getelementptr %struct.DLL, i8* %28, i32 0, i32 1
 store i8* %24, i8** %29
 %30 = load i8*, i8** %7
 %31 = load i32, i32* %3
 %32 = sext i32 %31 to i64
 %33 = getelementptr %struct.DLL, i8* %30, i64 %32
 %34 = load i8*, i8** %7
 %35 = load i32, i32* %4
 %36 = sext i32 %35 to i64
 %37 = getelementptr %struct.DLL, i8* %34, i64 %36
 %38 = getelementptr %struct.DLL, i8* %37, i32 0, i32 2
 store i8* %33, i8** %38
 %39 = load i8*, i8** %6
 %40 = getelementptr %struct.DLL, i8* %39, i32 0, i32 0
 %41 = load i32, i32* %40
 %42 = load i8*, i8** %7
 %43 = load i32, i32* %3
 %44 = sext i32 %43 to i64
 %45 = getelementptr %struct.DLL, i8* %42, i64 %44
 %46 = getelementptr %struct.DLL, i8* %45, i32 0, i32 0
 store i32 %41, i32* %46
 br label %47
47:
 %48 = load i32, i32* %3
 %49 = add i32 %48, 1
 store i32 %49, i32* %3
 %50 = load i32, i32* %4
 %51 = add i32 %50, 1
 store i32 %51, i32* %4
 %52 = load i8*, i8** %6
 %53 = getelementptr %struct.DLL, i8* %52, i32 0, i32 1
 %54 = load i8*, i8** %53
 store i8* %54, i8** %6
 br label %16
55:
 %56 = load i8*, i8** %7
 %57 = load i32, i32* %5
 %58 = sext i32 %57 to i64
 %59 = getelementptr %struct.DLL, i8* %56, i64 %58
 %60 = load i8*, i8** %7
 %61 = getelementptr %struct.DLL, i8* %60, i64 0
 %62 = getelementptr %struct.DLL, i8* %61, i32 0, i32 2
 store i8* %59, i8** %62
 %63 = load i8*, i8** %7
 %64 = getelementptr %struct.DLL, i8* %63, i64 0
 %65 = load i8*, i8** %7
 %66 = load i32, i32* %5
 %67 = sext i32 %66 to i64
 %68 = getelementptr %struct.DLL, i8* %65, i64 %67
 %69 = getelementptr %struct.DLL, i8* %68, i32 0, i32 1
 store i8* %64, i8** %69
 %70 = load i8*, i8** %2
 %71 = call i8* @list_last (i8* %70)
 %72 = getelementptr %struct.DLL, i8* %71, i32 0, i32 0
 %73 = load i32, i32* %72
 %74 = load i8*, i8** %7
 %75 = load i32, i32* %5
 %76 = sext i32 %75 to i64
 %77 = getelementptr %struct.DLL, i8* %74, i64 %76
 %78 = getelementptr %struct.DLL, i8* %77, i32 0, i32 0
 store i32 %73, i32* %78
 %79 = load i8*, i8** %7
 ret i8* %79
}

define i8* @list_last (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 %3 = load i8*, i8** %2
 %4 = getelementptr %struct.DLL, i8* %3, i32 0, i32 2
 %5 = load i8*, i8** %4
 ret i8* %5
}

define void @list_reverse (i8* %0) {
 %2 = alloca i8*
 %3 = alloca i8*
 %4 = alloca i8*
 store i8* %0, i8** %2
 %5 = load i8*, i8** %2
 store i8* %5, i8** %4
 br label %6
6:
 %7 = load i8*, i8** %4
 %8 = getelementptr %struct.DLL, i8* %7, i32 0, i32 1
 %9 = load i8*, i8** %8
 store i8* %9, i8** %3
 %10 = load i8*, i8** %4
 %11 = getelementptr %struct.DLL, i8* %10, i32 0, i32 2
 %12 = load i8*, i8** %11
 %13 = load i8*, i8** %4
 %14 = getelementptr %struct.DLL, i8* %13, i32 0, i32 1
 store i8* %12, i8** %14
 %15 = load i8*, i8** %3
 %16 = load i8*, i8** %4
 %17 = getelementptr %struct.DLL, i8* %16, i32 0, i32 2
 store i8* %15, i8** %17
 %18 = load i8*, i8** %3
 store i8* %18, i8** %4
 br label %19
19:
 %20 = load i8*, i8** %4
 %21 = load i8*, i8** %2
 %22 = icmp ne i8* %20, %21
 br i1 %22, label %6, label %23
23:
 ret void
}

define i32 @test_lists () {
 %1 = alloca i32
 %2 = alloca i8*
 %3 = alloca i8*
 %4 = alloca i8*
 store i32 0, i32* %1
 %5 = call i8* @list_sequence (i32 1, i32 100)
 store i8* %5, i8** %2
 %6 = load i8*, i8** %2
 %7 = call i8* @list_copy (i8* %6)
 store i8* %7, i8** %3
 %8 = call i8* @list_new ()
 store i8* %8, i8** %4
 %9 = load i8*, i8** %3
 %10 = load i8*, i8** %2
 %11 = call i32 @list_equal (i8* %9, i8* %10)
 %12 = icmp ne i32 %11, 0
 br i1 %12, label %15, label %13
13:
 %14 = call i32 (i8*, ...) @printf (i8* @.str.4)
 call void @exit (i32 1)
 unreachable
15:
 br label %16
16:
 %17 = load i8*, i8** %3
 %18 = call i32 @list_empty (i8* %17)
 %19 = icmp ne i32 %18, 0
 %20 = xor i1 %19, 1
 br i1 %20, label %21, label %25
21:
 %22 = load i8*, i8** %4
 %23 = load i8*, i8** %3
 %24 = call i8* @list_pop_head (i8* %23)
 call void @list_push_tail (i8* %22, i8* %24)
 br label %16
25:
 %26 = load i8*, i8** %3
 %27 = call i32 @list_empty (i8* %26)
 %28 = icmp ne i32 %27, 0
 br i1 %28, label %31, label %29
29:
 %30 = call i32 (i8*, ...) @printf (i8* @.str.5)
 call void @exit (i32 1)
 unreachable
31:
 br label %32
32:
 %33 = load i8*, i8** %4
 %34 = call i32 @list_empty (i8* %33)
 %35 = icmp ne i32 %34, 0
 %36 = xor i1 %35, 1
 br i1 %36, label %37, label %41
37:
 %38 = load i8*, i8** %3
 %39 = load i8*, i8** %4
 %40 = call i8* @list_pop_tail (i8* %39)
 call void @list_push_tail (i8* %38, i8* %40)
 br label %32
41:
 %42 = load i8*, i8** %4
 %43 = call i32 @list_empty (i8* %42)
 %44 = icmp ne i32 %43, 0
 br i1 %44, label %47, label %45
45:
 %46 = call i32 (i8*, ...) @printf (i8* @.str.6)
 call void @exit (i32 1)
 unreachable
47:
 %48 = load i8*, i8** %2
 call void @list_reverse (i8* %48)
 %49 = load i8*, i8** %2
 %50 = call i8* @list_first (i8* %49)
 %51 = getelementptr %struct.DLL, i8* %50, i32 0, i32 0
 %52 = load i32, i32* %51
 %53 = icmp ne i32 %52, 100
 br i1 %53, label %54, label %60
54:
 %55 = load i8*, i8** %2
 %56 = call i8* @list_first (i8* %55)
 %57 = getelementptr %struct.DLL, i8* %56, i32 0, i32 0
 %58 = load i32, i32* %57
 %59 = call i32 (i8*, ...) @printf (i8* @.str.7, i32 100, i32 %58)
 call void @exit (i32 1)
 unreachable
60:
 %61 = load i8*, i8** %2
 %62 = call i8* @list_last (i8* %61)
 %63 = getelementptr %struct.DLL, i8* %62, i32 0, i32 0
 %64 = load i32, i32* %63
 %65 = icmp ne i32 %64, 1
 br i1 %65, label %66, label %72
66:
 %67 = load i8*, i8** %2
 %68 = call i8* @list_last (i8* %67)
 %69 = getelementptr %struct.DLL, i8* %68, i32 0, i32 0
 %70 = load i32, i32* %69
 %71 = call i32 (i8*, ...) @printf (i8* @.str.8, i32 100, i32 %70)
 call void @exit (i32 1)
 unreachable
72:
 %73 = load i8*, i8** %3
 %74 = call i8* @list_first (i8* %73)
 %75 = getelementptr %struct.DLL, i8* %74, i32 0, i32 0
 %76 = load i32, i32* %75
 %77 = icmp ne i32 %76, 100
 br i1 %77, label %78, label %84
78:
 %79 = load i8*, i8** %3
 %80 = call i8* @list_first (i8* %79)
 %81 = getelementptr %struct.DLL, i8* %80, i32 0, i32 0
 %82 = load i32, i32* %81
 %83 = call i32 (i8*, ...) @printf (i8* @.str.9, i32 100, i32 %82)
 call void @exit (i32 1)
 unreachable
84:
 %85 = load i8*, i8** %3
 %86 = call i8* @list_last (i8* %85)
 %87 = getelementptr %struct.DLL, i8* %86, i32 0, i32 0
 %88 = load i32, i32* %87
 %89 = icmp ne i32 %88, 1
 br i1 %89, label %90, label %96
90:
 %91 = load i8*, i8** %3
 %92 = call i8* @list_last (i8* %91)
 %93 = getelementptr %struct.DLL, i8* %92, i32 0, i32 0
 %94 = load i32, i32* %93
 %95 = call i32 (i8*, ...) @printf (i8* @.str.8, i32 100, i32 %94)
 call void @exit (i32 1)
 unreachable
96:
 %97 = load i8*, i8** %2
 %98 = call i32 @list_length (i8* %97)
 %99 = icmp ne i32 %98, 100
 br i1 %99, label %100, label %104
100:
 %101 = load i8*, i8** %2
 %102 = call i32 @list_length (i8* %101)
 %103 = call i32 (i8*, ...) @printf (i8* @.str.10, i32 100, i32 %102)
 call void @exit (i32 1)
 unreachable
104:
 %105 = load i8*, i8** %2
 %106 = load i8*, i8** %3
 %107 = call i32 @list_equal (i8* %105, i8* %106)
 %108 = icmp ne i32 %107, 0
 br i1 %108, label %111, label %109
109:
 %110 = call i32 (i8*, ...) @printf (i8* @.str.11)
 call void @exit (i32 1)
 unreachable
111:
 %112 = load i8*, i8** %2
 %113 = call i32 @list_length (i8* %112)
 store i32 %113, i32* %1
 %114 = load i8*, i8** %2
 call void @free (i8* %114)
 %115 = load i8*, i8** %3
 call void @free (i8* %115)
 %116 = load i8*, i8** %4
 call void @free (i8* %116)
 %117 = load i32, i32* %1
 ret i32 %117
}

define i8* @list_first (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 %3 = load i8*, i8** %2
 %4 = getelementptr %struct.DLL, i8* %3, i32 0, i32 1
 %5 = load i8*, i8** %4
 ret i8* %5
}

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 %6 = alloca i32
 %7 = alloca i32
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 %8 = load i32, i32* %4
 %9 = icmp eq i32 %8, 2
 br i1 %9, label %10, label %15
10:
 %11 = load i8*, i8** %5
 %12 = getelementptr i8*, i8* %11, i64 1
 %13 = load i8*, i8** %12
 %14 = call i32 @atoi (i8* %13)
 br label %16
15:
 br label %16
16:
 %17 = phi i32 [%14, %10], [3000000, %15]
 store i32 %17, i32* %6
 store i32 0, i32* %7
 br label %18
18:
 %19 = load i32, i32* %6
 %20 = add i32 %19, -1
 store i32 %20, i32* %6
 %21 = icmp ne i32 %19, 0
 br i1 %21, label %22, label %24
22:
 %23 = call i32 @test_lists ()
 store i32 %23, i32* %7
 br label %18
24:
 %25 = load i32, i32* %7
 %26 = call i32 (i8*, ...) @printf (i8* @.str.12, i32 %25)
 ret i32 0
}
