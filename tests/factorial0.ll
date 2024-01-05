define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 %6 = alloca i32
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 store i32 1, i32* %6
 br label %7
7:
 %8 = load i32, i32* %4
 %9 = icmp sgt i32 %8, 1
 br i1 %9, label %10, label %17
10:
 %11 = load i32, i32* %4
 %12 = load i32, i32* %6
 %13 = mul i32 %12, %11
 store i32 %13, i32* %6
 br label %14
14:
 %15 = load i32, i32* %4
 %16 = add i32 %15, -1
 store i32 %16, i32* %4
 br label %7
17:
 %18 = load i32, i32* %6
 ret i32 %18
}
