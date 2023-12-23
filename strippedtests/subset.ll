@.str = global [3 x i8] c"{ \00"
@.str.1 = global [4 x i8] c"%s \00"
@.str.2 = global [3 x i8] c"}\0A\00"

declare i32 @printf(void*)

define i32 @subsets (i32 %0, void* %1) {
 %3 = alloca i32
 %4 = alloca void*
 %5 = alloca i32
 %6 = alloca i32
 store i32 %0, i32* %3
 store void* %1, void** %4
 store i32 0, i32* %5
 br label %7
7:
 %8 = load i32, i32* %5
 %9 = load i32, i32* %3
 %10 = shl i32 1, %9
 %11 = icmp slt i32 %8, %10
 br i1 %11, label %12, label %41
12:
 %13 = call i32( void* ) @printf (void* @.str)
 store i32 0, i32* %6
 br label %14
14:
 %15 = load i32, i32* %6
 %16 = load i32, i32* %3
 %17 = icmp slt i32 %15, %16
 br i1 %17, label %18, label %36
18:
 %19 = load i32, i32* %5
 %20 = load i32, i32* %6
 %21 = shl i32 1, %20
 %22 = and i32 %19, %21
 %23 = icmp ne i32 %22, 0
 br i1 %23, label %24, label %32
24:
 %25 = load void*, void** %4
 %26 = load i32, i32* %6
 %27 = add i32 %26, 1
 %28 = sext i32 %27 to i64
 %29 = getelementptr void*, void** %25, i64 %28
 %30 = load void*, void** %29
 %31 = call i32( void* ) @printf (void* @.str.1, void* %30)
 br label %32
32:
 br label %33
33:
 %34 = load i32, i32* %6
 %35 = add i32 %34, 1
 store i32 %35, i32* %6
 br label %14
36:
 %37 = call i32( void* ) @printf (void* @.str.2)
 br label %38
38:
 %39 = load i32, i32* %5
 %40 = add i32 %39, 1
 store i32 %40, i32* %5
 br label %7
41:
 %42 = load i32, i32* %5
 ret i32 %42
}

define i32 @main (i32 %0, void* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca void*
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store void* %1, void** %5
 %6 = load i32, i32* %4
 %7 = sub i32 %6, 1
 %8 = load void*, void** %5
 %9 = call i32 @subsets (i32 %7, void* %8)
 ret i32 %9
}
