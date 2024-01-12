declare void @abort()
declare void @exit(i32)

define void @foo (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 %4 = alloca i64
 store i32 %0, i32* %2
 %5 = load i32, i32* %2
 %6 = icmp sgt i32 %5, 0
 br i1 %6, label %7, label %9
7:
 %8 = load i32, i32* %2
 br label %12
9:
 %10 = load i32, i32* %2
 %11 = sub i32 0, %10
 br label %12
12:
 %13 = phi i32 [%8, %7], [%11, %9]
 store i32 %13, i32* %3
 %14 = load i32, i32* %3
 %15 = sext i32 %14 to i64
 store i64 %15, i64* %4
 %16 = load i64, i64* %4
 %17 = icmp sgt i64 %16, 4294967296
 br i1 %17, label %18, label %19
18:
 call void @abort ()
 unreachable
19:
 call void @exit (i32 0)
 unreachable
}

define i32 @main () {
 call void @foo (i32 1)
 ret i32 0
}
