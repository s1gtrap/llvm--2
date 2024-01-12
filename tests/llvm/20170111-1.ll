%struct.S = type { i16, i64, i16, i8, i16, i8* }

declare void @abort()

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i64
 %3 = alloca %struct.S
 store i32 0, i32* %1
 store i64 1, i64* %2
 %4 = getelementptr %struct.S, i8* %3, i32 0, i32 0
 store i16 0, i16* %4
 %5 = getelementptr %struct.S, i8* %3, i32 0, i32 1
 store i64 0, i64* %5
 %6 = getelementptr %struct.S, i8* %3, i32 0, i32 2
 store i16 0, i16* %6
 %7 = getelementptr %struct.S, i8* %3, i32 0, i32 3
 store i8 0, i8* %7
 %8 = getelementptr %struct.S, i8* %3, i32 0, i32 4
 store i16 2, i16* %8
 %9 = getelementptr %struct.S, i8* %3, i32 0, i32 5
 store i8* %2, i8** %9
 %10 = call i64 @foo (i8* %3)
 store i64 %10, i64* %2
 %11 = load i64, i64* %2
 %12 = icmp ne i64 %11, 0
 br i1 %12, label %13, label %14
13:
 call void @abort ()
 unreachable
14:
 ret i32 0
}

define i64 @foo (i8* %0) {
 %2 = alloca i8*
 %3 = alloca i64
 store i8* %0, i8** %2
 store i64 1, i64* %3
 %4 = load i8*, i8** %2
 %5 = getelementptr %struct.S, i8* %4, i32 0, i32 4
 %6 = load i16, i16* %5
 %7 = zext i16 %6 to i64
 %8 = load i64, i64* %3
 %9 = sdiv i64 %8, %7
 store i64 %9, i64* %3
 %10 = load i8*, i8** %2
 %11 = getelementptr %struct.S, i8* %10, i32 0, i32 5
 %12 = load i8*, i8** %11
 %13 = load i64, i64* %3
 %14 = getelementptr i64, i8* %12, i64 %13
 %15 = load i64, i64* %14
 %16 = add i64 %15, -1
 store i64 %16, i64* %14
 %17 = load i64, i64* %3
 ret i64 %17
}
