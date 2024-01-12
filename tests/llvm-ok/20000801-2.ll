%struct.foo = type { i8* }

declare void @abort()
declare void @exit(i32)

define i8* @test (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 br label %3
3:
 %4 = load i8*, i8** %2
 %5 = icmp ne i8* %4, null
 br i1 %5, label %6, label %17
6:
 %7 = call i32 @bar ()
 %8 = icmp ne i32 %7, 0
 br i1 %8, label %9, label %13
9:
 %10 = call i32 @baz ()
 %11 = icmp ne i32 %10, 0
 br i1 %11, label %13, label %12
12:
 br label %17
13:
 %14 = load i8*, i8** %2
 %15 = getelementptr %struct.foo, i8* %14, i32 0, i32 0
 %16 = load i8*, i8** %15
 store i8* %16, i8** %2
 br label %3
17:
 %18 = load i8*, i8** %2
 ret i8* %18
}

define i32 @bar () {
 ret i32 0
}

define i32 @baz () {
 ret i32 0
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca %struct.foo
 %3 = alloca %struct.foo
 %4 = alloca i8*
 store i32 0, i32* %1
 %5 = getelementptr %struct.foo, i8* %2, i32 0, i32 0
 store i8* %3, i8** %5
 %6 = getelementptr %struct.foo, i8* %3, i32 0, i32 0
 store i8* null, i8** %6
 %7 = call i8* @test (i8* %2)
 store i8* %7, i8** %4
 %8 = load i8*, i8** %4
 %9 = icmp ne i8* %8, null
 br i1 %9, label %10, label %11
10:
 call void @abort ()
 unreachable
11:
 call void @exit (i32 0)
 unreachable
}
