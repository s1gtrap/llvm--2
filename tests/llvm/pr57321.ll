@a = global i32 1
@b = global i8* null
@c = global i8* null

declare void @memset(i8*, i8, i64, i1)

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 store i32 0, i32* %1
 store i32 0, i32* %2
 %3 = call i32 @foo (i8* %2)
 ret i32 0
}

define i32 @foo (i8* %0) {
 %2 = alloca i8*
 %3 = alloca [7 x [5 x i8*]]
 %4 = alloca [1 x [1 x i8*]]
 store i8* %0, i8** %2
 %5 = load i8*, i8** %2
 %6 = load i32, i32* %5
 %7 = load i32, i32* @a
 %8 = icmp eq i32 %6, %7
 br i1 %8, label %9, label %18
9:
 call void @memset (i8* %3, i8 0, i64 280, i1 0)
 %10 = getelementptr [7 x [5 x i8*]], i8* %3, i64 0, i64 0
 %11 = getelementptr [5 x i8*], i8* %10, i64 0, i64 0
 %12 = getelementptr [1 x [1 x i8*]], i8* %4, i64 0, i64 0
 %13 = getelementptr [1 x i8*], i8* %12, i64 0, i64 0
 store i8* %11, i8** %13
 %14 = load i8*, i8** @c
 %15 = icmp ne i8* %2, %14
 %16 = zext i1 %15 to i32
 %17 = load i8*, i8** @b
 store i32 %16, i32* %17
 br label %18
18:
 ret i32 0
}
