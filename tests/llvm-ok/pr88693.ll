@bar.u = global [9 x i8] c"abcdefghi"
@baz.u = global [9 x i8] c"jklmnopqr"

declare i64 @strlen(i8*)
declare void @abort()
declare void @llvm.memset.p0.i64(i8*, i8, i64, i1)
declare void @memcpy(i8*, i8*, i64, i1)

define void @foo (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 %3 = load i8*, i8** %2
 %4 = call i64 @strlen (i8* %3)
 %5 = icmp ne i64 %4, 9
 br i1 %5, label %6, label %7
6:
 call void @abort ()
 unreachable
7:
 ret void
}

define void @quux (i8* %0) {
 %2 = alloca i8*
 %3 = alloca i32
 store i8* %0, i8** %2
 store i32 0, i32* %3
 br label %4
4:
 %5 = load i32, i32* %3
 %6 = icmp slt i32 %5, 100
 br i1 %6, label %7, label %20
7:
 %8 = load i8*, i8** %2
 %9 = load i32, i32* %3
 %10 = sext i32 %9 to i64
 %11 = getelementptr i8, i8* %8, i64 %10
 %12 = load i8, i8* %11
 %13 = sext i8 %12 to i32
 %14 = icmp ne i32 %13, 120
 br i1 %14, label %15, label %16
15:
 call void @abort ()
 unreachable
16:
 br label %17
17:
 %18 = load i32, i32* %3
 %19 = add i32 %18, 1
 store i32 %19, i32* %3
 br label %4
20:
 ret void
}

define void @qux () {
 %1 = alloca [100 x i8]
 %2 = getelementptr [100 x i8], i8* %1, i64 0, i64 0
 call void @memset (i8* %2, i8 120, i64 100, i1 0)
 %3 = getelementptr [100 x i8], i8* %1, i64 0, i64 0
 call void @quux (i8* %3)
 ret void
}

define void @bar () {
 %1 = alloca [100 x i8]
 %2 = getelementptr [100 x i8], i8* %1, i64 0, i64 0
 call void @memcpy (i8* %2, i8* @bar.u, i64 9, i1 0)
 %3 = getelementptr [100 x i8], i8* %1, i64 0, i64 9
 store i8 0, i8* %3
 %4 = getelementptr [100 x i8], i8* %1, i64 0, i64 0
 call void @foo (i8* %4)
 ret void
}

define void @baz () {
 %1 = alloca [100 x i8]
 %2 = getelementptr [100 x i8], i8* %1, i64 0, i64 0
 call void @memcpy (i8* %2, i8* @baz.u, i64 9, i1 0)
 %3 = getelementptr [100 x i8], i8* %1, i64 0, i64 9
 store i8 0, i8* %3
 %4 = getelementptr [100 x i8], i8* %1, i64 0, i64 0
 call void @foo (i8* %4)
 ret void
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @qux ()
 call void @bar ()
 call void @baz ()
 ret i32 0
}
