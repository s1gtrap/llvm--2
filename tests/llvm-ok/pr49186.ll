declare void @abort()

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 %3 = alloca i64
 store i32 0, i32* %1
 store i64 68719476737, i64* %3
 %4 = load i64, i64* %3
 %5 = icmp ult i64 %4, 128
 br i1 %5, label %6, label %7
6:
 br label %12
7:
 %8 = load i64, i64* %3
 %9 = icmp ult i64 %8, 2048
 %10 = zext i1 %9 to i64
 %11 = select i1 %9, i32 2, i32 3
 br label %12
12:
 %13 = phi i32 [1, %6], [%11, %7]
 store i32 %13, i32* %2
 %14 = load i32, i32* %2
 %15 = icmp ne i32 %14, 3
 br i1 %15, label %16, label %17
16:
 call void @abort ()
 unreachable
17:
 ret i32 0
}
