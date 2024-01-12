@y = global i32 32768

declare void @abort()

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 store i32 0, i32* %1
 %3 = load i32, i32* @y
 %4 = trunc i32 %3 to i16
 %5 = sext i16 %4 to i32
 store i32 %5, i32* %2
 %6 = load i32, i32* %2
 %7 = xor i32 0, %6
 %8 = zext i32 %7 to i64
 %9 = icmp sgt i64 0, %8
 br i1 %9, label %10, label %11
10:
 call void @abort ()
 unreachable
11:
 %12 = load i32, i32* @y
 %13 = trunc i32 %12 to i16
 %14 = sext i16 %13 to i32
 %15 = xor i32 0, %14
 %16 = zext i32 %15 to i64
 %17 = icmp sgt i64 0, %16
 br i1 %17, label %18, label %19
18:
 call void @abort ()
 unreachable
19:
 %20 = load i32, i32* %2
 %21 = xor i32 0, %20
 %22 = zext i32 %21 to i64
 %23 = icmp slt i64 %22, 0
 br i1 %23, label %24, label %25
24:
 call void @abort ()
 unreachable
25:
 %26 = load i32, i32* @y
 %27 = trunc i32 %26 to i16
 %28 = sext i16 %27 to i32
 %29 = xor i32 0, %28
 %30 = zext i32 %29 to i64
 %31 = icmp slt i64 %30, 0
 br i1 %31, label %32, label %33
32:
 call void @abort ()
 unreachable
33:
 ret i32 0
}
