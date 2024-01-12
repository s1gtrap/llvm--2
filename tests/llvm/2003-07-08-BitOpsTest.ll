@.str = global [16 x i8] c"%d %d %d %d %d\0A\00"

declare i32 @printf(i8*, ...)

define void @test (i32 %0, i32 %1, i32 %2, i32 %3) {
 %5 = alloca i32
 %6 = alloca i32
 %7 = alloca i32
 %8 = alloca i32
 %9 = alloca i32
 %10 = alloca i32
 %11 = alloca i32
 %12 = alloca i32
 %13 = alloca i32
 store i32 %0, i32* %5
 store i32 %1, i32* %6
 store i32 %2, i32* %7
 store i32 %3, i32* %8
 %14 = load i32, i32* %5
 %15 = load i32, i32* %6
 %16 = xor i32 %14, %15
 %17 = load i32, i32* %7
 %18 = xor i32 %16, %17
 %19 = load i32, i32* %8
 %20 = xor i32 %18, %19
 store i32 %20, i32* %9
 %21 = load i32, i32* %5
 %22 = load i32, i32* %6
 %23 = or i32 %21, %22
 %24 = load i32, i32* %7
 %25 = or i32 %23, %24
 %26 = load i32, i32* %8
 %27 = or i32 %25, %26
 store i32 %27, i32* %10
 %28 = load i32, i32* %5
 %29 = load i32, i32* %6
 %30 = and i32 %28, %29
 %31 = load i32, i32* %7
 %32 = and i32 %30, %31
 %33 = load i32, i32* %8
 %34 = and i32 %32, %33
 store i32 %34, i32* %11
 %35 = load i32, i32* %5
 %36 = load i32, i32* %6
 %37 = xor i32 %36, -1
 %38 = and i32 %35, %37
 %39 = load i32, i32* %7
 %40 = load i32, i32* %8
 %41 = xor i32 %40, -1
 %42 = and i32 %39, %41
 %43 = xor i32 %38, %42
 store i32 %43, i32* %12
 %44 = load i32, i32* %5
 %45 = load i32, i32* %6
 %46 = xor i32 %45, -1
 %47 = or i32 %44, %46
 %48 = load i32, i32* %7
 %49 = load i32, i32* %8
 %50 = xor i32 %49, -1
 %51 = or i32 %48, %50
 %52 = xor i32 %47, %51
 store i32 %52, i32* %13
 %53 = load i32, i32* %9
 %54 = load i32, i32* %10
 %55 = load i32, i32* %11
 %56 = load i32, i32* %12
 %57 = load i32, i32* %13
 %58 = call i32 (i8*, ...) @printf (i8* @.str, i32 %53, i32 %54, i32 %55, i32 %56, i32 %57)
 ret void
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @test (i32 7, i32 8, i32 -5, i32 5)
 ret i32 0
}
