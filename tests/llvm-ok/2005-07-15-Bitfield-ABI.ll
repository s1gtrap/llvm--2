%union.anon = type { i32 }

@.str = global [4 x i8] c"%x\0A\00"

declare i32 @printf(i8*, ...)

define void @test (i8* %0, i32 %1) {
 %3 = alloca i8*
 %4 = alloca i32
 store i8* %0, i8** %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %4
 %6 = load i8*, i8** %3
 %7 = load i32, i32* %6
 %8 = and i32 %5, 15
 %9 = shl i32 %8, 6
 %10 = and i32 %7, -961
 %11 = or i32 %10, %9
 store i32 %11, i32* %6
 %12 = shl i32 %8, 28
 %13 = ashr i32 %12, 28
 ret void
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca %union.anon
 store i32 0, i32* %1
 store i32 -1, i32* %2
 call void @test (i8* %2, i32 0)
 %3 = load i32, i32* %2
 %4 = call i32 (i8*, ...) @printf (i8* @.str, i32 %3)
 ret i32 0
}
