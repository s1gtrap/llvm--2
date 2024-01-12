%struct.tree_type = type { i16, [2 x i8] }

declare void @abort()

define i32 @sign_bit_p (i8* %0, i64 %1, i64 %2) {
 %4 = alloca i32
 %5 = alloca i8*
 %6 = alloca i64
 %7 = alloca i64
 %8 = alloca i64
 %9 = alloca i64
 %10 = alloca i64
 %11 = alloca i64
 %12 = alloca i32
 store i8* %0, i8** %5
 store i64 %1, i64* %6
 store i64 %2, i64* %7
 %13 = load i8*, i8** %5
 %14 = load i16, i16* %13
 %15 = and i16 %14, 511
 %16 = zext i16 %15 to i32
 store i32 %16, i32* %12
 %17 = load i32, i32* %12
 %18 = sext i32 %17 to i64
 %19 = icmp ugt i64 %18, 64
 br i1 %19, label %20, label %30
20:
 %21 = load i32, i32* %12
 %22 = sext i32 %21 to i64
 %23 = sub i64 %22, 64
 %24 = sub i64 %23, 1
 %25 = shl i64 1, %24
 store i64 %25, i64* %11
 store i64 0, i64* %9
 %26 = load i32, i32* %12
 %27 = sext i32 %26 to i64
 %28 = sub i64 128, %27
 %29 = lshr i64 -1, %28
 store i64 %29, i64* %10
 store i64 -1, i64* %8
 br label %39
30:
 store i64 0, i64* %11
 %31 = load i32, i32* %12
 %32 = sub i32 %31, 1
 %33 = zext i32 %32 to i64
 %34 = shl i64 1, %33
 store i64 %34, i64* %9
 store i64 0, i64* %10
 %35 = load i32, i32* %12
 %36 = sext i32 %35 to i64
 %37 = sub i64 64, %36
 %38 = lshr i64 -1, %37
 store i64 %38, i64* %8
 br label %39
39:
 %40 = load i64, i64* %6
 %41 = load i64, i64* %10
 %42 = and i64 %40, %41
 %43 = load i64, i64* %11
 %44 = icmp eq i64 %42, %43
 br i1 %44, label %45, label %52
45:
 %46 = load i64, i64* %7
 %47 = load i64, i64* %8
 %48 = and i64 %46, %47
 %49 = load i64, i64* %9
 %50 = icmp eq i64 %48, %49
 br i1 %50, label %51, label %52
51:
 store i32 1, i32* %4
 br label %53
52:
 store i32 0, i32* %4
 br label %53
53:
 %54 = load i32, i32* %4
 ret i32 %54
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca %struct.tree_type
 store i32 0, i32* %1
 %3 = load i16, i16* %2
 %4 = and i16 %3, -512
 %5 = or i16 %4, 1
 store i16 %5, i16* %2
 %6 = call i32 @sign_bit_p (i8* %2, i64 0, i64 -1)
 %7 = icmp ne i32 %6, 0
 br i1 %7, label %9, label %8
8:
 call void @abort ()
 unreachable
9:
 ret i32 0
}
