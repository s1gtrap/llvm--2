declare void @abort()

define i32 @foo (i16 %0) {
 %2 = alloca i16
 %3 = alloca i16
 store i16 %0, i16* %2
 %4 = load i16, i16* %2
 %5 = zext i16 %4 to i32
 %6 = icmp sgt i32 %5, 32767
 br i1 %6, label %7, label %11
7:
 %8 = load i16, i16* %2
 %9 = zext i16 %8 to i32
 %10 = sub i32 %9, 32768
 br label %12
11:
 br label %12
12:
 %13 = phi i32 [%10, %7], [0, %11]
 %14 = trunc i32 %13 to i16
 store i16 %14, i16* %3
 %15 = load i16, i16* %3
 %16 = zext i16 %15 to i32
 ret i32 %16
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @foo (i16 0)
 %3 = icmp ne i32 %2, 0
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 %6 = call i32 @foo (i16 32767)
 %7 = icmp ne i32 %6, 0
 br i1 %7, label %8, label %9
8:
 call void @abort ()
 unreachable
9:
 %10 = call i32 @foo (i16 -32768)
 %11 = icmp ne i32 %10, 0
 br i1 %11, label %12, label %13
12:
 call void @abort ()
 unreachable
13:
 %14 = call i32 @foo (i16 -32767)
 %15 = icmp ne i32 %14, 1
 br i1 %15, label %16, label %17
16:
 call void @abort ()
 unreachable
17:
 %18 = call i32 @foo (i16 -1)
 %19 = icmp ne i32 %18, 32767
 br i1 %19, label %20, label %21
20:
 call void @abort ()
 unreachable
21:
 ret i32 0
}
