%struct.S1 = type { i8 }

@g_23 = global i32 0
@__const.foo.l_128 = global %struct.S1 {i8 1}

declare void @abort()
declare void @memcpy(i8*, i8*, i64, i1)

define i32 @main () {
 %1 = alloca i32
 %2 = alloca %struct.S1
 store i32 0, i32* %1
 %3 = call i8 @foo ()
 %4 = getelementptr %struct.S1, i8* %2, i32 0, i32 0
 store i8 %3, i8* %4
 %5 = getelementptr %struct.S1, i8* %2, i32 0, i32 0
 %6 = load i8, i8* %5
 %7 = sext i8 %6 to i32
 %8 = icmp ne i32 %7, 0
 br i1 %8, label %9, label %10
9:
 br label %10
10:
 %11 = phi i1 [0, %0], [1, %9]
 %12 = zext i1 %11 to i32
 %13 = xor i32 153, %12
 %14 = trunc i32 %13 to i8
 %15 = call i8 @bar (i8 %14, i8 1)
 %16 = sext i8 %15 to i32
 %17 = icmp ne i32 %16, -104
 br i1 %17, label %18, label %19
18:
 call void @abort ()
 unreachable
19:
 ret i32 0
}

define i8 @foo () {
 %1 = alloca %struct.S1
 %2 = alloca i8*
 %3 = alloca i8*
 store i8* @g_23, i8** %2
 store i8* %2, i8** %3
 call void @memcpy (i8* %1, i8* @__const.foo.l_128, i64 1, i1 0)
 %4 = load i8*, i8** %2
 %5 = icmp eq i8* %4, @g_23
 br i1 %5, label %7, label %6
6:
 call void @abort ()
 unreachable
7:
 %8 = load i8*, i8** %2
 %9 = icmp eq i8* %8, @g_23
 br i1 %9, label %11, label %10
10:
 call void @abort ()
 unreachable
11:
 %12 = load i8*, i8** %2
 %13 = icmp eq i8* %12, @g_23
 br i1 %13, label %15, label %14
14:
 call void @abort ()
 unreachable
15:
 %16 = load i8*, i8** %2
 %17 = icmp eq i8* %16, @g_23
 br i1 %17, label %19, label %18
18:
 call void @abort ()
 unreachable
19:
 %20 = load i8*, i8** %2
 %21 = icmp eq i8* %20, @g_23
 br i1 %21, label %23, label %22
22:
 call void @abort ()
 unreachable
23:
 %24 = load i8*, i8** %2
 %25 = icmp eq i8* %24, @g_23
 br i1 %25, label %27, label %26
26:
 call void @abort ()
 unreachable
27:
 %28 = load i8*, i8** %2
 %29 = icmp eq i8* %28, @g_23
 br i1 %29, label %31, label %30
30:
 call void @abort ()
 unreachable
31:
 %32 = getelementptr %struct.S1, i8* %1, i32 0, i32 0
 %33 = load i8, i8* %32
 ret i8 %33
}

define i8 @bar (i8 %0, i8 %1) {
 %3 = alloca i8
 %4 = alloca i8
 store i8 %0, i8* %3
 store i8 %1, i8* %4
 %5 = load i8, i8* %3
 %6 = sext i8 %5 to i32
 %7 = icmp sle i32 %6, 0
 br i1 %7, label %8, label %11
8:
 %9 = load i8, i8* %3
 %10 = sext i8 %9 to i32
 br label %15
11:
 %12 = load i8, i8* %4
 %13 = sext i8 %12 to i32
 %14 = mul i32 %13, 2
 br label %15
15:
 %16 = phi i32 [%10, %8], [%14, %11]
 %17 = trunc i32 %16 to i8
 ret i8 %17
}
