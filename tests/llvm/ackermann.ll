@.str = global [15 x i8] c"Ack(3,%d): %d\0A\00"

declare i32 @atoi(i8*)
declare i32 @printf(i8*, ...)

define i32 @Ack (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i32
 store i32 %0, i32* %4
 store i32 %1, i32* %5
 %6 = load i32, i32* %4
 %7 = icmp eq i32 %6, 0
 br i1 %7, label %8, label %11
8:
 %9 = load i32, i32* %5
 %10 = add i32 %9, 1
 store i32 %10, i32* %3
 br label %26
11:
 %12 = load i32, i32* %5
 %13 = icmp eq i32 %12, 0
 br i1 %13, label %14, label %18
14:
 %15 = load i32, i32* %4
 %16 = sub i32 %15, 1
 %17 = call i32 @Ack (i32 %16, i32 1)
 store i32 %17, i32* %3
 br label %26
18:
 %19 = load i32, i32* %4
 %20 = sub i32 %19, 1
 %21 = load i32, i32* %4
 %22 = load i32, i32* %5
 %23 = sub i32 %22, 1
 %24 = call i32 @Ack (i32 %21, i32 %23)
 %25 = call i32 @Ack (i32 %20, i32 %24)
 store i32 %25, i32* %3
 br label %26
26:
 %27 = load i32, i32* %3
 ret i32 %27
}

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 %6 = alloca i32
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 %7 = load i32, i32* %4
 %8 = icmp eq i32 %7, 2
 br i1 %8, label %9, label %14
9:
 %10 = load i8*, i8** %5
 %11 = getelementptr i8*, i8* %10, i64 1
 %12 = load i8*, i8** %11
 %13 = call i32 @atoi (i8* %12)
 br label %15
14:
 br label %15
15:
 %16 = phi i32 [%13, %9], [8, %14]
 store i32 %16, i32* %6
 %17 = load i32, i32* %6
 %18 = load i32, i32* %6
 %19 = call i32 @Ack (i32 3, i32 %18)
 %20 = call i32 (i8*, ...) @printf (i8* @.str, i32 %17, i32 %19)
 ret i32 0
}
