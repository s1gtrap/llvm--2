declare void @abort()

define i16 @foo (i8 %0) {
 %2 = alloca i8
 store i8 %0, i8* %2
 %3 = load i8, i8* %2
 %4 = zext i8 %3 to i32
 %5 = mul i32 %4, 255
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i16 @foo (i8 64)
 %3 = zext i16 %2 to i32
 %4 = icmp ne i32 %3, 16320
 br i1 %4, label %5, label %6
5:
 call void @abort ()
 unreachable
6:
 ret i32 0
}
