%struct.foo = type { i32, i32 }

declare void @abort()

define i32 @bar (i8* %0, i32 %1, i32 %2, i32 %3) {
 %5 = alloca i8*
 %6 = alloca i32
 %7 = alloca i32
 %8 = alloca i32
 %9 = alloca i8*
 %10 = alloca i8*
 %11 = alloca i32
 store i8* %0, i8** %5
 store i32 %1, i32* %6
 store i32 %2, i32* %7
 store i32 %3, i32* %8
 %12 = load i32, i32* %7
 %13 = icmp ne i32 %12, 0
 br i1 %13, label %14, label %17
14:
 %15 = load i8*, i8** %5
 %16 = getelementptr %struct.foo, i8* %15, i32 0, i32 0
 store i8* %16, i8** %9
 br label %20
17:
 %18 = load i8*, i8** %5
 %19 = getelementptr %struct.foo, i8* %18, i32 0, i32 1
 store i8* %19, i8** %9
 br label %20
20:
 %21 = load i8*, i8** %9
 %22 = load i32, i32* %21
 store i32 %22, i32* %11
 %23 = load i8*, i8** %5
 %24 = getelementptr %struct.foo, i8* %23, i32 0, i32 0
 store i32 1, i32* %24
 %25 = load i32, i32* %8
 %26 = icmp ne i32 %25, 0
 br i1 %26, label %27, label %29
27:
 %28 = load i8*, i8** %9
 store i8* %28, i8** %10
 br label %30
29:
 store i8* %6, i8** %10
 br label %30
30:
 %31 = load i32, i32* %11
 %32 = load i8*, i8** %10
 %33 = load i32, i32* %32
 %34 = add i32 %31, %33
 ret i32 %34
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca %struct.foo
 store i32 0, i32* %1
 %3 = getelementptr %struct.foo, i8* %2, i32 0, i32 0
 store i32 0, i32* %3
 %4 = getelementptr %struct.foo, i8* %2, i32 0, i32 1
 store i32 1, i32* %4
 %5 = call i32 @bar (i8* %2, i32 1, i32 1, i32 1)
 %6 = icmp ne i32 %5, 1
 br i1 %6, label %7, label %8
7:
 call void @abort ()
 unreachable
8:
 ret i32 0
}
