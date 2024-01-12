@.str = global [2 x i8] c"*\00"
@.str.1 = global [2 x i8] c"e\00"
@list = global [2 x i8*] [i8* @.str, i8* @.str.1]

declare void @abort()
declare void @exit(i32)
declare i8* @strchr(i8*, i32)

define i32 @main () {
 call void @foo ()
 ret i32 0
}

define void @foo () {
 %1 = alloca i32
 %2 = alloca i8*
 store i32 0, i32* %1
 br label %3
3:
 %4 = load i32, i32* %1
 %5 = sext i32 %4 to i64
 %6 = icmp ult i64 %5, 2
 br i1 %6, label %7, label %24
7:
 %8 = load i32, i32* %1
 %9 = sext i32 %8 to i64
 %10 = getelementptr [2 x i8*], i8* @list, i64 0, i64 %9
 %11 = load i8*, i8** %10
 store i8* %11, i8** %2
 %12 = load i8*, i8** %2
 %13 = call i32 @bar (i8* %12)
 %14 = icmp ne i32 %13, 0
 br i1 %14, label %15, label %16
15:
 br label %21
16:
 %17 = load i32, i32* %1
 %18 = icmp eq i32 %17, 0
 br i1 %18, label %19, label %20
19:
 call void @abort ()
 unreachable
20:
 call void @exit (i32 0)
 unreachable
21:
 %22 = load i32, i32* %1
 %23 = add i32 %22, 1
 store i32 %23, i32* %1
 br label %3
24:
 ret void
}

define i32 @bar (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 %3 = load i8*, i8** %2
 %4 = call i8* @strchr (i8* %3, i32 42)
 %5 = icmp ne i8* %4, null
 %6 = zext i1 %5 to i32
 ret i32 %6
}
