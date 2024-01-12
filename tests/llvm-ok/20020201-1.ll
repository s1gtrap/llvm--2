@cx = global i8 7
@sx = global i16 14
@ix = global i32 21
@lx = global i64 28
@Lx = global i64 35

declare void @abort()
declare void @exit(i32)

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i8
 %3 = alloca i16
 %4 = alloca i32
 %5 = alloca i64
 %6 = alloca i64
 store i32 0, i32* %1
 %7 = load i8, i8* @cx
 %8 = zext i8 %7 to i32
 %9 = sdiv i32 %8, 6
 %10 = trunc i32 %9 to i8
 store i8 %10, i8* %2
 %11 = load i8, i8* %2
 %12 = zext i8 %11 to i32
 %13 = icmp ne i32 %12, 1
 br i1 %13, label %14, label %15
14:
 call void @abort ()
 unreachable
15:
 %16 = load i8, i8* @cx
 %17 = zext i8 %16 to i32
 %18 = srem i32 %17, 6
 %19 = trunc i32 %18 to i8
 store i8 %19, i8* %2
 %20 = load i8, i8* %2
 %21 = zext i8 %20 to i32
 %22 = icmp ne i32 %21, 1
 br i1 %22, label %23, label %24
23:
 call void @abort ()
 unreachable
24:
 %25 = load i16, i16* @sx
 %26 = zext i16 %25 to i32
 %27 = sdiv i32 %26, 6
 %28 = trunc i32 %27 to i16
 store i16 %28, i16* %3
 %29 = load i16, i16* %3
 %30 = zext i16 %29 to i32
 %31 = icmp ne i32 %30, 2
 br i1 %31, label %32, label %33
32:
 call void @abort ()
 unreachable
33:
 %34 = load i16, i16* @sx
 %35 = zext i16 %34 to i32
 %36 = srem i32 %35, 6
 %37 = trunc i32 %36 to i16
 store i16 %37, i16* %3
 %38 = load i16, i16* %3
 %39 = zext i16 %38 to i32
 %40 = icmp ne i32 %39, 2
 br i1 %40, label %41, label %42
41:
 call void @abort ()
 unreachable
42:
 %43 = load i32, i32* @ix
 %44 = udiv i32 %43, 6
 store i32 %44, i32* %4
 %45 = load i32, i32* %4
 %46 = icmp ne i32 %45, 3
 br i1 %46, label %47, label %48
47:
 call void @abort ()
 unreachable
48:
 %49 = load i32, i32* @ix
 %50 = urem i32 %49, 6
 store i32 %50, i32* %4
 %51 = load i32, i32* %4
 %52 = icmp ne i32 %51, 3
 br i1 %52, label %53, label %54
53:
 call void @abort ()
 unreachable
54:
 %55 = load i64, i64* @lx
 %56 = udiv i64 %55, 6
 store i64 %56, i64* %5
 %57 = load i64, i64* %5
 %58 = icmp ne i64 %57, 4
 br i1 %58, label %59, label %60
59:
 call void @abort ()
 unreachable
60:
 %61 = load i64, i64* @lx
 %62 = urem i64 %61, 6
 store i64 %62, i64* %5
 %63 = load i64, i64* %5
 %64 = icmp ne i64 %63, 4
 br i1 %64, label %65, label %66
65:
 call void @abort ()
 unreachable
66:
 %67 = load i64, i64* @Lx
 %68 = udiv i64 %67, 6
 store i64 %68, i64* %6
 %69 = load i64, i64* %6
 %70 = icmp ne i64 %69, 5
 br i1 %70, label %71, label %72
71:
 call void @abort ()
 unreachable
72:
 %73 = load i64, i64* @Lx
 %74 = urem i64 %73, 6
 store i64 %74, i64* %6
 %75 = load i64, i64* %6
 %76 = icmp ne i64 %75, 5
 br i1 %76, label %77, label %78
77:
 call void @abort ()
 unreachable
78:
 call void @exit (i32 0)
 unreachable
}
