declare void @abort()

define i32 @always_one_1 (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 store i32 %0, i32* %3
 %4 = load i32, i32* %3
 %5 = sdiv i32 %4, 100
 %6 = icmp sge i32 %5, -999999999
 br i1 %6, label %7, label %8
7:
 store i32 1, i32* %2
 br label %9
8:
 store i32 0, i32* %2
 br label %9
9:
 %10 = load i32, i32* %2
 ret i32 %10
}

define i32 @always_one_2 (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 store i32 %0, i32* %3
 %4 = load i32, i32* %3
 %5 = sdiv i32 %4, 100
 %6 = icmp slt i32 %5, -999999999
 br i1 %6, label %7, label %8
7:
 store i32 0, i32* %2
 br label %9
8:
 store i32 1, i32* %2
 br label %9
9:
 %10 = load i32, i32* %2
 ret i32 %10
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @always_one_1 (i32 0)
 %3 = icmp ne i32 %2, 1
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 %6 = call i32 @always_one_2 (i32 0)
 %7 = icmp ne i32 %6, 1
 br i1 %7, label %8, label %9
8:
 call void @abort ()
 unreachable
9:
 ret i32 0
}
