%struct.foo_t = type { i32, i32 }

declare void @abort()

define i64 @foo (i8* %0, i64 %1, i32 %2) {
 %4 = alloca i64
 %5 = alloca i8*
 %6 = alloca i64
 %7 = alloca i32
 %8 = alloca i64
 %9 = alloca i32
 %10 = alloca i32
 store i8* %0, i8** %5
 store i64 %1, i64* %6
 store i32 %2, i32* %7
 %11 = load i64, i64* %6
 %12 = load i64, i64* %6
 %13 = load i8*, i8** %5
 %14 = getelementptr %struct.foo_t, i8* %13, i32 0, i32 0
 %15 = load i32, i32* %14
 %16 = zext i32 %15 to i64
 %17 = srem i64 %12, %16
 %18 = sub i64 %11, %17
 store i64 %18, i64* %8
 %19 = load i64, i64* %6
 %20 = load i64, i64* %8
 %21 = sub i64 %19, %20
 %22 = trunc i64 %21 to i32
 store i32 %22, i32* %9
 %23 = load i32, i32* %9
 %24 = load i32, i32* %7
 %25 = add i32 %23, %24
 %26 = load i8*, i8** %5
 %27 = getelementptr %struct.foo_t, i8* %26, i32 0, i32 0
 %28 = load i32, i32* %27
 %29 = add i32 %25, %28
 %30 = sub i32 %29, 1
 %31 = load i8*, i8** %5
 %32 = getelementptr %struct.foo_t, i8* %31, i32 0, i32 0
 %33 = load i32, i32* %32
 %34 = udiv i32 %30, %33
 %35 = load i8*, i8** %5
 %36 = getelementptr %struct.foo_t, i8* %35, i32 0, i32 0
 %37 = load i32, i32* %36
 %38 = mul i32 %34, %37
 store i32 %38, i32* %10
 %39 = load i8*, i8** %5
 %40 = getelementptr %struct.foo_t, i8* %39, i32 0, i32 0
 %41 = load i32, i32* %40
 %42 = load i32, i32* %10
 %43 = icmp ult i32 %41, %42
 br i1 %43, label %44, label %45
44:
 store i64 -1, i64* %4
 br label %61
45:
 %46 = load i8*, i8** %5
 %47 = getelementptr %struct.foo_t, i8* %46, i32 0, i32 1
 %48 = load i32, i32* %47
 %49 = load i8*, i8** %5
 %50 = getelementptr %struct.foo_t, i8* %49, i32 0, i32 0
 %51 = load i32, i32* %50
 %52 = icmp ugt i32 %48, %51
 br i1 %52, label %53, label %59
53:
 %54 = load i8*, i8** %5
 %55 = getelementptr %struct.foo_t, i8* %54, i32 0, i32 0
 %56 = load i32, i32* %55
 %57 = load i8*, i8** %5
 %58 = getelementptr %struct.foo_t, i8* %57, i32 0, i32 1
 store i32 %56, i32* %58
 br label %59
59:
 %60 = load i64, i64* %8
 store i64 %60, i64* %4
 br label %61
61:
 %62 = load i64, i64* %4
 ret i64 %62
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca %struct.foo_t
 %3 = alloca i64
 store i32 0, i32* %1
 %4 = getelementptr %struct.foo_t, i8* %2, i32 0, i32 0
 store i32 8192, i32* %4
 %5 = getelementptr %struct.foo_t, i8* %2, i32 0, i32 1
 store i32 0, i32* %5
 %6 = call i64 @foo (i8* %2, i64 0, i32 4096)
 store i64 %6, i64* %3
 %7 = load i64, i64* %3
 %8 = icmp ne i64 %7, 0
 br i1 %8, label %9, label %10
9:
 call void @abort ()
 unreachable
10:
 ret i32 0
}
