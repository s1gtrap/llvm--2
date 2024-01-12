%struct.S = type { i8*, i32, [624 x i32] }

@p = global [23 x i8] c"\C0I\172b\1E.\D5L\19(I\91\E4r\83\91=\93\83\B3a8"
@q = global [23 x i8] c">AUTOIT UNICODE SCRIPT<"

declare i32 @memcmp(i8*, i8*, i64)
declare void @abort()

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 store i32 0, i32* %1
 store i32 23, i32* %2
 %3 = load i32, i32* %2
 %4 = load i32, i32* %2
 %5 = add i32 %4, 41566
 call void @bar (i8* @p, i32 %3, i32 %5)
 %6 = load i32, i32* %2
 %7 = zext i32 %6 to i64
 %8 = call i32 @memcmp (i8* @p, i8* @q, i64 %7)
 %9 = icmp ne i32 %8, 0
 br i1 %9, label %10, label %11
10:
 call void @abort ()
 unreachable
11:
 ret i32 0
}

define void @bar (i8* %0, i32 %1, i32 %2) {
 %4 = alloca i8*
 %5 = alloca i32
 %6 = alloca i32
 %7 = alloca %struct.S
 %8 = alloca i32
 %9 = alloca i8*
 store i8* %0, i8** %4
 store i32 %1, i32* %5
 store i32 %2, i32* %6
 %10 = getelementptr %struct.S, i8* %7, i32 0, i32 2
 %11 = getelementptr [624 x i32], i8* %10, i64 0, i64 0
 store i8* %11, i8** %9
 %12 = load i32, i32* %6
 %13 = load i8*, i8** %9
 store i32 %12, i32* %13
 store i32 1, i32* %8
 br label %14
14:
 %15 = load i32, i32* %8
 %16 = icmp ult i32 %15, 624
 br i1 %16, label %17, label %42
17:
 %18 = load i32, i32* %8
 %19 = load i8*, i8** %9
 %20 = load i32, i32* %8
 %21 = sub i32 %20, 1
 %22 = zext i32 %21 to i64
 %23 = getelementptr i32, i8* %19, i64 %22
 %24 = load i32, i32* %23
 %25 = lshr i32 %24, 30
 %26 = load i8*, i8** %9
 %27 = load i32, i32* %8
 %28 = sub i32 %27, 1
 %29 = zext i32 %28 to i64
 %30 = getelementptr i32, i8* %26, i64 %29
 %31 = load i32, i32* %30
 %32 = xor i32 %25, %31
 %33 = mul i32 1812433253, %32
 %34 = add i32 %18, %33
 %35 = load i8*, i8** %9
 %36 = load i32, i32* %8
 %37 = zext i32 %36 to i64
 %38 = getelementptr i32, i8* %35, i64 %37
 store i32 %34, i32* %38
 br label %39
39:
 %40 = load i32, i32* %8
 %41 = add i32 %40, 1
 store i32 %41, i32* %8
 br label %14
42:
 %43 = getelementptr %struct.S, i8* %7, i32 0, i32 1
 store i32 1, i32* %43
 br label %44
44:
 %45 = load i32, i32* %5
 %46 = add i32 %45, -1
 store i32 %46, i32* %5
 %47 = icmp ne i32 %45, 0
 br i1 %47, label %48, label %57
48:
 %49 = call i8 @foo (i8* %7)
 %50 = zext i8 %49 to i32
 %51 = load i8*, i8** %4
 %52 = getelementptr i8, i8* %51, i32 1
 store i8* %52, i8** %4
 %53 = load i8, i8* %51
 %54 = zext i8 %53 to i32
 %55 = xor i32 %54, %50
 %56 = trunc i32 %55 to i8
 store i8 %56, i8* %51
 br label %44
57:
 ret void
}

define i8 @foo (i8* %0) {
 %2 = alloca i8*
 %3 = alloca i32
 %4 = alloca i8*
 %5 = alloca i32
 store i8* %0, i8** %2
 %6 = load i8*, i8** %2
 %7 = getelementptr %struct.S, i8* %6, i32 0, i32 1
 %8 = load i32, i32* %7
 %9 = add i32 %8, -1
 store i32 %9, i32* %7
 %10 = icmp ne i32 %9, 0
 br i1 %10, label %67, label %11
11:
 %12 = load i8*, i8** %2
 %13 = getelementptr %struct.S, i8* %12, i32 0, i32 2
 %14 = getelementptr [624 x i32], i8* %13, i64 0, i64 0
 store i8* %14, i8** %4
 %15 = load i8*, i8** %4
 %16 = load i8*, i8** %2
 %17 = getelementptr %struct.S, i8* %16, i32 0, i32 0
 store i8* %15, i8** %17
 store i32 0, i32* %5
 br label %18
18:
 %19 = load i32, i32* %5
 %20 = icmp ult i32 %19, 227
 br i1 %20, label %21, label %66
21:
 %22 = load i8*, i8** %4
 %23 = load i32, i32* %5
 %24 = zext i32 %23 to i64
 %25 = getelementptr i32, i8* %22, i64 %24
 %26 = load i32, i32* %25
 %27 = load i8*, i8** %4
 %28 = load i32, i32* %5
 %29 = add i32 %28, 1
 %30 = zext i32 %29 to i64
 %31 = getelementptr i32, i8* %27, i64 %30
 %32 = load i32, i32* %31
 %33 = xor i32 %26, %32
 %34 = and i32 %33, 2147483646
 %35 = load i8*, i8** %4
 %36 = load i32, i32* %5
 %37 = zext i32 %36 to i64
 %38 = getelementptr i32, i8* %35, i64 %37
 %39 = load i32, i32* %38
 %40 = xor i32 %34, %39
 %41 = lshr i32 %40, 1
 %42 = load i8*, i8** %4
 %43 = load i32, i32* %5
 %44 = add i32 %43, 1
 %45 = zext i32 %44 to i64
 %46 = getelementptr i32, i8* %42, i64 %45
 %47 = load i32, i32* %46
 %48 = and i32 %47, 1
 %49 = sub i32 0, %48
 %50 = and i32 %49, -1727483681
 %51 = xor i32 %41, %50
 %52 = load i8*, i8** %4
 %53 = load i32, i32* %5
 %54 = add i32 %53, 397
 %55 = zext i32 %54 to i64
 %56 = getelementptr i32, i8* %52, i64 %55
 %57 = load i32, i32* %56
 %58 = xor i32 %51, %57
 %59 = load i8*, i8** %4
 %60 = load i32, i32* %5
 %61 = zext i32 %60 to i64
 %62 = getelementptr i32, i8* %59, i64 %61
 store i32 %58, i32* %62
 br label %63
63:
 %64 = load i32, i32* %5
 %65 = add i32 %64, 1
 store i32 %65, i32* %5
 br label %18
66:
 br label %67
67:
 %68 = load i8*, i8** %2
 %69 = getelementptr %struct.S, i8* %68, i32 0, i32 0
 %70 = load i8*, i8** %69
 %71 = getelementptr i32, i8* %70, i32 1
 store i8* %71, i8** %69
 %72 = load i32, i32* %70
 store i32 %72, i32* %3
 %73 = load i32, i32* %3
 %74 = lshr i32 %73, 11
 %75 = load i32, i32* %3
 %76 = xor i32 %75, %74
 store i32 %76, i32* %3
 %77 = load i32, i32* %3
 %78 = and i32 %77, -12953427
 %79 = shl i32 %78, 7
 %80 = load i32, i32* %3
 %81 = xor i32 %80, %79
 store i32 %81, i32* %3
 %82 = load i32, i32* %3
 %83 = and i32 %82, -8308
 %84 = shl i32 %83, 15
 %85 = load i32, i32* %3
 %86 = xor i32 %85, %84
 store i32 %86, i32* %3
 %87 = load i32, i32* %3
 %88 = lshr i32 %87, 18
 %89 = load i32, i32* %3
 %90 = xor i32 %89, %88
 store i32 %90, i32* %3
 %91 = load i32, i32* %3
 %92 = lshr i32 %91, 1
 %93 = trunc i32 %92 to i8
 ret i8 %93
}
