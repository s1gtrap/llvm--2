@__const.main.buf = global [16 x i8] c"1234567890\00\00\00\00\00\00"

declare void @llvm.memcpy.p0.p0.i64(i8*, i8*, i64, i1)
declare i64 @strlen(i8*)
declare void @abort()

define i32 @main () {
 %1 = alloca i32
 %2 = alloca [16 x i8]
 %3 = alloca i8*
 store i32 0, i32* %1
 call void @memcpy (i8* %2, i8* @__const.main.buf, i64 16, i1 0)
 %4 = getelementptr [16 x i8], i8* %2, i64 0, i64 0
 store i8* %4, i8** %3
 %5 = getelementptr [16 x i8], i8* %2, i64 0, i64 0
 %6 = call i64 @strlen (i8* %5)
 %7 = trunc i64 %6 to i8
 %8 = load i8*, i8** %3
 %9 = getelementptr i8, i8* %8, i32 1
 store i8* %9, i8** %3
 store i8 %7, i8* %8
 %10 = getelementptr [16 x i8], i8* %2, i64 0, i64 0
 %11 = load i8, i8* %10
 %12 = sext i8 %11 to i32
 %13 = icmp ne i32 %12, 10
 br i1 %13, label %21, label %14
14:
 %15 = load i8*, i8** %3
 %16 = getelementptr [16 x i8], i8* %2, i64 0, i64 0
 %17 = ptrtoint i8** %15 to i64
 %18 = ptrtoint i8** %16 to i64
 %19 = sub i64 %17, %18
 %20 = icmp ne i64 %19, 1
 br i1 %20, label %21, label %22
21:
 call void @abort ()
 unreachable
22:
 ret i32 0
}
