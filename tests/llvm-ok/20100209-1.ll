declare void @abort()

define i32 @bar (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = sext i32 %3 to i64
 %5 = udiv i64 %4, 8
 %6 = trunc i64 %5 to i32
 ret i32 %6
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @bar (i32 -1)
 %3 = icmp ne i32 %2, -1
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 ret i32 0
}
