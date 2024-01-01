define i32 @add (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %6 = load i32, i32* %3
 %7 = load i32, i32* %4
 %8 = add i32 %6, %7
 store i32 %8, i32* %5
 %9 = load i32, i32* %5
 ret i32 %9
}
