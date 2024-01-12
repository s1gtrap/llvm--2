@.str = global [6 x i8] c"%lld\0A\00"

declare i32 @printf(i8*, ...)

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 %6 = load i32, i32* %4
 %7 = sext i32 %6 to i64
 %8 = sub i64 %7, 100
 %9 = ashr i64 %8, 38
 %10 = call i32 (i8*, ...) @printf (i8* @.str, i64 %9)
 ret i32 0
}
