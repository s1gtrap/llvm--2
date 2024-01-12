declare void @abort()

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @something (i32 -1)
 ret i32 0
}

define void @something (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = icmp ne i32 %3, -1
 br i1 %4, label %5, label %6
5:
 call void @abort ()
 unreachable
6:
 ret void
}
