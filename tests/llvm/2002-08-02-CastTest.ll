@.str = global [4 x i8] c"%d\0A\00"

declare i32 @printf(i8*, ...)

define i32 @test (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = trunc i32 %3 to i8
 %5 = zext i8 %4 to i32
 ret i32 %5
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @test (i32 123456)
 %3 = call i32 (i8*, ...) @printf (i8* @.str, i32 %2)
 ret i32 0
}
