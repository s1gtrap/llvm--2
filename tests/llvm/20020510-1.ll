declare void @abort()

define void @testc (i8 %0, i32 %1) {
 %3 = alloca i8
 %4 = alloca i32
 store i8 %0, i8* %3
 store i32 %1, i32* %4
 %5 = load i8, i8* %3
 %6 = zext i8 %5 to i32
 %7 = icmp sge i32 %6, 1
 br i1 %7, label %8, label %17
8:
 %9 = load i8, i8* %3
 %10 = zext i8 %9 to i32
 %11 = icmp sle i32 %10, 127
 br i1 %11, label %12, label %17
12:
 %13 = load i32, i32* %4
 %14 = icmp ne i32 %13, 0
 br i1 %14, label %16, label %15
15:
 call void @abort ()
 unreachable
16:
 br label %22
17:
 %18 = load i32, i32* %4
 %19 = icmp ne i32 %18, 0
 br i1 %19, label %20, label %21
20:
 call void @abort ()
 unreachable
21:
 br label %22
22:
 ret void
}

define void @tests (i16 %0, i32 %1) {
 %3 = alloca i16
 %4 = alloca i32
 store i16 %0, i16* %3
 store i32 %1, i32* %4
 %5 = load i16, i16* %3
 %6 = zext i16 %5 to i32
 %7 = icmp sge i32 %6, 1
 br i1 %7, label %8, label %17
8:
 %9 = load i16, i16* %3
 %10 = zext i16 %9 to i32
 %11 = icmp sle i32 %10, 32767
 br i1 %11, label %12, label %17
12:
 %13 = load i32, i32* %4
 %14 = icmp ne i32 %13, 0
 br i1 %14, label %16, label %15
15:
 call void @abort ()
 unreachable
16:
 br label %22
17:
 %18 = load i32, i32* %4
 %19 = icmp ne i32 %18, 0
 br i1 %19, label %20, label %21
20:
 call void @abort ()
 unreachable
21:
 br label %22
22:
 ret void
}

define void @testi (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %3
 %6 = icmp uge i32 %5, 1
 br i1 %6, label %7, label %15
7:
 %8 = load i32, i32* %3
 %9 = icmp ule i32 %8, 2147483647
 br i1 %9, label %10, label %15
10:
 %11 = load i32, i32* %4
 %12 = icmp ne i32 %11, 0
 br i1 %12, label %14, label %13
13:
 call void @abort ()
 unreachable
14:
 br label %20
15:
 %16 = load i32, i32* %4
 %17 = icmp ne i32 %16, 0
 br i1 %17, label %18, label %19
18:
 call void @abort ()
 unreachable
19:
 br label %20
20:
 ret void
}

define void @testl (i64 %0, i32 %1) {
 %3 = alloca i64
 %4 = alloca i32
 store i64 %0, i64* %3
 store i32 %1, i32* %4
 %5 = load i64, i64* %3
 %6 = icmp uge i64 %5, 1
 br i1 %6, label %7, label %15
7:
 %8 = load i64, i64* %3
 %9 = icmp ule i64 %8, 9223372036854775807
 br i1 %9, label %10, label %15
10:
 %11 = load i32, i32* %4
 %12 = icmp ne i32 %11, 0
 br i1 %12, label %14, label %13
13:
 call void @abort ()
 unreachable
14:
 br label %20
15:
 %16 = load i32, i32* %4
 %17 = icmp ne i32 %16, 0
 br i1 %17, label %18, label %19
18:
 call void @abort ()
 unreachable
19:
 br label %20
20:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @testc (i8 0, i32 0)
 call void @testc (i8 1, i32 1)
 call void @testc (i8 127, i32 1)
 call void @testc (i8 -128, i32 0)
 call void @testc (i8 -1, i32 0)
 call void @tests (i16 0, i32 0)
 call void @tests (i16 1, i32 1)
 call void @tests (i16 32767, i32 1)
 call void @tests (i16 -32768, i32 0)
 call void @tests (i16 -1, i32 0)
 call void @testi (i32 0, i32 0)
 call void @testi (i32 1, i32 1)
 call void @testi (i32 2147483647, i32 1)
 call void @testi (i32 -2147483648, i32 0)
 call void @testi (i32 -1, i32 0)
 call void @testl (i64 0, i32 0)
 call void @testl (i64 1, i32 1)
 call void @testl (i64 9223372036854775807, i32 1)
 call void @testl (i64 -9223372036854775808, i32 0)
 call void @testl (i64 -1, i32 0)
 ret i32 0
}
