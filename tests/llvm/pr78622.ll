@.str = global [5 x i8] c"%hhd\00"
@.str.1 = global [14 x i8] c"\22%hhd\22 => %i\0A\00"

declare i32 @snprintf(i8*, i64, i8*, ...)
declare i32 @printf(i8*, ...)
declare void @abort()

define i32 @foo (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 %4 = alloca [5 x i8]
 %5 = alloca i32
 store i32 %0, i32* %3
 %6 = load i32, i32* %3
 %7 = icmp slt i32 %6, 4104
 br i1 %7, label %11, label %8
8:
 %9 = load i32, i32* %3
 %10 = icmp sge i32 %9, 4360
 br i1 %10, label %11, label %12
11:
 store i32 -1, i32* %2
 br label %22
12:
 %13 = getelementptr [5 x i8], i8* %4, i64 0, i64 0
 %14 = load i32, i32* %3
 %15 = add i32 %14, 1
 %16 = call i32 (i8*, i64, i8*, ...) @snprintf (i8* %13, i64 5, i8* @.str, i32 %15)
 store i32 %16, i32* %5
 %17 = load i32, i32* %3
 %18 = add i32 %17, 1
 %19 = load i32, i32* %5
 %20 = call i32 (i8*, ...) @printf (i8* @.str.1, i32 %18, i32 %19)
 %21 = load i32, i32* %5
 store i32 %21, i32* %2
 br label %22
22:
 %23 = load i32, i32* %2
 ret i32 %23
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @foo (i32 4104)
 %3 = icmp ne i32 %2, 1
 br i1 %3, label %25, label %4
4:
 %5 = call i32 @foo (i32 4127)
 %6 = icmp ne i32 %5, 2
 br i1 %6, label %25, label %7
7:
 %8 = call i32 @foo (i32 4222)
 %9 = icmp ne i32 %8, 3
 br i1 %9, label %25, label %10
10:
 %11 = call i32 @foo (i32 4223)
 %12 = icmp ne i32 %11, 4
 br i1 %12, label %25, label %13
13:
 %14 = call i32 @foo (i32 4335)
 %15 = icmp ne i32 %14, 3
 br i1 %15, label %25, label %16
16:
 %17 = call i32 @foo (i32 4343)
 %18 = icmp ne i32 %17, 2
 br i1 %18, label %25, label %19
19:
 %20 = call i32 @foo (i32 4350)
 %21 = icmp ne i32 %20, 2
 br i1 %21, label %25, label %22
22:
 %23 = call i32 @foo (i32 4351)
 %24 = icmp ne i32 %23, 1
 br i1 %24, label %25, label %26
25:
 call void @abort ()
 unreachable
26:
 ret i32 0
}
