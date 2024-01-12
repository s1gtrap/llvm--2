%union.aun = type { [8 x i8] }

declare void @llvm.memset.p0.i64(i8*, i8, i64, i1)
declare void @abort()

define i32 @main () {
 %1 = alloca i32
 %2 = alloca %union.aun
 store i32 0, i32* %1
 call void @memset (i8* %2, i8 0, i64 8, i1 0)
 %3 = getelementptr [8 x i8], i8* %2, i64 0, i64 2
 %4 = load i8, i8* %3
 %5 = sext i8 %4 to i32
 %6 = icmp ne i32 %5, 0
 br i1 %6, label %7, label %8
7:
 call void @abort ()
 unreachable
8:
 ret i32 0
}
