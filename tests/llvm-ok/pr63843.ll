@__const.main.x = global [8 x i8] c"\01\01\01\01\00\00\00\00"

declare void @llvm.memcpy.p0.p0.i64(i8*, i8*, i64, i1)
declare void @abort()

define i16 @bar (i8* %0) {
 %2 = alloca i16
 %3 = alloca i8*
 %4 = alloca i32
 %5 = alloca i16
 store i8* %0, i8** %3
 %6 = load i8*, i8** %3
 %7 = getelementptr i8, i8* %6, i64 0
 call void @memcpy (i8* %4, i8* %7, i64 4, i1 0)
 %8 = load i32, i32* %4
 %9 = xor i32 %8, -2139062144
 store i32 %9, i32* %4
 %10 = load i8*, i8** %3
 %11 = getelementptr i8, i8* %10, i64 0
 call void @memcpy (i8* %11, i8* %4, i64 4, i1 0)
 %12 = load i8*, i8** %3
 %13 = getelementptr i8, i8* %12, i64 2
 call void @memcpy (i8* %5, i8* %13, i64 2, i1 0)
 %14 = load i16, i16* %5
 store i16 %14, i16* %2
 %15 = load i16, i16* %2
 %16 = zext i16 %15 to i32
 %17 = shl i32 %16, 8
 %18 = load i16, i16* %2
 %19 = zext i16 %18 to i32
 %20 = ashr i32 %19, 8
 %21 = or i32 %17, %20
 %22 = trunc i32 %21 to i16
 ret i16 %22
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca [8 x i8]
 store i32 0, i32* %1
 call void @memcpy (i8* %2, i8* @__const.main.x, i64 8, i1 0)
 %3 = getelementptr [8 x i8], i8* %2, i64 0, i64 0
 %4 = call i16 @bar (i8* %3)
 %5 = zext i16 %4 to i32
 %6 = icmp ne i32 %5, 33153
 br i1 %6, label %7, label %8
7:
 call void @abort ()
 unreachable
8:
 ret i32 0
}
