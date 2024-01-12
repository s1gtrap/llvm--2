@.str = global [5 x i8] c"test\00"
@z = global i32 0

declare void @abort()
declare void @exit(i32)

define void @foo (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = icmp ne i32 %3, 1
 br i1 %4, label %5, label %6
5:
 call void @abort ()
 unreachable
6:
 ret void
}

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 %6 = alloca i8*
 %7 = alloca i8*
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 store i8* @.str, i8** %6
 %8 = load i8*, i8** %6
 %9 = getelementptr i8, i8* %8, i64 2
 store i8* %9, i8** %7
 %10 = load i32, i32* @z
 %11 = icmp sgt i32 %10, 0
 br i1 %11, label %12, label %18
12:
 %13 = load i8*, i8** %7
 %14 = load i8*, i8** %6
 %15 = ptrtoint i8** %13 to i64
 %16 = ptrtoint i8** %14 to i64
 %17 = sub i64 %15, %16
 br label %25
18:
 %19 = load i8*, i8** %7
 %20 = load i8*, i8** %6
 %21 = ptrtoint i8** %19 to i64
 %22 = ptrtoint i8** %20 to i64
 %23 = sub i64 %21, %22
 %24 = sub i64 %23, 1
 br label %25
25:
 %26 = phi i64 [%17, %12], [%24, %18]
 %27 = trunc i64 %26 to i32
 call void @foo (i32 %27)
 call void @exit (i32 0)
 unreachable
}
