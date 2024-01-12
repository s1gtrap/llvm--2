@a = global i32 -1

declare void @abort()

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 store i32 0, i32* %1
 %3 = load i32, i32* @a
 %4 = icmp eq i32 %3, 0
 br i1 %4, label %5, label %6
5:
 br label %9
6:
 %7 = load i32, i32* @a
 %8 = sub i32 0, %7
 br label %9
9:
 %10 = phi i32 [0, %5], [%8, %6]
 store i32 %10, i32* %2
 %11 = load i32, i32* %2
 %12 = icmp slt i32 %11, 1
 br i1 %12, label %13, label %14
13:
 call void @abort ()
 unreachable
14:
 ret i32 0
}
