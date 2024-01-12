declare void @memcpy(i8*, i8*, i64, i1)
declare void @abort()

define i1 @f (i32 %0, i1 %1) {
 %3 = alloca i32
 %4 = alloca i8
 store i32 %0, i32* %3
 %5 = zext i1 %1 to i8
 store i8 %5, i8* %4
 %6 = load i32, i32* %3
 %7 = icmp ne i32 %6, 0
 br i1 %7, label %13, label %8
8:
 %9 = load i8, i8* %4
 %10 = trunc i8 %9 to i1
 %11 = xor i1 %10, 1
 %12 = zext i1 %11 to i8
 store i8 %12, i8* %4
 br label %13
13:
 %14 = load i8, i8* %4
 %15 = trunc i8 %14 to i1
 ret i1 %15
}

define void @checkf (i32 %0, i1 %1) {
 %3 = alloca i32
 %4 = alloca i8
 %5 = alloca i8
 %6 = alloca i8
 store i32 %0, i32* %3
 %7 = zext i1 %1 to i8
 store i8 %7, i8* %4
 %8 = load i32, i32* %3
 %9 = load i8, i8* %4
 %10 = trunc i8 %9 to i1
 %11 = call i1 @f (i32 %8, i1 %10)
 %12 = zext i1 %11 to i8
 store i8 %12, i8* %5
 call void @memcpy (i8* %6, i8* %5, i64 1, i1 0)
 %13 = load i8, i8* %6
 %14 = sext i8 %13 to i32
 %15 = load i32, i32* %3
 %16 = icmp eq i32 %15, 0
 %17 = zext i1 %16 to i32
 %18 = icmp ne i32 %14, %17
 %19 = zext i1 %18 to i32
 %20 = load i8, i8* %4
 %21 = trunc i8 %20 to i1
 %22 = zext i1 %21 to i32
 %23 = xor i32 %19, %22
 %24 = icmp ne i32 %23, 0
 br i1 %24, label %25, label %26
25:
 call void @abort ()
 unreachable
26:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @checkf (i32 0, i1 0)
 call void @checkf (i32 0, i1 1)
 call void @checkf (i32 1, i1 1)
 call void @checkf (i32 1, i1 0)
 ret i32 0
}
