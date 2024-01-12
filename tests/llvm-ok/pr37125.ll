declare void @abort()

define void @func_44 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = mul i32 %3, -9
 %5 = call i32 @mod_rhs (i32 -9)
 %6 = urem i32 %4, %5
 %7 = icmp ne i32 %6, 0
 br i1 %7, label %9, label %8
8:
 call void @abort ()
 unreachable
9:
 ret void
}

define i32 @mod_rhs (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 store i32 %0, i32* %3
 %4 = load i32, i32* %3
 %5 = icmp eq i32 %4, 0
 br i1 %5, label %6, label %7
6:
 store i32 1, i32* %2
 br label %9
7:
 %8 = load i32, i32* %3
 store i32 %8, i32* %2
 br label %9
9:
 %10 = load i32, i32* %2
 ret i32 %10
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @func_44 (i32 2)
 ret i32 0
}
