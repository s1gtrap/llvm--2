@.str = global [3 x i8] c"%d\00"

declare i32 @printf(i8*, ...)

define i32 @main () {
 %1 = alloca i32
 %2 = alloca [66 x i32]
 %3 = alloca i8*
 store i32 0, i32* %1
 %4 = getelementptr [66 x i32], i8* %2, i64 0, i64 2
 store i32 5, i32* %4
 %5 = getelementptr [66 x i32], i8* %2, i64 0, i64 5
 store i8* %5, i8** %3
 %6 = getelementptr [66 x i32], i8* %2, i64 0, i64 2
 %7 = load i32, i32* %6
 %8 = call i32 (i8*, ...) @printf (i8* @.str, i32 %7)
 ret i32 1
}
