@.str = global [4 x i8] c"foo\00"
@.str.1 = global [4 x i8] c"bar\00"

declare void @abort()
declare void @exit(i32)

define void @bar (i8* %0, i32 %1, i8* %2) {
 %4 = alloca i8*
 %5 = alloca i32
 %6 = alloca i8*
 store i8* %0, i8** %4
 store i32 %1, i32* %5
 store i8* %2, i8** %6
 ret void
}

define i64 @foo (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i8*
 %5 = alloca i64
 store i32 %0, i32* %3
 store i8* %1, i8** %4
 %6 = load i32, i32* %3
 switch i32 %6, label %22 [
    i32 10, label %7
    i32 11, label %10
    i32 12, label %13
    i32 13, label %16
    i32 14, label %19
  ]
7:
 %8 = load i8*, i8** %4
 %9 = load i64, i64* %8
 store i64 %9, i64* %5
 br label %23
10:
 %11 = load i8*, i8** %4
 %12 = load i64, i64* %11
 store i64 %12, i64* %5
 br label %23
13:
 %14 = load i8*, i8** %4
 %15 = load i64, i64* %14
 store i64 %15, i64* %5
 br label %23
16:
 %17 = load i8*, i8** %4
 %18 = load i64, i64* %17
 store i64 %18, i64* %5
 br label %23
19:
 %20 = load i8*, i8** %4
 %21 = load i64, i64* %20
 store i64 %21, i64* %5
 br label %23
22:
 call void @bar (i8* @.str, i32 1, i8* @.str.1)
 br label %23
23:
 %24 = load i64, i64* %5
 ret i64 %24
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i64
 store i32 0, i32* %1
 store i64 24, i64* %2
 %3 = call i64 @foo (i32 13, i8* %2)
 %4 = icmp ne i64 %3, 24
 br i1 %4, label %5, label %6
5:
 call void @abort ()
 unreachable
6:
 call void @exit (i32 0)
 unreachable
}
