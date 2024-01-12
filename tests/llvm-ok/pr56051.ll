@__const.main.x2 = global [1 x i64] [i64 8589934592]
@__const.main.x3 = global [1 x i64] [i64 8589934592]

declare void @llvm.memset.p0.i64(i8*, i8, i64, i1)
declare void @abort()
declare void @memcpy(i8*, i8*, i64, i1)

define i32 @main () {
 %1 = alloca i32
 %2 = alloca [1 x i8]
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8
 %6 = alloca i32
 %7 = alloca [1 x i64]
 %8 = alloca i32
 %9 = alloca i32
 %10 = alloca i64
 %11 = alloca i32
 %12 = alloca [1 x i64]
 %13 = alloca i32
 %14 = alloca i32
 %15 = alloca i64
 %16 = alloca i32
 store i32 0, i32* %1
 call void @memset (i8* %2, i8 0, i64 1, i1 0)
 store i32 8, i32* %3
 %17 = getelementptr [1 x i8], i8* %2, i64 0, i64 0
 %18 = load i8, i8* %17
 %19 = zext i8 %18 to i32
 %20 = load i32, i32* %3
 %21 = shl i32 1, %20
 %22 = trunc i32 %21 to i8
 %23 = zext i8 %22 to i32
 %24 = icmp slt i32 %19, %23
 %25 = zext i1 %24 to i32
 store i32 %25, i32* %4
 %26 = load i32, i32* %3
 %27 = shl i32 1, %26
 %28 = trunc i32 %27 to i8
 store i8 %28, i8* %5
 %29 = getelementptr [1 x i8], i8* %2, i64 0, i64 0
 %30 = load i8, i8* %29
 %31 = zext i8 %30 to i32
 %32 = load i8, i8* %5
 %33 = zext i8 %32 to i32
 %34 = icmp slt i32 %31, %33
 %35 = zext i1 %34 to i32
 store i32 %35, i32* %6
 %36 = load i32, i32* %4
 %37 = load i32, i32* %6
 %38 = icmp ne i32 %36, %37
 br i1 %38, label %39, label %40
39:
 call void @abort ()
 unreachable
40:
 call void @memcpy (i8* %7, i8* @__const.main.x2, i64 8, i1 0)
 store i32 31, i32* %8
 %41 = getelementptr [1 x i64], i8* %7, i64 0, i64 0
 %42 = load i64, i64* %41
 %43 = load i32, i32* %8
 %44 = shl i32 1, %43
 %45 = sext i32 %44 to i64
 %46 = icmp uge i64 %42, %45
 %47 = zext i1 %46 to i32
 store i32 %47, i32* %9
 %48 = load i32, i32* %8
 %49 = shl i32 1, %48
 %50 = sext i32 %49 to i64
 store i64 %50, i64* %10
 %51 = getelementptr [1 x i64], i8* %7, i64 0, i64 0
 %52 = load i64, i64* %51
 %53 = load i64, i64* %10
 %54 = icmp uge i64 %52, %53
 %55 = zext i1 %54 to i32
 store i32 %55, i32* %11
 %56 = load i32, i32* %9
 %57 = load i32, i32* %11
 %58 = icmp ne i32 %56, %57
 br i1 %58, label %59, label %60
59:
 call void @abort ()
 unreachable
60:
 call void @memcpy (i8* %12, i8* @__const.main.x3, i64 8, i1 0)
 store i32 31, i32* %13
 %61 = getelementptr [1 x i64], i8* %12, i64 0, i64 0
 %62 = load i64, i64* %61
 %63 = load i32, i32* %13
 %64 = shl i32 1, %63
 %65 = zext i32 %64 to i64
 %66 = icmp uge i64 %62, %65
 %67 = zext i1 %66 to i32
 store i32 %67, i32* %14
 %68 = load i32, i32* %13
 %69 = shl i32 1, %68
 %70 = zext i32 %69 to i64
 store i64 %70, i64* %15
 %71 = getelementptr [1 x i64], i8* %12, i64 0, i64 0
 %72 = load i64, i64* %71
 %73 = load i64, i64* %15
 %74 = icmp uge i64 %72, %73
 %75 = zext i1 %74 to i32
 store i32 %75, i32* %16
 %76 = load i32, i32* %14
 %77 = load i32, i32* %16
 %78 = icmp ne i32 %76, %77
 br i1 %78, label %79, label %80
79:
 call void @abort ()
 unreachable
80:
 ret i32 0
}
