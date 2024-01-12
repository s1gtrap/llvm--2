@p = global i8* @i
@i = global i32 0

declare void @abort()

define i32 @foo (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 %3 = load i8*, i8** @p
 store i32 1, i32* %3
 %4 = load i8*, i8** %2
 store i32 2, i32* %4
 %5 = load i8*, i8** @p
 %6 = load i32, i32* %5
 ret i32 %6
}

define i32 @bar (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 %3 = load i8*, i8** %2
 store i32 2, i32* %3
 %4 = load i8*, i8** @p
 store i32 1, i32* %4
 %5 = load i8*, i8** %2
 %6 = load i32, i32* %5
 ret i32 %6
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 store i32 0, i32* %1
 store i32 0, i32* %2
 %3 = call i32 @foo (i8* @i)
 %4 = icmp ne i32 %3, 2
 br i1 %4, label %5, label %6
5:
 call void @abort ()
 unreachable
6:
 %7 = call i32 @bar (i8* @i)
 %8 = icmp ne i32 %7, 1
 br i1 %8, label %9, label %10
9:
 call void @abort ()
 unreachable
10:
 %11 = call i32 @foo (i8* %2)
 %12 = icmp ne i32 %11, 1
 br i1 %12, label %13, label %14
13:
 call void @abort ()
 unreachable
14:
 %15 = load i32, i32* %2
 %16 = icmp ne i32 %15, 2
 br i1 %16, label %17, label %18
17:
 call void @abort ()
 unreachable
18:
 %19 = call i32 @bar (i8* %2)
 %20 = icmp ne i32 %19, 2
 br i1 %20, label %21, label %22
21:
 call void @abort ()
 unreachable
22:
 %23 = load i32, i32* %2
 %24 = icmp ne i32 %23, 2
 br i1 %24, label %25, label %26
25:
 call void @abort ()
 unreachable
26:
 ret i32 0
}
