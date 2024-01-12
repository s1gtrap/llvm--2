@__const.main.a = global [10 x i32] [i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10]

declare void @abort()
declare void @memcpy(i8*, i8*, i64, i1)
declare i32 @abs(i32)

define void @check (i8* %0) {
 %2 = alloca i8*
 %3 = alloca i32
 store i8* %0, i8** %2
 store i32 0, i32* %3
 br label %4
4:
 %5 = load i32, i32* %3
 %6 = icmp slt i32 %5, 5
 br i1 %6, label %7, label %19
7:
 %8 = load i8*, i8** %2
 %9 = load i32, i32* %3
 %10 = sext i32 %9 to i64
 %11 = getelementptr i32, i8* %8, i64 %10
 %12 = load i32, i32* %11
 %13 = icmp ne i32 %12, 0
 br i1 %13, label %14, label %15
14:
 call void @abort ()
 unreachable
15:
 br label %16
16:
 %17 = load i32, i32* %3
 %18 = add i32 %17, 1
 store i32 %18, i32* %3
 br label %4
19:
 br label %20
20:
 %21 = load i32, i32* %3
 %22 = icmp slt i32 %21, 10
 br i1 %22, label %23, label %37
23:
 %24 = load i8*, i8** %2
 %25 = load i32, i32* %3
 %26 = sext i32 %25 to i64
 %27 = getelementptr i32, i8* %24, i64 %26
 %28 = load i32, i32* %27
 %29 = load i32, i32* %3
 %30 = add i32 %29, 1
 %31 = icmp ne i32 %28, %30
 br i1 %31, label %32, label %33
32:
 call void @abort ()
 unreachable
33:
 br label %34
34:
 %35 = load i32, i32* %3
 %36 = add i32 %35, 1
 store i32 %36, i32* %3
 br label %20
37:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca [10 x i32]
 %3 = alloca i32
 store i32 0, i32* %1
 call void @memcpy (i8* %2, i8* @__const.main.a, i64 40, i1 0)
 store i32 -5, i32* %3
 br label %4
4:
 %5 = load i32, i32* %3
 %6 = icmp slt i32 %5, 0
 br i1 %6, label %7, label %17
7:
 %8 = load i32, i32* %3
 %9 = sub i32 %8, 10
 %10 = call i32 @abs (i32 %9)
 %11 = sub i32 %10, 11
 %12 = sext i32 %11 to i64
 %13 = getelementptr [10 x i32], i8* %2, i64 0, i64 %12
 store i32 0, i32* %13
 br label %14
14:
 %15 = load i32, i32* %3
 %16 = add i32 %15, 1
 store i32 %16, i32* %3
 br label %4
17:
 %18 = getelementptr [10 x i32], i8* %2, i64 0, i64 0
 call void @check (i8* %18)
 ret i32 0
}
