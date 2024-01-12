declare void @abort()

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @test1 (i32 16384)
 call void @test2 (i32 16384)
 ret i32 0
}

define void @test1 (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 %4 = alloca i16
 %5 = alloca i32
 store i32 %0, i32* %2
 %6 = load i32, i32* %2
 %7 = mul i32 %6, 2
 %8 = trunc i32 %7 to i16
 %9 = sext i16 %8 to i32
 %10 = mul i32 %9, 3
 store i32 %10, i32* %3
 %11 = load i32, i32* %2
 %12 = mul i32 %11, 2
 %13 = trunc i32 %12 to i16
 store i16 %13, i16* %4
 %14 = load i16, i16* %4
 %15 = sext i16 %14 to i32
 %16 = mul i32 %15, 3
 store i32 %16, i32* %5
 %17 = load i32, i32* %3
 %18 = load i32, i32* %5
 %19 = icmp ne i32 %17, %18
 br i1 %19, label %20, label %21
20:
 call void @abort ()
 unreachable
21:
 ret void
}

define void @test2 (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 %4 = alloca i16
 %5 = alloca i32
 store i32 %0, i32* %2
 %6 = load i32, i32* %2
 %7 = shl i32 %6, 1
 %8 = trunc i32 %7 to i16
 %9 = sext i16 %8 to i32
 %10 = mul i32 %9, 3
 store i32 %10, i32* %3
 %11 = load i32, i32* %2
 %12 = shl i32 %11, 1
 %13 = trunc i32 %12 to i16
 store i16 %13, i16* %4
 %14 = load i16, i16* %4
 %15 = sext i16 %14 to i32
 %16 = mul i32 %15, 3
 store i32 %16, i32* %5
 %17 = load i32, i32* %3
 %18 = load i32, i32* %5
 %19 = icmp ne i32 %17, %18
 br i1 %19, label %20, label %21
20:
 call void @abort ()
 unreachable
21:
 ret void
}
