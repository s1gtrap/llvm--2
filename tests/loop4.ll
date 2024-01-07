define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 store i32 0, i32* %1
 store i32 0, i32* %2
 br label %3
3:
 %4 = load i32, i32* %2
 %5 = icmp slt i32 %4, 2147483647
 br i1 %5, label %6, label %10
6:
 br label %7
7:
 %8 = load i32, i32* %2
 %9 = add i32 %8, 1
 store i32 %9, i32* %2
 br label %3
10:
 ret i32 0
}
