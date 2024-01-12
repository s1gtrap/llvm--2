%struct.stuff = type { i32, i32, i32, i32, i32, i8*, i32 }

declare void @abort()
declare void @llvm.memset.p0.i64(i8*, i8, i64, i1)

define void @bar (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 %3 = load i8*, i8** %2
 %4 = getelementptr %struct.stuff, i8* %3, i32 0, i32 6
 %5 = load i32, i32* %4
 %6 = icmp ne i32 %5, 2
 br i1 %6, label %7, label %8
7:
 call void @abort ()
 unreachable
8:
 ret void
}

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 %6 = alloca %struct.stuff
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 call void @memset (i8* %6, i8 0, i64 40, i1 0)
 %7 = getelementptr %struct.stuff, i8* %6, i32 0, i32 0
 store i32 100, i32* %7
 %8 = getelementptr %struct.stuff, i8* %6, i32 0, i32 3
 store i32 100, i32* %8
 %9 = getelementptr %struct.stuff, i8* %6, i32 0, i32 6
 store i32 2, i32* %9
 call void @bar (i8* %6)
 ret i32 0
}
