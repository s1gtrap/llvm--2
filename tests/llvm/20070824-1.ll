%struct.S = type { i8*, i32 }

declare void @abort()

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i8*
 %3 = alloca i8*
 %4 = alloca i8*
 store i32 0, i32* %1
 store i8* null, i8** %2
 store i8* %2, i8** %3
 br label %5
5:
 %6 = load i8*, i8** %3
 %7 = load i8*, i8** %6
 %8 = icmp ne i8* %7, null
 br i1 %8, label %9, label %14
9:
 br label %10
10:
 %11 = load i8*, i8** %3
 %12 = load i8*, i8** %11
 %13 = getelementptr %struct.S, i8* %12, i32 0, i32 0
 store i8* %13, i8** %3
 br label %5
14:
 %15 = alloca i8, i64 16
 store i8* %15, i8** %4
 %16 = load i8*, i8** %3
 %17 = load i8*, i8** %16
 %18 = load i8*, i8** %4
 %19 = getelementptr %struct.S, i8* %18, i32 0, i32 0
 store i8* %17, i8** %19
 %20 = load i8*, i8** %4
 %21 = getelementptr %struct.S, i8* %20, i32 0, i32 1
 store i32 1, i32* %21
 %22 = load i8*, i8** %4
 %23 = load i8*, i8** %3
 store i8* %22, i8** %23
 %24 = load i8*, i8** %2
 %25 = icmp ne i8* %24, null
 br i1 %25, label %27, label %26
26:
 call void @abort ()
 unreachable
27:
 ret i32 0
}
