@window_size = global i64 65536
@.str = global [4 x i8] c"%d\0A\00"

declare i32 @printf(i8*, ...)

define i32 @test () {
 %1 = load i64, i64* @window_size
 %2 = trunc i64 %1 to i32
 ret i32 %2
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @test ()
 %3 = call i32 (i8*, ...) @printf (i8* @.str, i32 %2)
 ret i32 0
}
