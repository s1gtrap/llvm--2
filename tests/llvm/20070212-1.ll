%struct.f = type { i32 }

declare void @abort()

define i32 @g (i32 %0, i32 %1, i8* %2, i8* %3) {
 %5 = alloca i32
 %6 = alloca i32
 %7 = alloca i8*
 %8 = alloca i8*
 %9 = alloca i8*
 store i32 %0, i32* %5
 store i32 %1, i32* %6
 store i8* %2, i8** %7
 store i8* %3, i8** %8
 %10 = load i32, i32* %6
 %11 = icmp ne i32 %10, 0
 br i1 %11, label %12, label %13
12:
 store i8* %5, i8** %9
 br label %16
13:
 %14 = load i8*, i8** %7
 %15 = getelementptr %struct.f, i8* %14, i32 0, i32 0
 store i8* %15, i8** %9
 br label %16
16:
 %17 = load i8*, i8** %8
 store i32 0, i32* %17
 %18 = load i8*, i8** %9
 %19 = load i32, i32* %18
 ret i32 %19
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca %struct.f
 store i32 0, i32* %1
 %3 = getelementptr %struct.f, i8* %2, i32 0, i32 0
 store i32 1, i32* %3
 %4 = getelementptr %struct.f, i8* %2, i32 0, i32 0
 %5 = call i32 @g (i32 5, i32 0, i8* %2, i8* %4)
 %6 = icmp ne i32 %5, 0
 br i1 %6, label %7, label %8
7:
 call void @abort ()
 unreachable
8:
 ret i32 0
}
