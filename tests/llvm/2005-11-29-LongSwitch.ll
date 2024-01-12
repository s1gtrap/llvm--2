@.str = global [10 x i8] c"foo = %d\0A\00"

declare i32 @printf(i8*, ...)

define i32 @foo (i64 %0) {
 %2 = alloca i32
 %3 = alloca i64
 store i64 %0, i64* %3
 %4 = load i64, i64* %3
 switch i64 %4, label %7 [
    i64 0, label %5
    i64 -1, label %6
  ]
5:
 store i32 1, i32* %2
 br label %8
6:
 store i32 2, i32* %2
 br label %8
7:
 store i32 0, i32* %2
 br label %8
8:
 %9 = load i32, i32* %2
 ret i32 %9
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 store i32 0, i32* %1
 %3 = call i32 @foo (i64 4294967295)
 store i32 %3, i32* %2
 %4 = load i32, i32* %2
 %5 = call i32 (i8*, ...) @printf (i8* @.str, i32 %4)
 %6 = load i32, i32* %2
 ret i32 %6
}
