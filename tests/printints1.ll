@.str = global [5 x i8] c"%lld\00"
@.str.1 = global [6 x i8] c"%lld\0A\00"

declare i8* @malloc(i64)
declare i32 @scanf(i8*, ...)
declare i8* @realloc(i8*, i64)
declare i32 @printf(i8*, ...)
declare void @free(i8*)

define i32 @read_ints (i8* %0) {
 %2 = call i8* @malloc (i64 64)
 br label %3
3:
 %4 = phi i64 [%10, %45], [0, %1]
 %5 = phi i8* [%50, %45], [%2, %1]
 %6 = phi i32 [%44, %45], [0, %1]
 %7 = phi i32 [%42, %45], [0, %1]
 store i8* %5, i8** %0
 %8 = trunc i64 %4 to i32
 %9 = shl i32 %8, 3
 %10 = add i64 %4, 1
 %11 = shl i64 %10, 3
 %12 = zext i32 %9 to i64
 %13 = icmp ugt i64 %11, %12
 br i1 %13, label %14, label %41
14:
 %15 = sext i32 %7 to i64
 %16 = add i32 %7, 8
 %17 = load i8*, i8** %0
 %18 = getelementptr i64, i8* %17, i64 %15
 %19 = call i32 (i8*, ...) @scanf (i8* @.str, i8* %18)
 %20 = icmp eq i32 %19, -1
 br i1 %20, label %41, label %26
21:
 %22 = load i8*, i8** %0
 %23 = getelementptr i64, i8* %22, i64 %30
 %24 = call i32 (i8*, ...) @scanf (i8* @.str, i8* %23)
 %25 = icmp eq i32 %24, -1
 br i1 %25, label %33, label %26
26:
 %27 = phi i32 [%29, %21], [%9, %14]
 %28 = phi i64 [%30, %21], [%15, %14]
 %29 = add i32 %27, 1
 %30 = add i64 %28, 1
 %31 = trunc i64 %30 to i32
 %32 = icmp eq i32 %16, %31
 br i1 %32, label %38, label %21
33:
 %34 = zext i32 %29 to i64
 %35 = icmp ugt i64 %11, %34
 %36 = trunc i64 %30 to i32
 %37 = trunc i64 %30 to i32
 br label %41
38:
 %39 = zext i32 %29 to i64
 %40 = icmp ugt i64 %11, %39
 br label %41
41:
 %42 = phi i32 [%7, %3], [%37, %33], [%7, %14], [%16, %38]
 %43 = phi i1 [%13, %3], [%35, %33], [%13, %14], [%40, %38]
 %44 = phi i32 [%6, %3], [%36, %33], [%7, %14], [%6, %38]
 br i1 %43, label %51, label %45
45:
 %46 = load i8*, i8** %0
 %47 = add i32 %9, 16
 %48 = sext i32 %47 to i64
 %49 = shl i64 %48, 3
 %50 = call i8* @realloc (i8* %46, i64 %49)
 br label %3
51:
 ret i32 %44
}

define void @print_ints (i8* %0, i32 %1) {
 %3 = icmp sgt i32 %1, 0
 br i1 %3, label %4, label %6
4:
 %5 = zext i32 %1 to i64
 br label %7
6:
 ret void
7:
 %8 = phi i64 [0, %4], [%12, %7]
 %9 = getelementptr i64, i8* %0, i64 %8
 %10 = load i64, i64* %9
 %11 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %10)
 %12 = add i64 %8, 1
 %13 = icmp eq i64 %12, %5
 br i1 %13, label %6, label %7
}

define i32 @main () {
 %1 = call i8* @malloc (i64 64)
 br label %2
2:
 %3 = phi i32 [%52, %46], [7, %0]
 %4 = phi i32 [%51, %46], [0, %0]
 %5 = phi i64 [%12, %46], [0, %0]
 %6 = phi i8* [%50, %46], [%1, %0]
 %7 = phi i32 [%45, %46], [0, %0]
 %8 = phi i32 [%43, %46], [0, %0]
 %9 = zext i32 %4 to i64
 %10 = trunc i64 %5 to i32
 %11 = shl i32 %10, 3
 %12 = add i64 %5, 1
 %13 = shl i64 %12, 3
 %14 = zext i32 %11 to i64
 %15 = icmp ugt i64 %13, %14
 br i1 %15, label %16, label %42
16:
 %17 = sext i32 %8 to i64
 %18 = add i32 %8, 8
 %19 = getelementptr i64, i8* %6, i64 %17
 %20 = call i32 (i8*, ...) @scanf (i8* @.str, i8* %19)
 %21 = icmp eq i32 %20, -1
 br i1 %21, label %36, label %22
22:
 %23 = zext i32 %3 to i64
 br label %29
24:
 %25 = add i64 %31, 1
 %26 = getelementptr i64, i8* %6, i64 %25
 %27 = call i32 (i8*, ...) @scanf (i8* @.str, i8* %26)
 %28 = icmp eq i32 %27, -1
 br i1 %28, label %34, label %29
29:
 %30 = phi i64 [%9, %22], [%32, %24]
 %31 = phi i64 [%17, %22], [%25, %24]
 %32 = add i64 %30, 1
 %33 = icmp eq i64 %30, %23
 br i1 %33, label %40, label %24
34:
 %35 = icmp ugt i64 %13, %32
 br label %36
36:
 %37 = phi i64 [%17, %16], [%25, %34]
 %38 = phi i1 [1, %16], [%35, %34]
 %39 = trunc i64 %37 to i32
 br label %42
40:
 %41 = icmp ugt i64 %13, %32
 br label %42
42:
 %43 = phi i32 [%8, %2], [%39, %36], [%18, %40]
 %44 = phi i1 [%15, %2], [%38, %36], [%41, %40]
 %45 = phi i32 [%7, %2], [%39, %36], [%7, %40]
 br i1 %44, label %53, label %46
46:
 %47 = add i32 %11, 16
 %48 = sext i32 %47 to i64
 %49 = shl i64 %48, 3
 %50 = call i8* @realloc (i8* %6, i64 %49)
 %51 = add i32 %4, 8
 %52 = add i32 %3, 8
 br label %2
53:
 %54 = icmp sgt i32 %45, 0
 br i1 %54, label %55, label %64
55:
 %56 = zext i32 %45 to i64
 br label %57
57:
 %58 = phi i64 [0, %55], [%62, %57]
 %59 = getelementptr i64, i8* %6, i64 %58
 %60 = load i64, i64* %59
 %61 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %60)
 %62 = add i64 %58, 1
 %63 = icmp eq i64 %62, %56
 br i1 %63, label %64, label %57
64:
 call void @free (i8* %6)
 ret i32 0
}
