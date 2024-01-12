%struct.mem = type { [4 x i8*] }

declare i8* @malloc(i64)
declare void @abort()

define void @bar (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 %3 = call i8* @malloc (i64 16)
 %4 = load i8*, i8** %2
 store i8* %3, i8** %4
 ret void
}

define i8* @foo (i32 %0) {
 %2 = alloca i32
 %3 = alloca i8*
 %4 = alloca i8*
 %5 = alloca i8*
 store i32 %0, i32* %2
 %6 = call i8* @malloc (i64 32)
 store i8* %6, i8** %3
 %7 = load i8*, i8** %3
 store i8* %7, i8** %4
 %8 = load i8*, i8** %4
 %9 = getelementptr %struct.mem, i8* %8, i32 0, i32 0
 %10 = load i32, i32* %2
 %11 = mul i32 %10, 8
 %12 = sub i32 %11, 5
 %13 = sext i32 %12 to i64
 %14 = getelementptr [4 x i8*], i8* %9, i64 0, i64 %13
 store i8* %14, i8** %5
 %15 = load i8*, i8** %5
 store i8* null, i8** %15
 %16 = load i8*, i8** %5
 call void @bar (i8* %16)
 %17 = load i8*, i8** %5
 %18 = load i8*, i8** %17
 ret i8* %18
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i8* @foo (i32 1)
 %3 = icmp eq i8* %2, null
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 ret i32 0
}
