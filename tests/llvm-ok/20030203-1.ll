declare void @abort()

define i32 @do_layer3 (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 store i32 %0, i32* %2
 %4 = load i32, i32* %2
 %5 = icmp sge i32 %4, 0
 br i1 %5, label %6, label %7
6:
 store i32 1, i32* %3
 br label %8
7:
 store i32 2, i32* %3
 br label %8
8:
 %9 = load i32, i32* %2
 call void @f (i32 %9)
 %10 = load i32, i32* %3
 ret i32 %10
}

define void @f (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 ret void
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @do_layer3 (i32 -1)
 %3 = icmp ne i32 %2, 2
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 ret i32 0
}
