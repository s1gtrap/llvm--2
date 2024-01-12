%struct.A = type { i16 }

declare void @abort()
declare void @exit(i32)

define void @foo (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = icmp ne i32 %3, 2048
 br i1 %4, label %5, label %9
5:
 %6 = load i32, i32* %2
 %7 = icmp ne i32 %6, 2064
 br i1 %7, label %8, label %9
8:
 call void @abort ()
 unreachable
9:
 ret void
}

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 %6 = alloca i32
 %7 = alloca %struct.A
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 store i32 0, i32* %6
 br label %8
8:
 %9 = load i32, i32* %6
 %10 = icmp slt i32 %9, 2
 br i1 %10, label %11, label %34
11:
 %12 = getelementptr %struct.A, i8* %7, i32 0, i32 0
 %13 = load i32, i32* %6
 %14 = ashr i32 %13, 4
 %15 = icmp ne i32 %14, 0
 br i1 %15, label %17, label %16
16:
 br label %21
17:
 %18 = load i32, i32* %6
 %19 = ashr i32 %18, 4
 %20 = add i32 64, %19
 br label %21
21:
 %22 = phi i32 [8, %16], [%20, %17]
 %23 = shl i32 %22, 8
 %24 = load i32, i32* %6
 %25 = shl i32 %24, 4
 %26 = add i32 %23, %25
 %27 = trunc i32 %26 to i16
 store i16 %27, i16* %12
 %28 = getelementptr %struct.A, i8* %7, i32 0, i32 0
 %29 = load i16, i16* %28
 %30 = zext i16 %29 to i32
 call void @foo (i32 %30)
 br label %31
31:
 %32 = load i32, i32* %6
 %33 = add i32 %32, 1
 store i32 %33, i32* %6
 br label %8
34:
 call void @exit (i32 0)
 unreachable
}
