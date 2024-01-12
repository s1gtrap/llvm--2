%struct.S = type { i8, i8, i8, i8 }

declare void @abort()
declare void @exit(i32)

define i32 @foo (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 %3 = load i8*, i8** %2
 %4 = getelementptr %struct.S, i8* %3, i32 0, i32 0
 %5 = load i8, i8* %4
 %6 = zext i8 %5 to i32
 %7 = load i8*, i8** %2
 %8 = getelementptr %struct.S, i8* %7, i32 0, i32 1
 %9 = load i8, i8* %8
 %10 = zext i8 %9 to i32
 %11 = icmp ne i32 %6, %10
 br i1 %11, label %12, label %13
12:
 call void @abort ()
 unreachable
13:
 %14 = load i8*, i8** %2
 %15 = getelementptr %struct.S, i8* %14, i32 0, i32 2
 %16 = load i8, i8* %15
 %17 = zext i8 %16 to i32
 %18 = icmp ne i32 %17, 2
 br i1 %18, label %19, label %20
19:
 call void @abort ()
 unreachable
20:
 %21 = load i8*, i8** %2
 %22 = getelementptr %struct.S, i8* %21, i32 0, i32 3
 %23 = load i8, i8* %22
 %24 = zext i8 %23 to i32
 ret i32 %24
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca [2 x %struct.S]
 store i32 0, i32* %1
 %3 = getelementptr [2 x %struct.S], i8* %2, i64 0, i64 0
 %4 = getelementptr %struct.S, i8* %3, i32 0, i32 0
 store i8 1, i8* %4
 %5 = getelementptr [2 x %struct.S], i8* %2, i64 0, i64 0
 %6 = getelementptr %struct.S, i8* %5, i32 0, i32 1
 store i8 1, i8* %6
 %7 = getelementptr [2 x %struct.S], i8* %2, i64 0, i64 0
 %8 = getelementptr %struct.S, i8* %7, i32 0, i32 2
 store i8 2, i8* %8
 %9 = getelementptr [2 x %struct.S], i8* %2, i64 0, i64 0
 %10 = getelementptr %struct.S, i8* %9, i32 0, i32 3
 store i8 3, i8* %10
 %11 = getelementptr [2 x %struct.S], i8* %2, i64 0, i64 1
 %12 = getelementptr %struct.S, i8* %11, i32 0, i32 0
 store i8 3, i8* %12
 %13 = getelementptr [2 x %struct.S], i8* %2, i64 0, i64 1
 %14 = getelementptr %struct.S, i8* %13, i32 0, i32 1
 store i8 2, i8* %14
 %15 = getelementptr [2 x %struct.S], i8* %2, i64 0, i64 1
 %16 = getelementptr %struct.S, i8* %15, i32 0, i32 2
 store i8 1, i8* %16
 %17 = getelementptr [2 x %struct.S], i8* %2, i64 0, i64 1
 %18 = getelementptr %struct.S, i8* %17, i32 0, i32 3
 store i8 0, i8* %18
 %19 = getelementptr [2 x %struct.S], i8* %2, i64 0, i64 0
 %20 = call i32 @foo (i8* %19)
 %21 = icmp ne i32 %20, 3
 br i1 %21, label %22, label %23
22:
 call void @abort ()
 unreachable
23:
 call void @exit (i32 0)
 unreachable
}
