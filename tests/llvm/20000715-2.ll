declare void @abort()
declare void @exit(i32)

define i32 @foo (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = add i32 %3, 1
 %5 = trunc i32 %4 to i8
 %6 = zext i8 %5 to i32
 %7 = mul i32 %6, 4
 ret i32 %7
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @foo (i32 255)
 %3 = icmp ne i32 %2, 0
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 call void @exit (i32 0)
 unreachable
}
