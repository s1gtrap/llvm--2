@.str = global [14 x i8] c"bs0  = %d %d\0A\00"

declare i32 @printf(i8*, ...)

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 %6 = alloca i8
 %7 = alloca i8
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 store i8 -1, i8* %6
 store i8 -1, i8* %7
 %8 = load i8, i8* %6
 %9 = sext i8 %8 to i32
 %10 = load i8, i8* %7
 %11 = zext i8 %10 to i32
 %12 = call i32 (i8*, ...) @printf (i8* @.str, i32 %9, i32 %11)
 ret i32 0
}
