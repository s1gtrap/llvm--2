@.str = global [6 x i8] c"abcde\00"

declare i32 @sprintf(i8*, i8*, ...)
declare void @abort()

define i8* @foo (i8* %0, i8* %1) {
 %3 = alloca i8*
 %4 = alloca i8*
 store i8* %0, i8** %3
 store i8* %1, i8** %4
 %5 = load i8*, i8** %3
 %6 = load i8*, i8** %4
 %7 = getelementptr i8, i8* %6, i32 1
 store i8* %7, i8** %4
 %8 = call i32 (i8*, i8*, ...) @sprintf (i8* %5, i8* @.str, i8* %6)
 %9 = load i8*, i8** %4
 ret i8* %9
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca [6 x i8]
 store i32 0, i32* %1
 %3 = getelementptr [6 x i8], i8* %2, i64 0, i64 0
 %4 = getelementptr [6 x i8], i8* %2, i64 0, i64 2
 %5 = call i8* @foo (i8* %3, i8* %4)
 %6 = getelementptr [6 x i8], i8* %2, i64 0, i64 3
 %7 = icmp ne i8* %5, %6
 br i1 %7, label %8, label %9
8:
 call void @abort ()
 unreachable
9:
 ret i32 0
}
