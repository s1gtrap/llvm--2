@c = global i8 -1

declare void @abort()
declare void @exit(i32)

define i32 @foo () {
 %1 = load i8, i8* @c
 %2 = sext i8 %1 to i16
 %3 = zext i16 %2 to i32
 %4 = xor i32 %3, -103
 ret i32 %4
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @foo ()
 %3 = icmp ne i32 %2, -65434
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 call void @exit (i32 0)
 unreachable
}
