@__const.test.array = global [300 x i32] [i32 17, i32 53, i32 523, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49, i32 17, i32 23, i32 123, i32 123, i32 49]
@.str = global [7 x i8] c"error\0A\00"
@.str.1 = global [8 x i8] c"error2\0A\00"

declare void @memset(i8*, i8, i64, i1)
declare void @memcpy(i8*, i8*, i64, i1)
declare i32 @printf(i8*, ...)

define i32 @test (i32 %0) {
 %2 = alloca i32
 %3 = alloca [1000 x i32]
 %4 = alloca [1000 x i8]
 %5 = alloca [300 x i32]
 store i32 %0, i32* %2
 call void @memset (i8* %3, i8 0, i64 4000, i1 0)
 call void @memset (i8* %4, i8 0, i64 1000, i1 0)
 %6 = getelementptr [1000 x i8], i8* %4, i32 0, i32 0
 store i8 102, i8* %6
 %7 = getelementptr [1000 x i8], i8* %4, i32 0, i32 1
 store i8 111, i8* %7
 %8 = getelementptr [1000 x i8], i8* %4, i32 0, i32 2
 store i8 111, i8* %8
 call void @memcpy (i8* %5, i8* @__const.test.array, i64 1200, i1 0)
 %9 = load i32, i32* %2
 %10 = sext i32 %9 to i64
 %11 = getelementptr [300 x i32], i8* %5, i64 0, i64 %10
 %12 = load i32, i32* %11
 ret i32 %12
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @test (i32 1)
 %3 = icmp ne i32 %2, 53
 br i1 %3, label %4, label %6
4:
 %5 = call i32 (i8*, ...) @printf (i8* @.str)
 br label %6
6:
 %7 = call i32 @test (i32 2)
 %8 = icmp ne i32 %7, 523
 br i1 %8, label %9, label %11
9:
 %10 = call i32 (i8*, ...) @printf (i8* @.str.1)
 br label %11
11:
 ret i32 0
}