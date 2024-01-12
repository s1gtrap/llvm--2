@c = global i16 -32768

declare void @abort()

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = load i16, i16* @c
 %3 = zext i16 %2 to i32
 %4 = sub i32 %3, 32768
 %5 = icmp slt i32 %4, 0
 br i1 %5, label %11, label %6
6:
 %7 = load i16, i16* @c
 %8 = zext i16 %7 to i32
 %9 = sub i32 %8, 32768
 %10 = icmp sgt i32 %9, 32767
 br i1 %10, label %11, label %12
11:
 call void @abort ()
 unreachable
12:
 ret i32 0
}
