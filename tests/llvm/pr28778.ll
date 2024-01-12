declare void @abort()

define void @find (i8* %0) {
 %2 = alloca i8*
 %3 = alloca i8*
 %4 = alloca [32 x i32]
 store i8* %0, i8** %2
 %5 = load i8*, i8** %2
 %6 = icmp ne i8* %5, null
 br i1 %6, label %7, label %9
7:
 %8 = load i8*, i8** %2
 store i8* %8, i8** %3
 br label %12
9:
 %10 = getelementptr [32 x i32], i8* %4, i64 0, i64 3
 store i32 42, i32* %10
 %11 = getelementptr [32 x i32], i8* %4, i64 0, i64 0
 store i8* %11, i8** %3
 br label %12
12:
 %13 = load i8*, i8** %3
 call void @aglChoosePixelFormat (i8* %13)
 ret void
}

define void @aglChoosePixelFormat (i8* %0) {
 %2 = alloca i8*
 %3 = alloca i8*
 store i8* %0, i8** %2
 %4 = load i8*, i8** %2
 store i8* %4, i8** %3
 %5 = load i8*, i8** %3
 %6 = getelementptr i32, i8* %5, i64 3
 %7 = load i32, i32* %6
 %8 = icmp ne i32 %7, 42
 br i1 %8, label %9, label %10
9:
 call void @abort ()
 unreachable
10:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @find (i8* null)
 ret i32 0
}
