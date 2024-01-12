@.str = global [13 x i8] c"result = %d\0A\00"

declare i32 @printf(i8*, ...)

define i32 @bar () {
 ret i32 15
}

define i32 @foo () {
 %1 = alloca i32
 %2 = alloca i32
 %3 = alloca i32
 %4 = alloca i32
 store i32 0, i32* %3
 store i32 0, i32* %4
 %5 = load i32, i32* %3
 %6 = load i32, i32* %4
 %7 = add i32 %5, %6
 store i32 %7, i32* %2
 %8 = call i32 @bar ()
 store i32 %8, i32* %3
 %9 = call i32 @bar ()
 store i32 %9, i32* %4
 %10 = load i32, i32* %2
 %11 = load i32, i32* %3
 %12 = add i32 %10, %11
 %13 = load i32, i32* %4
 %14 = add i32 %12, %13
 %15 = call i32 (i8*, ...) @printf (i8* @.str, i32 %14)
 %16 = load i32, i32* %1
 ret i32 %16
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @foo ()
 ret i32 0
}
