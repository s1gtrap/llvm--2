declare i32 @atoi(i8*)

define i32 @add (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %6 = load i32, i32* %3
 %7 = load i32, i32* %4
 %8 = add i32 %6, %7
 store i32 %8, i32* %5
 %9 = load i32, i32* %5
 ret i32 %9
}

define i32 @mul (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 store i32 0, i32* %5
 store i32 0, i32* %6
 br label %7
7:
 %8 = load i32, i32* %6
 %9 = load i32, i32* %3
 %10 = icmp slt i32 %8, %9
 br i1 %10, label %11, label %18
11:
 %12 = load i32, i32* %5
 %13 = load i32, i32* %4
 %14 = call i32 @add (i32 %12, i32 %13)
 store i32 %14, i32* %5
 br label %15
15:
 %16 = load i32, i32* %6
 %17 = add i32 %16, 1
 store i32 %17, i32* %6
 br label %7
18:
 %19 = load i32, i32* %5
 ret i32 %19
}

define i32 @main(i32 %0, i8* %1) {
 %3 = getelementptr i8*, i8** %1, i64 1
 %4 = load i8*, i8** %3
 %5 = call i32 @atoi (i8* %4)
 %6 = getelementptr i8*, i8** %1, i64 2
 %7 = load i8*, i8** %6
 %8 = call i32 @atoi (i8* %7)
 %9 = call i32 @mul (i32 %5, i32 %8)
 ret i32 %9
}
