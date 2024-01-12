@.str = global [3 x i8] c"C\0A\00"
@.str.1 = global [3 x i8] c"A\0A\00"
@.str.2 = global [3 x i8] c"B\0A\00"
@.str.3 = global [3 x i8] c"D\0A\00"

declare i32 @printf(i8*, ...)

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 store i32 0, i32* %1
 store i32 0, i32* %2
 br label %3
3:
 %4 = load i32, i32* %2
 %5 = icmp ult i32 %4, 10
 br i1 %5, label %6, label %12
6:
 %7 = load i32, i32* %2
 %8 = call i32 @func (i32 %7)
 br label %9
9:
 %10 = load i32, i32* %2
 %11 = add i32 %10, 1
 store i32 %11, i32* %2
 br label %3
12:
 ret i32 0
}

define i32 @func (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 store i32 %0, i32* %2
 store i32 4, i32* %3
 %4 = load i32, i32* %2
 switch i32 %4, label %12 [
    i32 8, label %5
    i32 0, label %7
    i32 3, label %7
    i32 2, label %7
    i32 1, label %9
    i32 7, label %9
    i32 9, label %10
  ]
5:
 %6 = call i32 (i8*, ...) @printf (i8* @.str)
 store i32 6, i32* %3
 br label %7
7:
 %8 = call i32 (i8*, ...) @printf (i8* @.str.1)
 br label %14
9:
 store i32 7, i32* %3
 br label %10
10:
 %11 = call i32 (i8*, ...) @printf (i8* @.str.2)
 br label %14
12:
 %13 = call i32 (i8*, ...) @printf (i8* @.str.3)
 store i32 1, i32* %3
 br label %14
14:
 %15 = load i32, i32* %3
 ret i32 %15
}
