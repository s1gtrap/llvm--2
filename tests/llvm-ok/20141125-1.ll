declare void @abort()

define i32 @f (i64 %0) {
 %2 = alloca i32
 %3 = alloca i64
 store i64 %0, i64* %3
 %4 = load i64, i64* %3
 %5 = and i64 %4, 288230376151711743
 %6 = icmp ne i64 %5, 0
 br i1 %6, label %7, label %8
7:
 store i32 1, i32* %2
 br label %9
8:
 store i32 1024, i32* %2
 br label %9
9:
 %10 = load i32, i32* %2
 ret i32 %10
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @f (i64 5203730698787094528)
 %3 = icmp ne i32 %2, 1
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 %6 = call i32 @f (i64 -288230376151711744)
 %7 = icmp ne i32 %6, 1024
 br i1 %7, label %8, label %9
8:
 call void @abort ()
 unreachable
9:
 ret i32 0
}
