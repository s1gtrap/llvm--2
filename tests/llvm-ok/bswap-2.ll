%union.bf_or_uint32 = type { %struct.bitfield }
%struct.bitfield = type { i32 }
%struct.ok = type { i8, i8, i8, i8 }

@__const.main.cin = global [4 x i8] c"\83\85\87\89"

declare void @memcpy(i8*, i8*, i64, i1)
declare void @abort()

define i32 @partial_read_le32 (i32 %0) {
 %2 = alloca %union.bf_or_uint32
 %3 = getelementptr %union.bf_or_uint32, i8* %2, i32 0, i32 0
 %4 = getelementptr %struct.bitfield, i8* %3, i32 0, i32 0
 store i32 %0, i32* %4
 %5 = load i32, i32* %2
 %6 = and i32 %5, 127
 %7 = trunc i32 %6 to i8
 %8 = zext i8 %7 to i32
 %9 = load i32, i32* %2
 %10 = lshr i32 %9, 8
 %11 = and i32 %10, 127
 %12 = trunc i32 %11 to i8
 %13 = zext i8 %12 to i32
 %14 = shl i32 %13, 8
 %15 = or i32 %8, %14
 %16 = load i32, i32* %2
 %17 = lshr i32 %16, 16
 %18 = and i32 %17, 127
 %19 = trunc i32 %18 to i8
 %20 = zext i8 %19 to i32
 %21 = shl i32 %20, 16
 %22 = or i32 %15, %21
 %23 = load i32, i32* %2
 %24 = lshr i32 %23, 24
 %25 = and i32 %24, 127
 %26 = trunc i32 %25 to i8
 %27 = zext i8 %26 to i32
 %28 = shl i32 %27, 24
 %29 = or i32 %22, %28
 ret i32 %29
}

define i32 @partial_read_be32 (i32 %0) {
 %2 = alloca %union.bf_or_uint32
 %3 = getelementptr %union.bf_or_uint32, i8* %2, i32 0, i32 0
 %4 = getelementptr %struct.bitfield, i8* %3, i32 0, i32 0
 store i32 %0, i32* %4
 %5 = load i32, i32* %2
 %6 = lshr i32 %5, 24
 %7 = and i32 %6, 127
 %8 = trunc i32 %7 to i8
 %9 = zext i8 %8 to i32
 %10 = load i32, i32* %2
 %11 = lshr i32 %10, 16
 %12 = and i32 %11, 127
 %13 = trunc i32 %12 to i8
 %14 = zext i8 %13 to i32
 %15 = shl i32 %14, 8
 %16 = or i32 %9, %15
 %17 = load i32, i32* %2
 %18 = lshr i32 %17, 8
 %19 = and i32 %18, 127
 %20 = trunc i32 %19 to i8
 %21 = zext i8 %20 to i32
 %22 = shl i32 %21, 16
 %23 = or i32 %16, %22
 %24 = load i32, i32* %2
 %25 = and i32 %24, 127
 %26 = trunc i32 %25 to i8
 %27 = zext i8 %26 to i32
 %28 = shl i32 %27, 24
 %29 = or i32 %23, %28
 ret i32 %29
}

define i32 @fake_read_le32 (i8* %0, i8* %1) {
 %3 = alloca i8*
 %4 = alloca i8*
 %5 = alloca i8
 %6 = alloca i8
 %7 = alloca i8
 %8 = alloca i8
 store i8* %0, i8** %3
 store i8* %1, i8** %4
 %9 = load i8*, i8** %3
 %10 = getelementptr i8, i8* %9, i64 0
 %11 = load i8, i8* %10
 store i8 %11, i8* %5
 %12 = load i8*, i8** %3
 %13 = getelementptr i8, i8* %12, i64 1
 %14 = load i8, i8* %13
 store i8 %14, i8* %6
 %15 = load i8*, i8** %4
 store i8 1, i8* %15
 %16 = load i8*, i8** %3
 %17 = getelementptr i8, i8* %16, i64 2
 %18 = load i8, i8* %17
 store i8 %18, i8* %7
 %19 = load i8*, i8** %3
 %20 = getelementptr i8, i8* %19, i64 3
 %21 = load i8, i8* %20
 store i8 %21, i8* %8
 %22 = load i8, i8* %5
 %23 = zext i8 %22 to i32
 %24 = load i8, i8* %6
 %25 = zext i8 %24 to i32
 %26 = shl i32 %25, 8
 %27 = or i32 %23, %26
 %28 = load i8, i8* %7
 %29 = zext i8 %28 to i32
 %30 = shl i32 %29, 16
 %31 = or i32 %27, %30
 %32 = load i8, i8* %8
 %33 = zext i8 %32 to i32
 %34 = shl i32 %33, 24
 %35 = or i32 %31, %34
 ret i32 %35
}

define i32 @fake_read_be32 (i8* %0, i8* %1) {
 %3 = alloca i8*
 %4 = alloca i8*
 %5 = alloca i8
 %6 = alloca i8
 %7 = alloca i8
 %8 = alloca i8
 store i8* %0, i8** %3
 store i8* %1, i8** %4
 %9 = load i8*, i8** %3
 %10 = getelementptr i8, i8* %9, i64 0
 %11 = load i8, i8* %10
 store i8 %11, i8* %5
 %12 = load i8*, i8** %3
 %13 = getelementptr i8, i8* %12, i64 1
 %14 = load i8, i8* %13
 store i8 %14, i8* %6
 %15 = load i8*, i8** %4
 store i8 1, i8* %15
 %16 = load i8*, i8** %3
 %17 = getelementptr i8, i8* %16, i64 2
 %18 = load i8, i8* %17
 store i8 %18, i8* %7
 %19 = load i8*, i8** %3
 %20 = getelementptr i8, i8* %19, i64 3
 %21 = load i8, i8* %20
 store i8 %21, i8* %8
 %22 = load i8, i8* %8
 %23 = zext i8 %22 to i32
 %24 = load i8, i8* %7
 %25 = zext i8 %24 to i32
 %26 = shl i32 %25, 8
 %27 = or i32 %23, %26
 %28 = load i8, i8* %6
 %29 = zext i8 %28 to i32
 %30 = shl i32 %29, 16
 %31 = or i32 %27, %30
 %32 = load i8, i8* %5
 %33 = zext i8 %32 to i32
 %34 = shl i32 %33, 24
 %35 = or i32 %31, %34
 ret i32 %35
}

define i32 @incorrect_read_le32 (i8* %0, i8* %1) {
 %3 = alloca i8*
 %4 = alloca i8*
 %5 = alloca i8
 %6 = alloca i8
 %7 = alloca i8
 %8 = alloca i8
 store i8* %0, i8** %3
 store i8* %1, i8** %4
 %9 = load i8*, i8** %3
 %10 = getelementptr i8, i8* %9, i64 0
 %11 = load i8, i8* %10
 store i8 %11, i8* %5
 %12 = load i8*, i8** %3
 %13 = getelementptr i8, i8* %12, i64 1
 %14 = load i8, i8* %13
 store i8 %14, i8* %6
 %15 = load i8*, i8** %3
 %16 = getelementptr i8, i8* %15, i64 2
 %17 = load i8, i8* %16
 store i8 %17, i8* %7
 %18 = load i8*, i8** %3
 %19 = getelementptr i8, i8* %18, i64 3
 %20 = load i8, i8* %19
 store i8 %20, i8* %8
 %21 = load i8*, i8** %4
 store i8 1, i8* %21
 %22 = load i8, i8* %5
 %23 = zext i8 %22 to i32
 %24 = load i8, i8* %6
 %25 = zext i8 %24 to i32
 %26 = shl i32 %25, 8
 %27 = or i32 %23, %26
 %28 = load i8, i8* %7
 %29 = zext i8 %28 to i32
 %30 = shl i32 %29, 16
 %31 = or i32 %27, %30
 %32 = load i8, i8* %8
 %33 = zext i8 %32 to i32
 %34 = shl i32 %33, 24
 %35 = or i32 %31, %34
 ret i32 %35
}

define i32 @incorrect_read_be32 (i8* %0, i8* %1) {
 %3 = alloca i8*
 %4 = alloca i8*
 %5 = alloca i8
 %6 = alloca i8
 %7 = alloca i8
 %8 = alloca i8
 store i8* %0, i8** %3
 store i8* %1, i8** %4
 %9 = load i8*, i8** %3
 %10 = getelementptr i8, i8* %9, i64 0
 %11 = load i8, i8* %10
 store i8 %11, i8* %5
 %12 = load i8*, i8** %3
 %13 = getelementptr i8, i8* %12, i64 1
 %14 = load i8, i8* %13
 store i8 %14, i8* %6
 %15 = load i8*, i8** %3
 %16 = getelementptr i8, i8* %15, i64 2
 %17 = load i8, i8* %16
 store i8 %17, i8* %7
 %18 = load i8*, i8** %3
 %19 = getelementptr i8, i8* %18, i64 3
 %20 = load i8, i8* %19
 store i8 %20, i8* %8
 %21 = load i8*, i8** %4
 store i8 1, i8* %21
 %22 = load i8, i8* %8
 %23 = zext i8 %22 to i32
 %24 = load i8, i8* %7
 %25 = zext i8 %24 to i32
 %26 = shl i32 %25, 8
 %27 = or i32 %23, %26
 %28 = load i8, i8* %6
 %29 = zext i8 %28 to i32
 %30 = shl i32 %29, 16
 %31 = or i32 %27, %30
 %32 = load i8, i8* %5
 %33 = zext i8 %32 to i32
 %34 = shl i32 %33, 24
 %35 = or i32 %31, %34
 ret i32 %35
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca %union.bf_or_uint32
 %3 = alloca i32
 %4 = alloca [4 x i8]
 %5 = alloca %struct.ok
 %6 = alloca %struct.ok
 store i32 0, i32* %1
 call void @memcpy (i8* %4, i8* @__const.main.cin, i64 4, i1 0)
 %7 = getelementptr %struct.ok, i8* %5, i32 0, i32 0
 store i8 -125, i8* %7
 %8 = getelementptr %struct.ok, i8* %5, i32 0, i32 1
 store i8 -123, i8* %8
 %9 = getelementptr %struct.ok, i8* %5, i32 0, i32 2
 store i8 -121, i8* %9
 %10 = getelementptr %struct.ok, i8* %5, i32 0, i32 3
 store i8 -119, i8* %10
 call void @memcpy (i8* %2, i8* %5, i64 4, i1 0)
 %11 = getelementptr %union.bf_or_uint32, i8* %2, i32 0, i32 0
 %12 = getelementptr %struct.bitfield, i8* %11, i32 0, i32 0
 %13 = load i32, i32* %12
 %14 = call i32 @partial_read_le32 (i32 %13)
 store i32 %14, i32* %3
 %15 = load i32, i32* %3
 %16 = icmp eq i32 %15, -1987607165
 br i1 %16, label %17, label %18
17:
 call void @abort ()
 unreachable
18:
 %19 = getelementptr %struct.ok, i8* %6, i32 0, i32 0
 store i8 -125, i8* %19
 %20 = getelementptr %struct.ok, i8* %6, i32 0, i32 1
 store i8 -123, i8* %20
 %21 = getelementptr %struct.ok, i8* %6, i32 0, i32 2
 store i8 -121, i8* %21
 %22 = getelementptr %struct.ok, i8* %6, i32 0, i32 3
 store i8 -119, i8* %22
 call void @memcpy (i8* %2, i8* %6, i64 4, i1 0)
 %23 = getelementptr %union.bf_or_uint32, i8* %2, i32 0, i32 0
 %24 = getelementptr %struct.bitfield, i8* %23, i32 0, i32 0
 %25 = load i32, i32* %24
 %26 = call i32 @partial_read_be32 (i32 %25)
 store i32 %26, i32* %3
 %27 = load i32, i32* %3
 %28 = icmp eq i32 %27, -2088401015
 br i1 %28, label %29, label %30
29:
 call void @abort ()
 unreachable
30:
 %31 = getelementptr [4 x i8], i8* %4, i64 0, i64 0
 %32 = getelementptr [4 x i8], i8* %4, i64 0, i64 2
 %33 = call i32 @fake_read_le32 (i8* %31, i8* %32)
 store i32 %33, i32* %3
 %34 = load i32, i32* %3
 %35 = icmp ne i32 %34, -1996388989
 br i1 %35, label %36, label %37
36:
 call void @abort ()
 unreachable
37:
 %38 = getelementptr [4 x i8], i8* %4, i64 0, i64 2
 store i8 -121, i8* %38
 %39 = getelementptr [4 x i8], i8* %4, i64 0, i64 0
 %40 = getelementptr [4 x i8], i8* %4, i64 0, i64 2
 %41 = call i32 @fake_read_be32 (i8* %39, i8* %40)
 store i32 %41, i32* %3
 %42 = load i32, i32* %3
 %43 = icmp ne i32 %42, -2088435319
 br i1 %43, label %44, label %45
44:
 call void @abort ()
 unreachable
45:
 %46 = getelementptr [4 x i8], i8* %4, i64 0, i64 2
 store i8 -121, i8* %46
 %47 = getelementptr [4 x i8], i8* %4, i64 0, i64 0
 %48 = getelementptr [4 x i8], i8* %4, i64 0, i64 2
 %49 = call i32 @incorrect_read_le32 (i8* %47, i8* %48)
 store i32 %49, i32* %3
 %50 = load i32, i32* %3
 %51 = icmp ne i32 %50, -1987607165
 br i1 %51, label %52, label %53
52:
 call void @abort ()
 unreachable
53:
 %54 = getelementptr [4 x i8], i8* %4, i64 0, i64 2
 store i8 -121, i8* %54
 %55 = getelementptr [4 x i8], i8* %4, i64 0, i64 0
 %56 = getelementptr [4 x i8], i8* %4, i64 0, i64 2
 %57 = call i32 @incorrect_read_be32 (i8* %55, i8* %56)
 store i32 %57, i32* %3
 %58 = load i32, i32* %3
 %59 = icmp ne i32 %58, -2088401015
 br i1 %59, label %60, label %61
60:
 call void @abort ()
 unreachable
61:
 ret i32 0
}
