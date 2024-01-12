%struct.test = type { i64, i32 }

@tests = global [5 x %struct.test] [%struct.test {i64 -1152921504606846976, i32 -1}, %struct.test {i64 -1152921504606846977, i32 1}, %struct.test {i64 -1152921504606846975, i32 -1}, %struct.test {i64 0, i32 -1}, %struct.test {i64 -9223372036854775808, i32 1}]

declare void @abort()

define i32 @movegt (i32 %0, i32 %1, i64 %2) {
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i64
 %7 = alloca i32
 %8 = alloca i32
 store i32 %0, i32* %4
 store i32 %1, i32* %5
 store i64 %2, i64* %6
 store i32 0, i32* %8
 store i32 0, i32* %7
 br label %9
9:
 %10 = load i32, i32* %7
 %11 = load i32, i32* %5
 %12 = icmp slt i32 %10, %11
 br i1 %12, label %13, label %24
13:
 %14 = load i64, i64* %6
 %15 = icmp sge i64 %14, -1152921504606846976
 br i1 %15, label %16, label %18
16:
 %17 = load i32, i32* %4
 store i32 %17, i32* %8
 br label %20
18:
 %19 = load i32, i32* %5
 store i32 %19, i32* %8
 br label %20
20:
 br label %21
21:
 %22 = load i32, i32* %7
 %23 = add i32 %22, 1
 store i32 %23, i32* %7
 br label %9
24:
 %25 = load i32, i32* %8
 ret i32 %25
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 store i32 0, i32* %1
 store i32 0, i32* %2
 br label %3
3:
 %4 = load i32, i32* %2
 %5 = sext i32 %4 to i64
 %6 = icmp ult i64 %5, 5
 br i1 %6, label %7, label %25
7:
 %8 = load i32, i32* %2
 %9 = sext i32 %8 to i64
 %10 = getelementptr [5 x %struct.test], i8* @tests, i64 0, i64 %9
 %11 = getelementptr %struct.test, i8* %10, i32 0, i32 0
 %12 = load i64, i64* %11
 %13 = call i32 @movegt (i32 -1, i32 1, i64 %12)
 %14 = load i32, i32* %2
 %15 = sext i32 %14 to i64
 %16 = getelementptr [5 x %struct.test], i8* @tests, i64 0, i64 %15
 %17 = getelementptr %struct.test, i8* %16, i32 0, i32 1
 %18 = load i32, i32* %17
 %19 = icmp ne i32 %13, %18
 br i1 %19, label %20, label %21
20:
 call void @abort ()
 unreachable
21:
 br label %22
22:
 %23 = load i32, i32* %2
 %24 = add i32 %23, 1
 store i32 %24, i32* %2
 br label %3
25:
 ret i32 0
}
