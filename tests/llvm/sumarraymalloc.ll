@.str = global [11 x i8] c"Sum1 = %d\0A\00"
@.str.1 = global [11 x i8] c"Sum2 = %d\0A\00"

declare i32 @atoi(i8*)
declare i8* @malloc(i64)
declare i32 @printf(i8*, ...)
declare void @free(i8*)

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 %6 = alloca i32
 %7 = alloca i8*
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 %8 = load i32, i32* %4
 %9 = icmp slt i32 %8, 2
 br i1 %9, label %10, label %11
10:
 br label %16
11:
 %12 = load i8*, i8** %5
 %13 = getelementptr i8*, i8* %12, i64 1
 %14 = load i8*, i8** %13
 %15 = call i32 @atoi (i8* %14)
 br label %16
16:
 %17 = phi i32 [100, %10], [%15, %11]
 store i32 %17, i32* %6
 %18 = load i32, i32* %6
 %19 = sext i32 %18 to i64
 %20 = mul i64 4, %19
 %21 = call i8* @malloc (i64 %20)
 store i8* %21, i8** %7
 %22 = load i8*, i8** %7
 %23 = load i32, i32* %6
 call void @FillArray (i8* %22, i32 %23)
 %24 = load i8*, i8** %7
 %25 = call i32 @SumArray (i8* %24, i32 100)
 %26 = call i32 (i8*, ...) @printf (i8* @.str, i32 %25)
 %27 = load i8*, i8** %7
 %28 = call i32 @SumArray2 (i8* %27, i32 100)
 %29 = call i32 (i8*, ...) @printf (i8* @.str.1, i32 %28)
 %30 = load i8*, i8** %7
 call void @free (i8* %30)
 ret i32 0
}

define void @FillArray (i8* %0, i32 %1) {
 %3 = alloca i8*
 %4 = alloca i32
 %5 = alloca i32
 store i8* %0, i8** %3
 store i32 %1, i32* %4
 store i32 0, i32* %5
 br label %6
6:
 %7 = load i32, i32* %5
 %8 = load i32, i32* %4
 %9 = icmp ult i32 %7, %8
 br i1 %9, label %10, label %19
10:
 %11 = load i32, i32* %5
 %12 = load i8*, i8** %3
 %13 = load i32, i32* %5
 %14 = zext i32 %13 to i64
 %15 = getelementptr i32, i8* %12, i64 %14
 store i32 %11, i32* %15
 br label %16
16:
 %17 = load i32, i32* %5
 %18 = add i32 %17, 1
 store i32 %18, i32* %5
 br label %6
19:
 ret void
}

define i32 @SumArray (i8* %0, i32 %1) {
 %3 = alloca i8*
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i32
 store i8* %0, i8** %3
 store i32 %1, i32* %4
 store i32 0, i32* %5
 store i32 0, i32* %6
 br label %7
7:
 %8 = load i32, i32* %6
 %9 = load i32, i32* %4
 %10 = icmp ult i32 %8, %9
 br i1 %10, label %11, label %22
11:
 %12 = load i8*, i8** %3
 %13 = load i32, i32* %6
 %14 = zext i32 %13 to i64
 %15 = getelementptr i32, i8* %12, i64 %14
 %16 = load i32, i32* %15
 %17 = load i32, i32* %5
 %18 = add i32 %17, %16
 store i32 %18, i32* %5
 br label %19
19:
 %20 = load i32, i32* %6
 %21 = add i32 %20, 1
 store i32 %21, i32* %6
 br label %7
22:
 %23 = load i32, i32* %5
 ret i32 %23
}

define i32 @SumArray2 (i8* %0, i32 %1) {
 %3 = alloca i8*
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i32
 store i8* %0, i8** %3
 store i32 %1, i32* %4
 store i32 0, i32* %5
 store i32 0, i32* %6
 br label %7
7:
 %8 = load i32, i32* %6
 %9 = load i32, i32* %4
 %10 = icmp ult i32 %8, %9
 br i1 %10, label %11, label %20
11:
 %12 = load i8*, i8** %3
 %13 = getelementptr i32, i8* %12, i32 1
 store i8* %13, i8** %3
 %14 = load i32, i32* %12
 %15 = load i32, i32* %5
 %16 = add i32 %15, %14
 store i32 %16, i32* %5
 br label %17
17:
 %18 = load i32, i32* %6
 %19 = add i32 %18, 1
 store i32 %19, i32* %6
 br label %7
20:
 %21 = load i32, i32* %5
 ret i32 %21
}
