declare void @abort()

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i16
 store i32 0, i32* %1
 store i16 -1, i16* %2
 %3 = load i16, i16* %2
 %4 = sext i16 %3 to i32
 %5 = zext i32 %4 to i64
 %6 = icmp uge i64 %5, 4294967296
 br i1 %6, label %7, label %8
7:
 call void @abort ()
 unreachable
8:
 ret i32 0
}
