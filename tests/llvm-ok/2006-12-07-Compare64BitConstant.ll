@Large = global i64 1407374883553280
@.str = global [8 x i8] c"Works.\0A\00"
@.str.1 = global [10 x i8] c"Doesn't.\0A\00"

declare i32 @printf(i8*, ...)

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 %6 = load i64, i64* @Large
 %7 = ashr i64 %6, 48
 %8 = and i64 %7, 7
 %9 = icmp eq i64 %8, 5
 br i1 %9, label %10, label %12
10:
 %11 = call i32 (i8*, ...) @printf (i8* @.str)
 br label %14
12:
 %13 = call i32 (i8*, ...) @printf (i8* @.str.1)
 br label %14
14:
 ret i32 0
}
