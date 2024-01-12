%struct.VEC_char_base = type { i32, i32, [1 x i16] }

declare i8* @malloc(i64)
declare void @abort()

define i16 @foo (i8* %0, i32 %1) {
 %3 = alloca i8*
 %4 = alloca i32
 %5 = alloca i8*
 store i8* %0, i8** %3
 store i32 %1, i32* %4
 %6 = load i8*, i8** %3
 %7 = getelementptr %struct.VEC_char_base, i8* %6, i32 0, i32 2
 %8 = load i32, i32* %4
 %9 = sext i32 %8 to i64
 %10 = getelementptr [1 x i16], i8* %7, i64 0, i64 %9
 store i16 0, i16* %10
 %11 = load i8*, i8** %3
 %12 = getelementptr %struct.VEC_char_base, i8* %11, i32 0, i32 2
 %13 = getelementptr [1 x i16], i8* %12, i64 0, i64 8
 store i8* %13, i8** %5
 %14 = load i8*, i8** %5
 store i16 1, i16* %14
 %15 = load i8*, i8** %3
 %16 = getelementptr %struct.VEC_char_base, i8* %15, i32 0, i32 2
 %17 = load i32, i32* %4
 %18 = sext i32 %17 to i64
 %19 = getelementptr [1 x i16], i8* %16, i64 0, i64 %18
 %20 = load i16, i16* %19
 ret i16 %20
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i8*
 store i32 0, i32* %1
 %3 = call i8* @malloc (i64 268)
 store i8* %3, i8** %2
 %4 = load i8*, i8** %2
 %5 = call i16 @foo (i8* %4, i32 8)
 %6 = sext i16 %5 to i32
 %7 = icmp ne i32 %6, 1
 br i1 %7, label %8, label %9
8:
 call void @abort ()
 unreachable
9:
 ret i32 0
}
