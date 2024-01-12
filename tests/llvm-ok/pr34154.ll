declare void @abort()

define i32 @foo (i64 %0) {
 %2 = alloca i32
 %3 = alloca i64
 store i64 %0, i64* %3
 %4 = load i64, i64* %3
 switch i64 %4, label %6 [

  ]
5:
 store i32 19, i32* %2
 br label %10
6:
 %7 = sub i64 %4, 1000000000000000000
 %8 = icmp ule i64 %7, 8999999999999999999
 br i1 %8, label %5, label %9
9:
 store i32 20, i32* %2
 br label %10
10:
 %11 = load i32, i32* %2
 ret i32 %11
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i64
 store i32 0, i32* %1
 store i64 1000000000000000000, i64* %2
 %3 = load i64, i64* %2
 %4 = call i32 @foo (i64 %3)
 %5 = icmp ne i32 %4, 19
 br i1 %5, label %6, label %7
6:
 call void @abort ()
 unreachable
7:
 ret i32 0
}
