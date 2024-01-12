%struct.epic_private = type { i8*, [5 x i32] }
%struct.epic_rx_desc = type { i32 }

@check_rx_ring = global [5 x i32] [i32 12, i32 14, i32 16, i32 18, i32 10]

declare void @abort()

define i32 @main () {
 %1 = alloca i32
 %2 = alloca %struct.epic_private
 %3 = alloca [5 x %struct.epic_rx_desc]
 %4 = alloca i32
 store i32 0, i32* %1
 store i32 0, i32* %4
 br label %5
5:
 %6 = load i32, i32* %4
 %7 = icmp slt i32 %6, 5
 br i1 %7, label %8, label %20
8:
 %9 = load i32, i32* %4
 %10 = sext i32 %9 to i64
 %11 = getelementptr [5 x %struct.epic_rx_desc], i8* %3, i64 0, i64 %10
 %12 = getelementptr %struct.epic_rx_desc, i8* %11, i32 0, i32 0
 store i32 0, i32* %12
 %13 = getelementptr %struct.epic_private, i8* %2, i32 0, i32 1
 %14 = load i32, i32* %4
 %15 = sext i32 %14 to i64
 %16 = getelementptr [5 x i32], i8* %13, i64 0, i64 %15
 store i32 5, i32* %16
 br label %17
17:
 %18 = load i32, i32* %4
 %19 = add i32 %18, 1
 store i32 %19, i32* %4
 br label %5
20:
 %21 = getelementptr [5 x %struct.epic_rx_desc], i8* %3, i64 0, i64 0
 %22 = getelementptr %struct.epic_private, i8* %2, i32 0, i32 0
 store i8* %21, i8** %22
 call void @epic_init_ring (i8* %2)
 store i32 0, i32* %4
 br label %23
23:
 %24 = load i32, i32* %4
 %25 = icmp slt i32 %24, 5
 br i1 %25, label %26, label %50
26:
 %27 = load i32, i32* %4
 %28 = sext i32 %27 to i64
 %29 = getelementptr [5 x %struct.epic_rx_desc], i8* %3, i64 0, i64 %28
 %30 = getelementptr %struct.epic_rx_desc, i8* %29, i32 0, i32 0
 %31 = load i32, i32* %30
 %32 = load i32, i32* %4
 %33 = sext i32 %32 to i64
 %34 = getelementptr [5 x i32], i8* @check_rx_ring, i64 0, i64 %33
 %35 = load i32, i32* %34
 %36 = icmp ne i32 %31, %35
 br i1 %36, label %37, label %38
37:
 call void @abort ()
 unreachable
38:
 %39 = getelementptr %struct.epic_private, i8* %2, i32 0, i32 1
 %40 = load i32, i32* %4
 %41 = sext i32 %40 to i64
 %42 = getelementptr [5 x i32], i8* %39, i64 0, i64 %41
 %43 = load i32, i32* %42
 %44 = icmp ne i32 %43, 0
 br i1 %44, label %45, label %46
45:
 call void @abort ()
 unreachable
46:
 br label %47
47:
 %48 = load i32, i32* %4
 %49 = add i32 %48, 1
 store i32 %49, i32* %4
 br label %23
50:
 ret i32 0
}

define void @epic_init_ring (i8* %0) {
 %2 = alloca i8*
 %3 = alloca i32
 store i8* %0, i8** %2
 store i32 0, i32* %3
 br label %4
4:
 %5 = load i32, i32* %3
 %6 = icmp slt i32 %5, 5
 br i1 %6, label %7, label %27
7:
 %8 = load i32, i32* %3
 %9 = add i32 %8, 1
 %10 = mul i32 %9, 2
 %11 = add i32 10, %10
 %12 = load i8*, i8** %2
 %13 = getelementptr %struct.epic_private, i8* %12, i32 0, i32 0
 %14 = load i8*, i8** %13
 %15 = load i32, i32* %3
 %16 = sext i32 %15 to i64
 %17 = getelementptr %struct.epic_rx_desc, i8* %14, i64 %16
 %18 = getelementptr %struct.epic_rx_desc, i8* %17, i32 0, i32 0
 store i32 %11, i32* %18
 %19 = load i8*, i8** %2
 %20 = getelementptr %struct.epic_private, i8* %19, i32 0, i32 1
 %21 = load i32, i32* %3
 %22 = sext i32 %21 to i64
 %23 = getelementptr [5 x i32], i8* %20, i64 0, i64 %22
 store i32 0, i32* %23
 br label %24
24:
 %25 = load i32, i32* %3
 %26 = add i32 %25, 1
 store i32 %26, i32* %3
 br label %4
27:
 %28 = load i8*, i8** %2
 %29 = getelementptr %struct.epic_private, i8* %28, i32 0, i32 0
 %30 = load i8*, i8** %29
 %31 = load i32, i32* %3
 %32 = sub i32 %31, 1
 %33 = sext i32 %32 to i64
 %34 = getelementptr %struct.epic_rx_desc, i8* %30, i64 %33
 %35 = getelementptr %struct.epic_rx_desc, i8* %34, i32 0, i32 0
 store i32 10, i32* %35
 ret void
}
