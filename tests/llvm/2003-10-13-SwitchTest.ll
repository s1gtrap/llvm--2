@.str = global [6 x i8] c"GOOD\0A\00"
@.str.1 = global [5 x i8] c"BAD\0A\00"

declare i32 @printf(i8*, ...)

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 %6 = load i32, i32* %4
 switch i32 %6, label %7 [
    i32 100, label %9
    i32 101, label %9
    i32 1023, label %9
  ]
7:
 %8 = call i32 (i8*, ...) @printf (i8* @.str)
 store i32 0, i32* %3
 br label %11
9:
 %10 = call i32 (i8*, ...) @printf (i8* @.str.1)
 store i32 1, i32* %3
 br label %11
11:
 %12 = load i32, i32* %3
 ret i32 %12
}
