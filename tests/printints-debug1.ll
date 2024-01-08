@.str = global [4 x i8] c"%p\0A\00"
@.str.1 = global [5 x i8] c"%lld\00"
@.str.2 = global [6 x i8] c"%lld\0A\00"

declare i8* @malloc(i64)
declare i32 @printf(i8*, ...)
declare void @llvm.lifetime.start.p0(i64, i8*)
declare i32 @scanf(i8*, ...)
declare void @llvm.lifetime.end.p0(i64, i8*)
declare i8* @realloc(i8*, i64)
declare void @free(i8*)

define i32 @read_ints (i8* %0) {
1:
 %2 = call i8* @malloc (i64 64)
 store i8* %2, i8** %0
 %3 = call i32 (i8*, ...) @printf (i8* @.str, i8* %0)
 %4 = load i8*, i8** %0
 %5 = call i32 (i8*, ...) @printf (i8* @.str, i8* %4)
 br label %6
6:
 %7 = phi i64 [%12, %66], [0, %1]
 %8 = phi i32 [%65, %66], [0, %1]
 %9 = phi i32 [%63, %66], [0, %1]
 %10 = trunc i64 %7 to i32
 %11 = shl i32 %10, 3
 %12 = add i64 %7, 1
 %13 = shl i64 %12, 3
 %14 = zext i32 %11 to i64
 %15 = icmp ugt i64 %13, %14
 br i1 %15, label %16, label %62
16:
 %17 = sext i32 %9 to i64
 %18 = add i32 %9, 8
 %19 = call i32 (i8*, ...) @printf (i8* @.str, i8* %0)
 %20 = load i8*, i8** %0
 %21 = call i32 (i8*, ...) @printf (i8* @.str, i8* %20)
 %22 = call i32 (i8*, ...) @printf (i8* @.str, i32 %9)
 %23 = load i8*, i8** %0
 %24 = getelementptr i64, i8* %23, i64 %17
 %25 = call i32 (i8*, ...) @printf (i8* @.str, i8* %24)
 %26 = load i8*, i8** %0
 %27 = getelementptr i64, i8* %26, i64 %17
 %28 = call i32 (i8*, ...) @scanf (i8* @.str.1, i8* %27)
 %29 = icmp eq i32 %28, -1
 br i1 %29, label %62, label %43
30:
 %31 = call i32 (i8*, ...) @printf (i8* @.str, i8* %0)
 %32 = load i8*, i8** %0
 %33 = call i32 (i8*, ...) @printf (i8* @.str, i8* %32)
 %34 = trunc i64 %51 to i32
 %35 = call i32 (i8*, ...) @printf (i8* @.str, i32 %34)
 %36 = load i8*, i8** %0
 %37 = getelementptr i64, i8* %36, i64 %51
 %38 = call i32 (i8*, ...) @printf (i8* @.str, i8* %37)
 %39 = load i8*, i8** %0
 %40 = getelementptr i64, i8* %39, i64 %51
 %41 = call i32 (i8*, ...) @scanf (i8* @.str.1, i8* %40)
 %42 = icmp eq i32 %41, -1
 br i1 %42, label %54, label %43
43:
 %44 = phi i32 [%50, %30], [%11, %16]
 %45 = phi i64 [%51, %30], [%17, %16]
 %46 = load i8*, i8** %0
 %47 = getelementptr i64, i8* %46, i64 %45
 %48 = load i64, i64* %47
 %49 = call i32 (i8*, ...) @printf (i8* @.str.2, i64 %48)
 %50 = add i32 %44, 1
 %51 = add i64 %45, 1
 %52 = trunc i64 %51 to i32
 %53 = icmp eq i32 %18, %52
 br i1 %53, label %59, label %30
54:
 %55 = zext i32 %50 to i64
 %56 = icmp ugt i64 %13, %55
 %57 = trunc i64 %51 to i32
 %58 = trunc i64 %51 to i32
 br label %62
59:
 %60 = zext i32 %50 to i64
 %61 = icmp ugt i64 %13, %60
 br label %62
62:
 %63 = phi i32 [%9, %6], [%58, %54], [%9, %16], [%18, %59]
 %64 = phi i1 [%15, %6], [%56, %54], [%15, %16], [%61, %59]
 %65 = phi i32 [%8, %6], [%57, %54], [%9, %16], [%8, %59]
 br i1 %64, label %72, label %66
66:
 %67 = load i8*, i8** %0
 %68 = add i32 %11, 16
 %69 = sext i32 %68 to i64
 %70 = shl i64 %69, 3
 %71 = call i8* @realloc (i8* %67, i64 %70)
 store i8* %71, i8** %0
 br label %6
72:
 ret i32 %65
}

define void @print_ints (i8* %0, i32 %1) {
2:
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
 %11 = call i32 (i8*, ...) @printf (i8* @.str.2, i64 %10)
 %12 = add i64 %8, 1
 %13 = icmp eq i64 %12, %5
 br i1 %13, label %6, label %7
}

define i32 @main () {
 %1 = alloca i8*
 %2 = call i32 @read_ints (i8* %1)
 %3 = load i8*, i8** %1
 %4 = icmp sgt i32 %2, 0
 br i1 %4, label %5, label %14
5:
 %6 = zext i32 %2 to i64
 br label %7
7:
 %8 = phi i64 [0, %5], [%12, %7]
 %9 = getelementptr i64, i8* %3, i64 %8
 %10 = load i64, i64* %9
 %11 = call i32 (i8*, ...) @printf (i8* @.str.2, i64 %10)
 %12 = add i64 %8, 1
 %13 = icmp eq i64 %12, %6
 br i1 %13, label %14, label %7
14:
 %15 = load i8*, i8** %1
 call void @free (i8* %15)
 ret i32 0
}
