@s = global i16 -1

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = load i16, i16* @s
 %3 = call i64 @foo (i16 %2)
 %4 = add i64 %3, 1
 %5 = icmp ne i64 %4, 0
 %6 = zext i1 %5 to i32
 ret i32 %6
}

define i64 @foo (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = sext i16 %3 to i64
 ret i64 %4
}
