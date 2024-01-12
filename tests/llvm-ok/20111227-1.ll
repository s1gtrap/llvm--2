@v = global i16 -1

declare void @abort()

define void @bar (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = icmp ne i32 %3, -1
 br i1 %4, label %5, label %6
5:
 call void @abort ()
 unreachable
6:
 ret void
}

define void @foo (i8* %0, i32 %1) {
 %3 = alloca i8*
 %4 = alloca i32
 %5 = alloca i16
 store i8* %0, i8** %3
 store i32 %1, i32* %4
 %6 = load i8*, i8** %3
 %7 = load i16, i16* %6
 store i16 %7, i16* %5
 %8 = load i32, i32* %4
 %9 = icmp ne i32 %8, 0
 br i1 %9, label %10, label %13
10:
 %11 = load i16, i16* %5
 %12 = zext i16 %11 to i32
 call void @bar (i32 %12)
 br label %16
13:
 %14 = load i16, i16* %5
 %15 = sext i16 %14 to i32
 call void @bar (i32 %15)
 br label %16
16:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @foo (i8* @v, i32 0)
 ret i32 0
}
