%struct.source = type { i32, i32, i32 }
%struct.packed_ushort = type { i16 }

declare void @abort()
declare void @llvm.memcpy.p0.p0.i64(i8*, i8*, i64, i1)

define i32 @main () {
 %1 = alloca i32
 %2 = alloca %struct.source
 %3 = alloca i32
 %4 = alloca %struct.packed_ushort
 store i32 0, i32* %1
 %5 = getelementptr %struct.source, i8* %2, i32 0, i32 0
 store i32 0, i32* %5
 %6 = getelementptr %struct.source, i8* %2, i32 0, i32 1
 store i32 0, i32* %6
 %7 = getelementptr %struct.source, i8* %2, i32 0, i32 2
 store i32 0, i32* %7
 store i32 0, i32* %3
 br label %8
8:
 %9 = load i32, i32* %3
 %10 = icmp slt i32 %9, 16
 br i1 %10, label %11, label %34
11:
 %12 = call i16 @next (i8* %2)
 %13 = getelementptr %struct.packed_ushort, i8* %4, i32 0, i32 0
 store i16 %12, i16* %13
 %14 = load i32, i32* %3
 %15 = icmp eq i32 %14, 0
 br i1 %15, label %16, label %21
16:
 %17 = getelementptr %struct.packed_ushort, i8* %4, i32 0, i32 0
 %18 = load i16, i16* %17
 %19 = zext i16 %18 to i32
 %20 = icmp ne i32 %19, 65535
 br i1 %20, label %29, label %21
21:
 %22 = load i32, i32* %3
 %23 = icmp sgt i32 %22, 0
 br i1 %23, label %24, label %30
24:
 %25 = getelementptr %struct.packed_ushort, i8* %4, i32 0, i32 0
 %26 = load i16, i16* %25
 %27 = zext i16 %26 to i32
 %28 = icmp ne i32 %27, 0
 br i1 %28, label %29, label %30
29:
 call void @abort ()
 unreachable
30:
 br label %31
31:
 %32 = load i32, i32* %3
 %33 = add i32 %32, 1
 store i32 %33, i32* %3
 br label %8
34:
 ret i32 0
}

define i16 @next (i8* %0) {
 %2 = alloca %struct.packed_ushort
 %3 = alloca i8*
 %4 = alloca %struct.packed_ushort
 store i8* %0, i8** %3
 %5 = load i8*, i8** %3
 %6 = getelementptr %struct.source, i8* %5, i32 0, i32 0
 %7 = load i32, i32* %6
 %8 = load i8*, i8** %3
 %9 = getelementptr %struct.source, i8* %8, i32 0, i32 1
 %10 = load i32, i32* %9
 %11 = icmp sge i32 %7, %10
 br i1 %11, label %12, label %28
12:
 %13 = load i8*, i8** %3
 %14 = getelementptr %struct.source, i8* %13, i32 0, i32 2
 %15 = load i32, i32* %14
 %16 = icmp ne i32 %15, 0
 br i1 %16, label %17, label %24
17:
 %18 = load i8*, i8** %3
 %19 = getelementptr %struct.source, i8* %18, i32 0, i32 2
 store i32 0, i32* %19
 %20 = load i8*, i8** %3
 call void @fetch (i8* %20)
 %21 = load i8*, i8** %3
 %22 = call i16 @next (i8* %21)
 %23 = getelementptr %struct.packed_ushort, i8* %2, i32 0, i32 0
 store i16 %22, i16* %23
 br label %30
24:
 %25 = load i8*, i8** %3
 %26 = getelementptr %struct.source, i8* %25, i32 0, i32 2
 store i32 1, i32* %26
 %27 = getelementptr %struct.packed_ushort, i8* %4, i32 0, i32 0
 store i16 -1, i16* %27
 call void @memcpy (i8* %2, i8* %4, i64 2, i1 0)
 br label %30
28:
 %29 = getelementptr %struct.packed_ushort, i8* %4, i32 0, i32 0
 store i16 0, i16* %29
 call void @memcpy (i8* %2, i8* %4, i64 2, i1 0)
 br label %30
30:
 %31 = getelementptr %struct.packed_ushort, i8* %2, i32 0, i32 0
 %32 = load i16, i16* %31
 ret i16 %32
}

define void @fetch (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 %3 = load i8*, i8** %2
 %4 = getelementptr %struct.source, i8* %3, i32 0, i32 1
 store i32 128, i32* %4
 ret void
}
