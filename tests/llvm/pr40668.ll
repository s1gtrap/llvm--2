declare void @abort()
declare void @memcpy(i8*, i8*, i64, i1)

define void @bar (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i8*
 store i32 %0, i32* %3
 store i8* %1, i8** %4
 %5 = load i32, i32* %3
 switch i32 %5, label %14 [
    i32 1, label %6
    i32 7, label %8
    i32 8, label %10
    i32 9, label %12
  ]
6:
 %7 = load i8*, i8** %4
 call void @foo (i32 305419896, i8* %7)
 br label %14
8:
 %9 = load i8*, i8** %4
 call void @foo (i32 0, i8* %9)
 br label %14
10:
 %11 = load i8*, i8** %4
 call void @foo (i32 0, i8* %11)
 br label %14
12:
 %13 = load i8*, i8** %4
 call void @foo (i32 0, i8* %13)
 br label %14
14:
 ret void
}

define void @foo (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i8*
 store i32 %0, i32* %3
 store i8* %1, i8** %4
 %5 = load i8*, i8** %4
 call void @memcpy (i8* %5, i8* %3, i64 4, i1 0)
 ret void
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 store i32 0, i32* %1
 call void @bar (i32 1, i8* %2)
 %3 = load i32, i32* %2
 %4 = icmp ne i32 %3, 305419896
 br i1 %4, label %5, label %6
5:
 call void @abort ()
 unreachable
6:
 ret i32 0
}
