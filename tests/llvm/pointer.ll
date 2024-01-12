@.str = global [7 x i8] c"error\0A\00"
@.str.1 = global [27 x i8] c"error2: &i31=%p, ret = %p\0A\00"

declare i32 @printf(i8*, ...)

define i8* @test (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 %3 = load i8*, i8** %2
 %4 = getelementptr i32, i8* %3, i64 -1
 ret i8* %4
}

define i8* @test2 (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 %3 = load i8*, i8** %2
 %4 = getelementptr i32, i8* %3, i64 -1
 ret i8* %4
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 %3 = alloca i32
 store i32 0, i32* %1
 %4 = call i8* @test (i8* %2)
 %5 = getelementptr i32, i8* %4, i64 1
 %6 = icmp ne i8* %2, %5
 br i1 %6, label %7, label %9
7:
 %8 = call i32 (i8*, ...) @printf (i8* @.str)
 br label %9
9:
 %10 = call i8* @test2 (i8* %3)
 %11 = getelementptr i32, i8* %10, i64 1
 %12 = icmp ne i8* %3, %11
 br i1 %12, label %13, label %16
13:
 %14 = call i8* @test2 (i8* %3)
 %15 = call i32 (i8*, ...) @printf (i8* @.str.1, i8* %3, i8* %14)
 br label %16
16:
 ret i32 0
}
