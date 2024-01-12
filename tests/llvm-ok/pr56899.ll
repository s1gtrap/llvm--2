declare void @abort()

define void @f1 (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 store i32 %0, i32* %2
 %4 = load i32, i32* %2
 %5 = sub i32 %4, 1
 %6 = mul i32 -214748365, %5
 store i32 %6, i32* %3
 %7 = load i32, i32* %3
 %8 = icmp ne i32 %7, -1932735285
 br i1 %8, label %9, label %10
9:
 call void @abort ()
 unreachable
10:
 ret void
}

define void @f2 (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 store i32 %0, i32* %2
 %4 = load i32, i32* %2
 %5 = add i32 %4, 1
 %6 = mul i32 214748365, %5
 store i32 %6, i32* %3
 %7 = load i32, i32* %3
 %8 = icmp ne i32 %7, -1932735285
 br i1 %8, label %9, label %10
9:
 call void @abort ()
 unreachable
10:
 ret void
}

define void @f3 (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 store i32 %0, i32* %2
 %4 = load i32, i32* %2
 %5 = sub i32 %4, 1
 %6 = mul i32 -214748365, %5
 store i32 %6, i32* %3
 %7 = load i32, i32* %3
 %8 = icmp ne i32 %7, -1932735285
 br i1 %8, label %9, label %10
9:
 call void @abort ()
 unreachable
10:
 ret void
}

define void @f4 (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 store i32 %0, i32* %2
 %4 = load i32, i32* %2
 %5 = add i32 %4, 1
 %6 = mul i32 214748365, %5
 store i32 %6, i32* %3
 %7 = load i32, i32* %3
 %8 = icmp ne i32 %7, -1932735285
 br i1 %8, label %9, label %10
9:
 call void @abort ()
 unreachable
10:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @f1 (i32 10)
 call void @f2 (i32 -10)
 call void @f3 (i32 10)
 call void @f4 (i32 -10)
 ret i32 0
}
