@.str = global [4 x i8] c"%d\0A\00"

declare i32 @printf(i8*, ...)

define void @testL (i64 %0) {
 %2 = alloca i64
 store i64 %0, i64* %2
 %3 = load i64, i64* %2
 %4 = sdiv i64 %3, 16
 %5 = trunc i64 %4 to i32
 %6 = call i32 (i8*, ...) @printf (i8* @.str, i32 %5)
 %7 = load i64, i64* %2
 %8 = sdiv i64 %7, 70368744177664
 %9 = trunc i64 %8 to i32
 %10 = call i32 (i8*, ...) @printf (i8* @.str, i32 %9)
 ret void
}

define void @test (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = sdiv i32 %3, 1
 %5 = call i32 (i8*, ...) @printf (i8* @.str, i32 %4)
 %6 = load i32, i32* %2
 %7 = sdiv i32 %6, 16
 %8 = call i32 (i8*, ...) @printf (i8* @.str, i32 %7)
 %9 = load i32, i32* %2
 %10 = sdiv i32 %9, 262144
 %11 = call i32 (i8*, ...) @printf (i8* @.str, i32 %10)
 %12 = load i32, i32* %2
 %13 = sdiv i32 %12, 1073741824
 %14 = call i32 (i8*, ...) @printf (i8* @.str, i32 %13)
 ret void
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 %3 = alloca i64
 store i32 0, i32* %1
 store i32 -1048576, i32* %2
 store i64 -9007199254740992, i64* %3
 %4 = load i32, i32* %2
 %5 = add i32 %4, 32
 call void @test (i32 %5)
 %6 = load i32, i32* %2
 %7 = add i32 %6, 33
 call void @test (i32 %7)
 %8 = load i64, i64* %3
 %9 = add i64 %8, 64
 call void @testL (i64 %9)
 %10 = load i64, i64* %3
 %11 = add i64 %10, 65
 call void @testL (i64 %11)
 ret i32 0
}
