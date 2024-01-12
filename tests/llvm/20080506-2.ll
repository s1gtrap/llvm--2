declare void @abort()

define void @foo (i8* %0, i8* %1) {
 %3 = alloca i8*
 %4 = alloca i8*
 store i8* %0, i8** %3
 store i8* %1, i8** %4
 %5 = load i8*, i8** %3
 %6 = getelementptr i8*, i8* %5, i64 0
 %7 = load i8*, i8** %6
 store i32 1, i32* %7
 %8 = load i8*, i8** %4
 %9 = getelementptr i8*, i8* %8, i64 0
 %10 = load i8*, i8** %9
 store i32 2, i32* %10
 %11 = load i8*, i8** %3
 %12 = getelementptr i8*, i8* %11, i64 0
 %13 = load i8*, i8** %12
 %14 = load i32, i32* %13
 %15 = icmp ne i32 %14, 2
 br i1 %15, label %16, label %17
16:
 call void @abort ()
 unreachable
17:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 %3 = alloca i8*
 %4 = alloca i8*
 store i32 0, i32* %1
 store i8* %2, i8** %3
 store i8* %2, i8** %4
 call void @foo (i8* %3, i8* %4)
 ret i32 0
}
