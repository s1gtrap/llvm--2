declare void @abort()

define i64 @foo (i8 %0, i16 %1, i64 %2, i8 %3, i16 %4, i64 %5, i64 %6, i8 %7, i64 %8) {
 %10 = alloca i8
 %11 = alloca i16
 %12 = alloca i64
 %13 = alloca i8
 %14 = alloca i16
 %15 = alloca i64
 %16 = alloca i64
 %17 = alloca i8
 %18 = alloca i64
 store i8 %0, i8* %10
 store i16 %1, i16* %11
 store i64 %2, i64* %12
 store i8 %3, i8* %13
 store i16 %4, i16* %14
 store i64 %5, i64* %15
 store i64 %6, i64* %16
 store i8 %7, i8* %17
 store i64 %8, i64* %18
 %19 = load i64, i64* %15
 %20 = mul i64 %19, 30512
 store i64 %20, i64* %15
 %21 = load i64, i64* %18
 %22 = load i64, i64* %18
 %23 = mul i64 %22, %21
 store i64 %23, i64* %18
 %24 = load i64, i64* %18
 %25 = load i16, i16* %14
 %26 = zext i16 %25 to i64
 %27 = or i64 %26, %24
 %28 = trunc i64 %27 to i16
 store i16 %28, i16* %14
 %29 = load i64, i64* %18
 %30 = sub i64 %29, 2
 store i64 %30, i64* %18
 %31 = load i64, i64* %16
 %32 = load i8, i8* %17
 %33 = zext i8 %32 to i64
 %34 = udiv i64 %33, %31
 %35 = trunc i64 %34 to i8
 store i8 %35, i8* %17
 %36 = load i8, i8* %10
 %37 = zext i8 %36 to i32
 %38 = or i32 %37, 3
 %39 = trunc i32 %38 to i8
 store i8 %39, i8* %10
 %40 = load i8, i8* %10
 %41 = zext i8 %40 to i64
 %42 = load i64, i64* %18
 %43 = urem i64 %42, %41
 store i64 %43, i64* %18
 %44 = load i8, i8* %10
 %45 = zext i8 %44 to i32
 %46 = sub i32 %45, 1
 %47 = trunc i32 %46 to i8
 store i8 %47, i8* %10
 %48 = load i8, i8* %10
 %49 = zext i8 %48 to i32
 %50 = load i16, i16* %11
 %51 = zext i16 %50 to i32
 %52 = add i32 %49, %51
 %53 = sext i32 %52 to i64
 %54 = load i64, i64* %12
 %55 = add i64 %53, %54
 %56 = load i8, i8* %13
 %57 = zext i8 %56 to i64
 %58 = add i64 %55, %57
 %59 = load i16, i16* %14
 %60 = zext i16 %59 to i64
 %61 = add i64 %58, %60
 %62 = load i64, i64* %15
 %63 = add i64 %61, %62
 %64 = load i8, i8* %17
 %65 = zext i8 %64 to i64
 %66 = add i64 %63, %65
 %67 = load i64, i64* %18
 %68 = add i64 %66, %67
 ret i64 %68
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 store i32 0, i32* %1
 %3 = call i64 @foo (i8 1, i16 1, i64 1, i8 1, i16 1, i64 1, i64 1, i8 1, i64 1)
 %4 = trunc i64 %3 to i32
 store i32 %4, i32* %2
 %5 = load i32, i32* %2
 %6 = icmp ne i32 %5, 30519
 br i1 %6, label %7, label %8
7:
 call void @abort ()
 unreachable
8:
 ret i32 0
}
