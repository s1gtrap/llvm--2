@.str = global [8 x i8] c"All ok\0A\00"

declare void @abort()
declare i32 @printf(i8*, ...)

define i32 @foo (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = and i32 %3, -2130706433
 %5 = icmp ne i32 %4, -2147418114
 br i1 %5, label %6, label %7
6:
 call void @abort ()
 unreachable
7:
 ret i32 0
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @foo (i32 -2147418114)
 %3 = call i32 (i8*, ...) @printf (i8* @.str)
 ret i32 0
}
