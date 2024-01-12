declare void @abort()

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i8
 %3 = alloca i8
 store i32 0, i32* %1
 store i8 -30, i8* %2
 store i8 -31, i8* %3
 %4 = load i8, i8* %2
 %5 = sext i8 %4 to i32
 %6 = load i8, i8* %3
 %7 = sext i8 %6 to i16
 %8 = zext i16 %7 to i32
 %9 = icmp sgt i32 %5, %8
 br i1 %9, label %10, label %11
10:
 call void @abort ()
 unreachable
11:
 ret i32 0
}
