@.str = global [15 x i8] c"Inside bar %d\0A\00"
@.str.1 = global [26 x i8] c"returning from bar == %d\0A\00"

declare i32 @printf(i8*, ...)
declare void @longjmp(i8*, i32)
declare i32 @setjmp(i8*)

define i32 @bar (i8* %0, i32 %1) {
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
 %2 = alloca [37 x i32]
 %3 = alloca i32
 store i32 0, i32* %1
 %4 = getelementptr [37 x i32], i8* %2, i64 0, i64 0
 %5 = call i32 @setjmp (i8* %4)
 store i32 %5, i32* %3
 %6 = icmp ne i32 %5, 0
 br i1 %6, label %7, label %20
7:
 %8 = load i32, i32* %3
 %9 = call i32 (i8*, ...) @printf (i8* @.str.1, i32 %8)
 %10 = getelementptr [37 x i32], i8* %2, i64 0, i64 0
 %11 = call i32 @setjmp (i8* %10)
 store i32 %11, i32* %3
 %12 = icmp ne i32 %11, 0
 br i1 %12, label %13, label %16
13:
 %14 = load i32, i32* %3
 %15 = call i32 (i8*, ...) @printf (i8* @.str.1, i32 %14)
 br label %19
16:
 %17 = getelementptr [37 x i32], i8* %2, i64 0, i64 0
 %18 = call i32 @bar (i8* %17, i32 927)
 br label %19
19:
 br label %23
20:
 %21 = getelementptr [37 x i32], i8* %2, i64 0, i64 0
 %22 = call i32 @bar (i8* %21, i32 37)
 br label %23
23:
 ret i32 0
}
