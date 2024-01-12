%struct.big = type { [1000000 x i32] }
%struct.small = type { [10 x i32] }

declare i8* @calloc(i64, i64)
declare void @free(i8*)

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 %6 = alloca i8*
 %7 = alloca i32
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 %8 = call i8* @calloc (i64 1, i64 40)
 store i8* %8, i8** %6
 %9 = load i32, i32* %4
 %10 = icmp sgt i32 %9, 2000
 %11 = zext i1 %10 to i32
 %12 = load i8*, i8** %6
 %13 = call i32 @foo (i32 %11, i8* %12)
 store i32 %13, i32* %7
 %14 = load i8*, i8** %6
 call void @free (i8* %14)
 %15 = load i32, i32* %7
 ret i32 %15
}

define i32 @foo (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i8*
 %5 = alloca i32
 store i32 %0, i32* %3
 store i8* %1, i8** %4
 %6 = load i32, i32* %3
 %7 = icmp ne i32 %6, 0
 br i1 %7, label %8, label %13
8:
 %9 = load i8*, i8** %4
 %10 = getelementptr %struct.big, i8* %9, i32 0, i32 0
 %11 = getelementptr [1000000 x i32], i8* %10, i64 0, i64 999999
 %12 = load i32, i32* %11
 store i32 %12, i32* %5
 br label %18
13:
 %14 = load i8*, i8** %4
 %15 = getelementptr %struct.small, i8* %14, i32 0, i32 0
 %16 = getelementptr [10 x i32], i8* %15, i64 0, i64 0
 %17 = load i32, i32* %16
 store i32 %17, i32* %5
 br label %18
18:
 %19 = load i32, i32* %5
 ret i32 %19
}
