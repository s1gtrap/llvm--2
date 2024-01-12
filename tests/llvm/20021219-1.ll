@__const.main.str = global [11 x i8] c"foo { xx }\00"

declare void @memcpy(i8*, i8*, i64, i1)

define void @foo (i8* %0, i8* %1) {
 %3 = alloca i8*
 %4 = alloca i8*
 store i8* %0, i8** %3
 store i8* %1, i8** %4
 ret void
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca [11 x i8]
 %3 = alloca i8*
 store i32 0, i32* %1
 call void @memcpy (i8* %2, i8* @__const.main.str, i64 11, i1 0)
 %4 = getelementptr [11 x i8], i8* %2, i64 0, i64 0
 %5 = getelementptr i8, i8* %4, i64 5
 store i8* %5, i8** %3
 %6 = load i8*, i8** %3
 call void @foo (i8* %6, i8* %3)
 br label %7
7:
 %8 = load i8*, i8** %3
 %9 = load i8, i8* %8
 %10 = sext i8 %9 to i32
 %11 = icmp ne i32 %10, 0
 br i1 %11, label %12, label %24
12:
 %13 = load i8*, i8** %3
 %14 = load i8, i8* %13
 %15 = sext i8 %14 to i32
 %16 = icmp eq i32 %15, 13
 br i1 %16, label %22, label %17
17:
 %18 = load i8*, i8** %3
 %19 = load i8, i8* %18
 %20 = sext i8 %19 to i32
 %21 = icmp eq i32 %20, 32
 br label %22
22:
 %23 = phi i1 [1, %12], [%21, %17]
 br label %24
24:
 %25 = phi i1 [0, %7], [%23, %22]
 br i1 %25, label %26, label %29
26:
 %27 = load i8*, i8** %3
 %28 = getelementptr i8, i8* %27, i32 1
 store i8* %28, i8** %3
 br label %7
29:
 ret i32 0
}
