declare void @abort()
declare void @exit(i32)

define i16 @f (i16 %0) {
 %2 = alloca i16
 %3 = alloca i16
 %4 = alloca i16
 store i16 %0, i16* %3
 %5 = load i16, i16* %3
 %6 = sext i16 %5 to i32
 %7 = icmp sgt i32 %6, 0
 br i1 %7, label %8, label %9
8:
 store i16 0, i16* %2
 br label %15
9:
 %10 = load i16, i16* %3
 %11 = sext i16 %10 to i32
 %12 = add i32 %11, -32768
 %13 = trunc i32 %12 to i16
 store i16 %13, i16* %4
 %14 = load i16, i16* %4
 store i16 %14, i16* %2
 br label %15
15:
 %16 = load i16, i16* %2
 ret i16 %16
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i16 @f (i16 -32767)
 %3 = zext i16 %2 to i32
 %4 = icmp ne i32 %3, 1
 br i1 %4, label %5, label %6
5:
 call void @abort ()
 unreachable
6:
 call void @exit (i32 0)
 unreachable
}
