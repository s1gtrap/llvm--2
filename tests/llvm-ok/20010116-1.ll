%struct.Data = type { i32, i32, i32 }

declare void @abort()
declare void @exit(i32)

define void @find (i8* %0, i8* %1) {
 %3 = alloca i8*
 %4 = alloca i8*
 %5 = alloca i32
 store i8* %0, i8** %3
 store i8* %1, i8** %4
 %6 = load i8*, i8** %4
 %7 = load i8*, i8** %3
 %8 = ptrtoint i8** %6 to i64
 %9 = ptrtoint i8** %7 to i64
 %10 = sub i64 %8, %9
 %11 = sdiv i64 %10, 12
 %12 = ashr i64 %11, 2
 %13 = trunc i64 %12 to i32
 store i32 %13, i32* %5
 br label %14
14:
 %15 = load i32, i32* %5
 %16 = icmp sgt i32 %15, 0
 br i1 %16, label %17, label %22
17:
 %18 = load i32, i32* %5
 call void @ok (i32 %18)
 br label %19
19:
 %20 = load i32, i32* %5
 %21 = add i32 %20, -1
 store i32 %21, i32* %5
 br label %14
22:
 call void @abort ()
 unreachable
}

define void @ok (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = icmp ne i32 %3, 1
 br i1 %4, label %5, label %6
5:
 call void @abort ()
 unreachable
6:
 call void @exit (i32 0)
 unreachable
}

define i32 @main () {
 %1 = alloca [4 x %struct.Data]
 %2 = getelementptr [4 x %struct.Data], i8* %1, i64 0, i64 0
 %3 = getelementptr %struct.Data, i8* %2, i64 0
 %4 = getelementptr [4 x %struct.Data], i8* %1, i64 0, i64 0
 %5 = getelementptr %struct.Data, i8* %4, i64 4
 call void @find (i8* %3, i8* %5)
 ret i32 0
}
