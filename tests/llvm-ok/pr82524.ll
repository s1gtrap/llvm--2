%union.U = type { i32 }
%struct.S = type { i8, i8, i8, i8 }

declare void @llvm.memcpy.p0.p0.i64(i8*, i8*, i64, i1)
declare void @abort()

define i32 @bar (i8* %0, i8* %1) {
 %3 = alloca i8*
 %4 = alloca i8*
 %5 = alloca %union.U
 %6 = alloca i8
 %7 = alloca i8
 store i8* %0, i8** %3
 store i8* %1, i8** %4
 %8 = load i8*, i8** %3
 %9 = getelementptr %struct.S, i8* %8, i32 0, i32 3
 %10 = load i8, i8* %9
 store i8 %10, i8* %6
 %11 = load i8*, i8** %4
 %12 = getelementptr %struct.S, i8* %11, i32 0, i32 3
 %13 = load i8, i8* %12
 %14 = load i8, i8* %6
 %15 = zext i8 %14 to i32
 %16 = sub i32 255, %15
 %17 = trunc i32 %16 to i8
 %18 = call i8 @foo (i8 %13, i8 %17)
 store i8 %18, i8* %7
 %19 = load i8*, i8** %3
 %20 = getelementptr %struct.S, i8* %19, i32 0, i32 2
 %21 = load i8, i8* %20
 %22 = load i8, i8* %6
 %23 = call i8 @foo (i8 %21, i8 %22)
 %24 = zext i8 %23 to i32
 %25 = load i8*, i8** %4
 %26 = getelementptr %struct.S, i8* %25, i32 0, i32 2
 %27 = load i8, i8* %26
 %28 = load i8, i8* %7
 %29 = call i8 @foo (i8 %27, i8 %28)
 %30 = zext i8 %29 to i32
 %31 = add i32 %24, %30
 %32 = trunc i32 %31 to i8
 %33 = getelementptr %struct.S, i8* %5, i32 0, i32 2
 store i8 %32, i8* %33
 %34 = load i8*, i8** %3
 %35 = getelementptr %struct.S, i8* %34, i32 0, i32 1
 %36 = load i8, i8* %35
 %37 = load i8, i8* %6
 %38 = call i8 @foo (i8 %36, i8 %37)
 %39 = zext i8 %38 to i32
 %40 = load i8*, i8** %4
 %41 = getelementptr %struct.S, i8* %40, i32 0, i32 1
 %42 = load i8, i8* %41
 %43 = load i8, i8* %7
 %44 = call i8 @foo (i8 %42, i8 %43)
 %45 = zext i8 %44 to i32
 %46 = add i32 %39, %45
 %47 = trunc i32 %46 to i8
 %48 = getelementptr %struct.S, i8* %5, i32 0, i32 1
 store i8 %47, i8* %48
 %49 = load i8*, i8** %3
 %50 = getelementptr %struct.S, i8* %49, i32 0, i32 0
 %51 = load i8, i8* %50
 %52 = load i8, i8* %6
 %53 = call i8 @foo (i8 %51, i8 %52)
 %54 = zext i8 %53 to i32
 %55 = load i8*, i8** %4
 %56 = getelementptr %struct.S, i8* %55, i32 0, i32 0
 %57 = load i8, i8* %56
 %58 = load i8, i8* %7
 %59 = call i8 @foo (i8 %57, i8 %58)
 %60 = zext i8 %59 to i32
 %61 = add i32 %54, %60
 %62 = trunc i32 %61 to i8
 %63 = getelementptr %struct.S, i8* %5, i32 0, i32 0
 store i8 %62, i8* %63
 %64 = getelementptr %struct.S, i8* %5, i32 0, i32 3
 store i8 0, i8* %64
 %65 = load i32, i32* %5
 ret i32 %65
}

define i8 @foo (i8 %0, i8 %1) {
 %3 = alloca i8
 %4 = alloca i8
 store i8 %0, i8* %3
 store i8 %1, i8* %4
 %5 = load i8, i8* %3
 %6 = zext i8 %5 to i32
 %7 = add i32 %6, 1
 %8 = load i8, i8* %4
 %9 = zext i8 %8 to i32
 %10 = mul i32 %7, %9
 %11 = ashr i32 %10, 8
 %12 = trunc i32 %11 to i8
 ret i8 %12
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca %union.U
 %3 = alloca %union.U
 %4 = alloca %union.U
 %5 = alloca %struct.S
 %6 = alloca %struct.S
 store i32 0, i32* %1
 %7 = getelementptr %struct.S, i8* %5, i32 0, i32 0
 store i8 -1, i8* %7
 %8 = getelementptr %struct.S, i8* %5, i32 0, i32 1
 store i8 -1, i8* %8
 %9 = getelementptr %struct.S, i8* %5, i32 0, i32 2
 store i8 -1, i8* %9
 %10 = getelementptr %struct.S, i8* %5, i32 0, i32 3
 store i8 0, i8* %10
 call void @memcpy (i8* %2, i8* %5, i64 4, i1 0)
 %11 = getelementptr %struct.S, i8* %6, i32 0, i32 0
 store i8 -1, i8* %11
 %12 = getelementptr %struct.S, i8* %6, i32 0, i32 1
 store i8 -1, i8* %12
 %13 = getelementptr %struct.S, i8* %6, i32 0, i32 2
 store i8 -1, i8* %13
 %14 = getelementptr %struct.S, i8* %6, i32 0, i32 3
 store i8 -1, i8* %14
 call void @memcpy (i8* %3, i8* %6, i64 4, i1 0)
 %15 = call i32 @bar (i8* %2, i8* %3)
 store i32 %15, i32* %4
 %16 = getelementptr %struct.S, i8* %4, i32 0, i32 0
 %17 = load i8, i8* %16
 %18 = zext i8 %17 to i32
 %19 = icmp ne i32 %18, 255
 br i1 %19, label %35, label %20
20:
 %21 = getelementptr %struct.S, i8* %4, i32 0, i32 1
 %22 = load i8, i8* %21
 %23 = zext i8 %22 to i32
 %24 = icmp ne i32 %23, 255
 br i1 %24, label %35, label %25
25:
 %26 = getelementptr %struct.S, i8* %4, i32 0, i32 2
 %27 = load i8, i8* %26
 %28 = zext i8 %27 to i32
 %29 = icmp ne i32 %28, 255
 br i1 %29, label %35, label %30
30:
 %31 = getelementptr %struct.S, i8* %4, i32 0, i32 3
 %32 = load i8, i8* %31
 %33 = zext i8 %32 to i32
 %34 = icmp ne i32 %33, 0
 br i1 %34, label %35, label %36
35:
 call void @abort ()
 unreachable
36:
 ret i32 0
}
