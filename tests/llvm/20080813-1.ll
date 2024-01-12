declare void @abort()

define void @foo (i16 %0) {
 %2 = alloca i16
 %3 = alloca i8
 store i16 %0, i16* %2
 store i8 -1, i8* %3
 %4 = load i16, i16* %2
 %5 = zext i16 %4 to i32
 %6 = load i8, i8* %3
 %7 = sext i8 %6 to i32
 %8 = icmp eq i32 %5, %7
 br i1 %8, label %9, label %10
9:
 call void @abort ()
 unreachable
10:
 ret void
}

define void @bar (i16 %0) {
 %2 = alloca i16
 %3 = alloca i8
 store i16 %0, i16* %2
 store i8 -1, i8* %3
 %4 = load i16, i16* %2
 %5 = zext i16 %4 to i32
 %6 = load i8, i8* %3
 %7 = zext i8 %6 to i32
 %8 = icmp eq i32 %5, %7
 br i1 %8, label %9, label %10
9:
 call void @abort ()
 unreachable
10:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @foo (i16 -1)
 call void @bar (i16 -1)
 ret i32 0
}
