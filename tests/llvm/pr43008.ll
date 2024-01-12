%struct.X = type { i8* }

@i = global i32 0

declare i8* @malloc(i64)
declare void @abort()

define i8* @my_alloc () {
 %1 = alloca i8*
 %2 = call i8* @malloc (i64 8)
 store i8* %2, i8** %1
 %3 = load i8*, i8** %1
 %4 = getelementptr %struct.X, i8* %3, i32 0, i32 0
 store i8* @i, i8** %4
 %5 = load i8*, i8** %1
 ret i8* %5
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i8*
 %3 = alloca i8*
 store i32 0, i32* %1
 %4 = call i8* @my_alloc ()
 store i8* %4, i8** %2
 %5 = call i8* @my_alloc ()
 store i8* %5, i8** %3
 %6 = load i8*, i8** %2
 %7 = getelementptr %struct.X, i8* %6, i32 0, i32 0
 %8 = load i8*, i8** %7
 store i32 1, i32* %8
 %9 = load i8*, i8** %3
 %10 = getelementptr %struct.X, i8* %9, i32 0, i32 0
 %11 = load i8*, i8** %10
 store i32 0, i32* %11
 %12 = load i8*, i8** %2
 %13 = getelementptr %struct.X, i8* %12, i32 0, i32 0
 %14 = load i8*, i8** %13
 %15 = load i32, i32* %14
 %16 = icmp ne i32 %15, 0
 br i1 %16, label %17, label %18
17:
 call void @abort ()
 unreachable
18:
 ret i32 0
}
