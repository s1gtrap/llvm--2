declare i32 @atoi(i8*)

define i32 @isqrt (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i32
 store i32 %0, i32* %3
 %6 = load i32, i32* %3
 %7 = icmp eq i32 %6, 0
 br i1 %7, label %11, label %8
8:
 %9 = load i32, i32* %3
 %10 = icmp eq i32 %9, 1
 br i1 %10, label %11, label %13
11:
 %12 = load i32, i32* %3
 store i32 %12, i32* %2
 br label %28
13:
 store i32 1, i32* %4
 store i32 1, i32* %5
 br label %14
14:
 %15 = load i32, i32* %5
 %16 = load i32, i32* %3
 %17 = icmp sle i32 %15, %16
 br i1 %17, label %18, label %25
18:
 br label %19
19:
 %20 = load i32, i32* %4
 %21 = add i32 %20, 1
 store i32 %21, i32* %4
 %22 = load i32, i32* %4
 %23 = load i32, i32* %4
 %24 = mul i32 %22, %23
 store i32 %24, i32* %5
 br label %14
25:
 %26 = load i32, i32* %4
 %27 = sub i32 %26, 1
 store i32 %27, i32* %2
 br label %28
28:
 %29 = load i32, i32* %2
 ret i32 %29
}

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 %6 = load i8*, i8** %5
 %7 = getelementptr i8*, i8* %6, i64 1
 %8 = load i8*, i8** %7
 %9 = call i32 @atoi (i8* %8)
 %10 = call i32 @isqrt (i32 %9)
 ret i32 %10
}
