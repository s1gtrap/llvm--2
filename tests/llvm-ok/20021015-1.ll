@g_list = global [1 x i8] c"1"

declare void @abort()

define void @g (i8* %0, i8* %1, i32 %2, i8* %3, i8* %4) {
 %6 = alloca i8*
 %7 = alloca i8*
 %8 = alloca i32
 %9 = alloca i8*
 %10 = alloca i8*
 store i8* %0, i8** %6
 store i8* %1, i8** %7
 store i32 %2, i32* %8
 store i8* %3, i8** %9
 store i8* %4, i8** %10
 %11 = load i8*, i8** %10
 %12 = load i8*, i8** %11
 %13 = icmp ne i8* %12, @g_list
 br i1 %13, label %14, label %15
14:
 call void @abort ()
 unreachable
15:
 %16 = load i8*, i8** %10
 %17 = load i8*, i8** %16
 store i8 0, i8* %17
 ret void
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i8*
 %3 = alloca i8*
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i8*
 store i32 0, i32* %1
 store i8* @g_list, i8** %2
 store i32 100, i32* %5
 store i32 0, i32* %4
 br label %7
7:
 %8 = load i8*, i8** %2
 %9 = load i8, i8* %8
 %10 = sext i8 %9 to i32
 %11 = icmp ne i32 %10, 0
 br i1 %11, label %12, label %28
12:
 %13 = load i8*, i8** %2
 store i8* %13, i8** %6
 %14 = load i8*, i8** %2
 %15 = load i32, i32* %5
 call void @g (i8* null, i8* %14, i32 %15, i8* %3, i8* %2)
 %16 = load i8*, i8** %2
 %17 = load i8*, i8** %6
 %18 = ptrtoint i8** %16 to i64
 %19 = ptrtoint i8** %17 to i64
 %20 = sub i64 %18, %19
 %21 = load i32, i32* %5
 %22 = sext i32 %21 to i64
 %23 = sub i64 %22, %20
 %24 = trunc i64 %23 to i32
 store i32 %24, i32* %5
 br label %25
25:
 %26 = load i32, i32* %4
 %27 = add i32 %26, 1
 store i32 %27, i32* %4
 br label %7
28:
 ret i32 0
}
