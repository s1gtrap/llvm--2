declare i8* @malloc(i64)
declare void @abort()

define i32 @foo (i32 %0) {
 %2 = alloca i32
 %3 = alloca i8*
 store i32 %0, i32* %2
 %4 = call i8* @malloc (i64 16)
 store i8* %4, i8** %3
 %5 = load i8*, i8** %3
 store i32 0, i32* %5
 %6 = load i8*, i8** %3
 %7 = load i32, i32* %2
 %8 = sext i32 %7 to i64
 %9 = getelementptr i32, i8* %6, i64 %8
 store i32 1, i32* %9
 %10 = load i8*, i8** %3
 %11 = load i32, i32* %10
 ret i32 %11
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @foo (i32 0)
 %3 = icmp ne i32 %2, 1
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 ret i32 0
}
