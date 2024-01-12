@__const.main.x = global [11 x i8] c"IJKLMNOPQR\00"
@.str = global [11 x i8] c"IJKL\00NOPQR\00"
@.str.1 = global [11 x i8] c"IJKLMNOP\00R\00"

declare void @memcpy(i8*, i8*, i64, i1)
declare i32 @memcmp(i8*, i8*, i64)
declare void @abort()

define void @foo (i8* %0) {
 %2 = alloca i8*
 %3 = alloca i32
 store i8* %0, i8** %2
 store i32 0, i32* %3
 br label %4
4:
 %5 = load i32, i32* %3
 %6 = icmp slt i32 %5, 2
 br i1 %6, label %7, label %11
7:
 br label %8
8:
 %9 = load i32, i32* %3
 %10 = add i32 %9, 1
 store i32 %10, i32* %3
 br label %4
11:
 %12 = load i8*, i8** %2
 %13 = load i32, i32* %3
 %14 = load i32, i32* %3
 %15 = add i32 %13, %14
 %16 = sext i32 %15 to i64
 %17 = getelementptr i8, i8* %12, i64 %16
 store i8 0, i8* %17
 ret void
}

define void @bar (i8* %0) {
 %2 = alloca i8*
 %3 = alloca i32
 store i8* %0, i8** %2
 store i32 0, i32* %3
 br label %4
4:
 %5 = load i32, i32* %3
 %6 = icmp slt i32 %5, 2
 br i1 %6, label %7, label %11
7:
 br label %8
8:
 %9 = load i32, i32* %3
 %10 = add i32 %9, 1
 store i32 %10, i32* %3
 br label %4
11:
 %12 = load i8*, i8** %2
 %13 = load i32, i32* %3
 %14 = load i32, i32* %3
 %15 = add i32 %13, %14
 %16 = load i32, i32* %3
 %17 = add i32 %15, %16
 %18 = load i32, i32* %3
 %19 = add i32 %17, %18
 %20 = sext i32 %19 to i64
 %21 = getelementptr i8, i8* %12, i64 %20
 store i8 0, i8* %21
 ret void
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca [11 x i8]
 store i32 0, i32* %1
 call void @memcpy (i8* %2, i8* @__const.main.x, i64 11, i1 0)
 %3 = getelementptr [11 x i8], i8* %2, i64 0, i64 0
 call void @foo (i8* %3)
 %4 = getelementptr [11 x i8], i8* %2, i64 0, i64 0
 %5 = call i32 @memcmp (i8* %4, i8* @.str, i64 11)
 %6 = icmp ne i32 %5, 0
 br i1 %6, label %7, label %8
7:
 call void @abort ()
 unreachable
8:
 %9 = getelementptr [11 x i8], i8* %2, i64 0, i64 4
 store i8 77, i8* %9
 %10 = getelementptr [11 x i8], i8* %2, i64 0, i64 0
 call void @bar (i8* %10)
 %11 = getelementptr [11 x i8], i8* %2, i64 0, i64 0
 %12 = call i32 @memcmp (i8* %11, i8* @.str.1, i64 11)
 %13 = icmp ne i32 %12, 0
 br i1 %13, label %14, label %15
14:
 call void @abort ()
 unreachable
15:
 ret i32 0
}
