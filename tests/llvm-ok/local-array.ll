@__const.test.student_t = global [32 x i32] [i32 0, i32 12, i32 4, i32 3, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 2, i32 3, i32 4]
@.str = global [20 x i8] c"error: return = %d\0A\00"

declare void @llvm.memcpy.p0.p0.i64(i8*, i8*, i64, i1)
declare i32 @printf(i8*, ...)

define i32 @test (i32 %0) {
 %2 = alloca i32
 %3 = alloca [32 x i32]
 store i32 %0, i32* %2
 call void @memcpy (i8* %3, i8* @__const.test.student_t, i64 128, i1 0)
 %4 = load i32, i32* %2
 %5 = sext i32 %4 to i64
 %6 = getelementptr [32 x i32], i8* %3, i64 0, i64 %5
 %7 = load i32, i32* %6
 ret i32 %7
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 store i32 0, i32* %1
 %3 = call i32 @test (i32 31)
 store i32 %3, i32* %2
 %4 = load i32, i32* %2
 %5 = icmp ne i32 %4, 4
 br i1 %5, label %6, label %9
6:
 %7 = load i32, i32* %2
 %8 = call i32 (i8*, ...) @printf (i8* @.str, i32 %7)
 br label %9
9:
 ret i32 0
}
