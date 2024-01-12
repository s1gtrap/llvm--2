@.str = global [16 x i8] c"Inside foo: %d\0A\00"
@.str.1 = global [25 x i8] c"Return from longjmp: %d\0A\00"

declare i32 @printf(i8*, ...)
declare void @longjmp(i8*, i32)
declare i32 @setjmp(i8*)

define void @foo (i8* %0, i32 %1) {
 %3 = alloca i8*
 %4 = alloca i32
 store i8* %0, i8** %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %4
 %6 = call i32 (i8*, ...) @printf (i8* @.str, i32 %5)
 %7 = load i8*, i8** %3
 %8 = load i32, i32* %4
 call void @longjmp (i8* %7, i32 %8)
 unreachable
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 %3 = alloca [37 x i32]
 %4 = alloca i32
 store i32 0, i32* %1
 store i32 37, i32* %2
 br label %5
5:
 %6 = load i32, i32* %2
 %7 = add i32 %6, -1
 store i32 %7, i32* %2
 %8 = icmp ne i32 %6, 0
 br i1 %8, label %9, label %20
9:
 %10 = getelementptr [37 x i32], i8* %3, i64 0, i64 0
 %11 = call i32 @setjmp (i8* %10)
 store i32 %11, i32* %4
 %12 = icmp ne i32 %11, 0
 br i1 %12, label %13, label %16
13:
 %14 = load i32, i32* %4
 %15 = call i32 (i8*, ...) @printf (i8* @.str.1, i32 %14)
 br label %19
16:
 %17 = getelementptr [37 x i32], i8* %3, i64 0, i64 0
 %18 = load i32, i32* %2
 call void @foo (i8* %17, i32 %18)
 br label %19
19:
 br label %5
20:
 ret i32 0
}
