declare void @abort()

define void @f (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = icmp sgt i32 %3, 52
 br i1 %4, label %5, label %6
5:
 call void @abort ()
 unreachable
6:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 %3 = alloca i32
 store i32 0, i32* %1
 store i32 52, i32* %2
 store i32 4, i32* %3
 br label %4
4:
 %5 = load i32, i32* %3
 %6 = load i32, i32* %2
 %7 = icmp ult i32 %5, %6
 br i1 %7, label %8, label %13
8:
 %9 = load i32, i32* %3
 call void @f (i32 %9)
 br label %10
10:
 %11 = load i32, i32* %3
 %12 = add i32 %11, 3
 store i32 %12, i32* %3
 br label %4
13:
 ret i32 0
}
