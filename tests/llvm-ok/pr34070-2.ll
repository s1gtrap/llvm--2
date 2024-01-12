declare void @abort()

define i32 @f (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %3
 %6 = load i32, i32* %4
 %7 = shl i32 1, %6
 %8 = sdiv i32 %5, %7
 ret i32 %8
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @f (i32 -1, i32 1)
 %3 = icmp ne i32 %2, 0
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 ret i32 0
}
