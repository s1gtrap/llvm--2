declare void @abort()

define i32 @foo () {
 ret i32 123
}

define i32 @bar () {
 %1 = alloca i32
 store i32 1, i32* %1
 %2 = call i32 @foo ()
 %3 = sext i32 %2 to i64
 %4 = or i64 %3, 4073709551608
 %5 = xor i64 4294967295, %4
 %6 = load i32, i32* %1
 %7 = sext i32 %6 to i64
 %8 = or i64 %7, %5
 %9 = trunc i64 %8 to i32
 store i32 %9, i32* %1
 %10 = load i32, i32* %1
 ret i32 %10
}

define i32 @main () {
 %1 = call i32 @bar ()
 %2 = icmp ne i32 %1, -2080555003
 br i1 %2, label %3, label %4
3:
 call void @abort ()
 unreachable
4:
 ret i32 0
}
