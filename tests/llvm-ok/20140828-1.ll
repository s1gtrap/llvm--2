declare void @abort()

define i8* @f (i8* %0, i32 %1, i8* %2) {
 %4 = alloca i8*
 %5 = alloca i32
 %6 = alloca i8*
 %7 = alloca i16
 store i8* %0, i8** %4
 store i32 %1, i32* %5
 store i8* %2, i8** %6
 %8 = load i8*, i8** %4
 %9 = load i16, i16* %8
 store i16 %9, i16* %7
 %10 = load i8*, i8** %4
 %11 = getelementptr i16, i8* %10, i32 1
 store i8* %11, i8** %4
 %12 = load i32, i32* %5
 %13 = load i16, i16* %7
 %14 = sext i16 %13 to i32
 %15 = shl i32 %12, %14
 %16 = trunc i32 %15 to i16
 store i16 %16, i16* %7
 %17 = load i16, i16* %7
 %18 = sext i16 %17 to i32
 %19 = load i8*, i8** %6
 store i32 %18, i32* %19
 %20 = load i8*, i8** %4
 ret i8* %20
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 %3 = alloca [2 x i16]
 store i32 0, i32* %1
 %4 = getelementptr [2 x i16], i8* %3, i64 0, i64 0
 store i16 0, i16* %4
 %5 = getelementptr [2 x i16], i8* %3, i64 0, i64 0
 %6 = call i8* @f (i8* %5, i32 1, i8* %2)
 %7 = getelementptr [2 x i16], i8* %3, i64 0, i64 1
 %8 = icmp ne i8* %6, %7
 br i1 %8, label %9, label %10
9:
 call void @abort ()
 unreachable
10:
 %11 = load i32, i32* %2
 %12 = icmp ne i32 %11, 1
 br i1 %12, label %13, label %14
13:
 call void @abort ()
 unreachable
14:
 ret i32 0
}
