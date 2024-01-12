%struct.X = type { i32 }

declare void @abort()

define i32 @foo (i8* %0, i8* %1, i32 %2, i32 %3) {
 %5 = alloca i8*
 %6 = alloca i8*
 %7 = alloca i32
 %8 = alloca i32
 %9 = alloca %struct.X
 %10 = alloca %struct.X
 store i8* %0, i8** %5
 store i8* %1, i8** %6
 store i32 %2, i32* %7
 store i32 %3, i32* %8
 %11 = load i32, i32* %7
 %12 = icmp ne i32 %11, 0
 br i1 %12, label %13, label %14
13:
 store i8* %9, i8** %5
 br label %14
14:
 %15 = load i32, i32* %8
 %16 = icmp ne i32 %15, 0
 br i1 %16, label %17, label %19
17:
 %18 = getelementptr %struct.X, i8* %9, i32 0, i32 0
 store i8* %18, i8** %6
 br label %21
19:
 %20 = getelementptr %struct.X, i8* %10, i32 0, i32 0
 store i8* %20, i8** %6
 br label %21
21:
 %22 = load i8*, i8** %6
 store i32 1, i32* %22
 %23 = load i8*, i8** %5
 %24 = getelementptr %struct.X, i8* %23, i32 0, i32 0
 %25 = load i32, i32* %24
 ret i32 %25
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @foo (i8* null, i8* null, i32 1, i32 1)
 %3 = icmp ne i32 %2, 1
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 ret i32 0
}
