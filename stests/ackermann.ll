@.str = global [3 x i8] c"%d\00"

declare i32 @atoi(i8*)
declare i32 @printf(i8*)

define i32 @ack (i32 %0, i32 %1, i32 %2) {
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i32
 %7 = alloca i32
 store i32 %0, i32* %5
 store i32 %1, i32* %6
 store i32 %2, i32* %7
 %8 = load i32, i32* %7
 %9 = icmp eq i32 %8, 0
 br i1 %9, label %10, label %14
10:
 %11 = load i32, i32* %5
 %12 = load i32, i32* %6
 %13 = add i32 %11, %12
 store i32 %13, i32* %4
 br label %43
14:
 %15 = load i32, i32* %6
 %16 = icmp eq i32 %15, 0
 br i1 %16, label %17, label %21
17:
 %18 = load i32, i32* %7
 %19 = icmp eq i32 %18, 1
 br i1 %19, label %20, label %21
20:
 store i32 0, i32* %4
 br label %43
21:
 %22 = load i32, i32* %6
 %23 = icmp eq i32 %22, 0
 br i1 %23, label %24, label %28
24:
 %25 = load i32, i32* %7
 %26 = icmp eq i32 %25, 2
 br i1 %26, label %27, label %28
27:
 store i32 1, i32* %4
 br label %43
28:
 %29 = load i32, i32* %6
 %30 = icmp eq i32 %29, 0
 br i1 %30, label %31, label %33
31:
 %32 = load i32, i32* %5
 store i32 %32, i32* %4
 br label %43
33:
 %34 = load i32, i32* %5
 %35 = load i32, i32* %5
 %36 = load i32, i32* %6
 %37 = sub i32 %36, 1
 %38 = load i32, i32* %7
 %39 = call i32 @ack (i32 %35, i32 %37, i32 %38)
 %40 = load i32, i32* %7
 %41 = sub i32 %40, 1
 %42 = call i32 @ack (i32 %34, i32 %39, i32 %41)
 store i32 %42, i32* %4
 br label %43
43:
 %44 = load i32, i32* %4
 ret i32 %44
}

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 %6 = alloca i32
 %7 = alloca i32
 %8 = alloca i32
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 %9 = load i8*, i8** %5
 %10 = getelementptr i8*, i8* %9, i64 1
 %11 = load i8*, i8** %10
 %12 = call i32 @atoi (i8* %11)
 store i32 %12, i32* %6
 %13 = load i8*, i8** %5
 %14 = getelementptr i8*, i8* %13, i64 2
 %15 = load i8*, i8** %14
 %16 = call i32 @atoi (i8* %15)
 store i32 %16, i32* %7
 %17 = load i8*, i8** %5
 %18 = getelementptr i8*, i8* %17, i64 3
 %19 = load i8*, i8** %18
 %20 = call i32 @atoi (i8* %19)
 store i32 %20, i32* %8
 %21 = load i32, i32* %6
 %22 = load i32, i32* %7
 %23 = load i32, i32* %8
 %24 = call i32 @ack (i32 %21, i32 %22, i32 %23)
 %25 = call i32 (i8*, ...) @printf (i8* @.str, i32 %24)
 ret i32 0
}
