@.str = global [2 x i8] c"a\00"

declare void @abort()

define i32 @foo (i8* %0) {
 %2 = alloca i8*
 %3 = alloca i32
 store i8* %0, i8** %2
 store i32 0, i32* %3
 br label %4
4:
 %5 = load i8*, i8** %2
 %6 = load i8, i8* %5
 %7 = sext i8 %6 to i32
 %8 = icmp eq i32 %7, 0
 br i1 %8, label %9, label %10
9:
 br label %20
10:
 %11 = load i32, i32* %3
 %12 = add i32 %11, 1
 store i32 %12, i32* %3
 %13 = load i8*, i8** %2
 %14 = icmp eq i8* %13, null
 br i1 %14, label %15, label %16
15:
 call void @abort ()
 unreachable
16:
 %17 = load i8*, i8** %2
 %18 = getelementptr i8, i8* %17, i32 1
 store i8* %18, i8** %2
 br label %19
19:
 br i1 1, label %4, label %20
20:
 %21 = load i32, i32* %3
 ret i32 %21
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @foo (i8* @.str)
 %3 = icmp ne i32 %2, 1
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 ret i32 0
}
