@.str = global [4 x i8] c"%lu\00"

declare i32 @sprintf(i8*, i8*, ...)
declare void @abort()

define void @foo (i64 %0) {
 %2 = alloca i64
 %3 = alloca [30 x i8]
 %4 = alloca i64
 store i64 %0, i64* %2
 %5 = getelementptr [30 x i8], i8* %3, i64 0, i64 0
 %6 = load i64, i64* %2
 %7 = call i32 (i8*, i8*, ...) @sprintf (i8* %5, i8* @.str, i64 %6)
 %8 = sext i32 %7 to i64
 store i64 %8, i64* %4
 %9 = load i64, i64* %4
 %10 = icmp ne i64 %9, 4
 br i1 %10, label %11, label %12
11:
 call void @abort ()
 unreachable
12:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @foo (i64 1000)
 ret i32 0
}
