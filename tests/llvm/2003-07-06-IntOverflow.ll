@.str = global [32 x i8] c"compare after overflow is TRUE\0A\00"
@.str.1 = global [33 x i8] c"compare after overflow is FALSE\0A\00"
@.str.2 = global [35 x i8] c"divide after overflow = %d (0x%x)\0A\00"
@.str.3 = global [49 x i8] c"divide negative value by power-of-2 = %d (0x%x)\0A\00"
@.str.4 = global [37 x i8] c"subtract after overflow = %d (0x%x)\0A\00"

declare i32 @printf(i8*, ...)

define void @compareOvf (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %6 = load i32, i32* %3
 %7 = load i32, i32* %3
 %8 = mul i32 %6, %7
 %9 = load i32, i32* %4
 %10 = load i32, i32* %4
 %11 = mul i32 %9, %10
 %12 = add i32 %8, %11
 store i32 %12, i32* %5
 %13 = load i32, i32* %5
 %14 = icmp slt i32 %13, 4194304
 br i1 %14, label %15, label %17
15:
 %16 = call i32 (i8*, ...) @printf (i8* @.str)
 br label %19
17:
 %18 = call i32 (i8*, ...) @printf (i8* @.str.1)
 br label %19
19:
 ret void
}

define void @divideOvf (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %7 = load i32, i32* %3
 %8 = load i32, i32* %3
 %9 = mul i32 %7, %8
 %10 = load i32, i32* %4
 %11 = load i32, i32* %4
 %12 = mul i32 %10, %11
 %13 = add i32 %9, %12
 store i32 %13, i32* %5
 %14 = load i32, i32* %5
 %15 = sdiv i32 -2147483648, %14
 store i32 %15, i32* %6
 %16 = load i32, i32* %6
 %17 = load i32, i32* %6
 %18 = call i32 (i8*, ...) @printf (i8* @.str.2, i32 %16, i32 %17)
 ret void
}

define void @divideNeg (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %7 = load i32, i32* %3
 %8 = load i32, i32* %3
 %9 = mul i32 %7, %8
 %10 = load i32, i32* %4
 %11 = load i32, i32* %4
 %12 = mul i32 %10, %11
 %13 = sub i32 %9, %12
 store i32 %13, i32* %5
 %14 = load i32, i32* %5
 %15 = sdiv i32 %14, 262144
 store i32 %15, i32* %6
 %16 = load i32, i32* %6
 %17 = load i32, i32* %6
 %18 = call i32 (i8*, ...) @printf (i8* @.str.3, i32 %16, i32 %17)
 ret void
}

define void @subtractOvf (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %7 = load i32, i32* %3
 %8 = load i32, i32* %3
 %9 = mul i32 %7, %8
 %10 = load i32, i32* %4
 %11 = load i32, i32* %4
 %12 = mul i32 %10, %11
 %13 = add i32 %9, %12
 store i32 %13, i32* %5
 %14 = load i32, i32* %5
 %15 = sub i32 -2147483648, %14
 store i32 %15, i32* %6
 %16 = load i32, i32* %6
 %17 = load i32, i32* %6
 %18 = call i32 (i8*, ...) @printf (i8* @.str.4, i32 %16, i32 %17)
 ret void
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 store i32 0, i32* %1
 store i32 2097152, i32* %2
 %3 = load i32, i32* %2
 %4 = load i32, i32* %2
 call void @compareOvf (i32 %3, i32 %4)
 %5 = load i32, i32* %2
 %6 = add i32 %5, 1
 %7 = load i32, i32* %2
 %8 = add i32 %7, 2
 call void @divideOvf (i32 %6, i32 %8)
 %9 = load i32, i32* %2
 %10 = add i32 %9, 1
 %11 = load i32, i32* %2
 %12 = add i32 %11, 2
 call void @divideNeg (i32 %10, i32 %12)
 %13 = load i32, i32* %2
 %14 = add i32 %13, 1
 %15 = load i32, i32* %2
 %16 = add i32 %15, 2
 call void @subtractOvf (i32 %14, i32 %16)
 ret i32 0
}
