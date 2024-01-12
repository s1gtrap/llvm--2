declare void @abort()
declare void @exit(i32)

define i32 @foo (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = icmp eq i32 %3, -2
 br i1 %4, label %10, label %5
5:
 %6 = load i32, i32* %2
 %7 = sub i32 0, %6
 %8 = sub i32 %7, 100
 %9 = icmp sge i32 %8, 0
 br i1 %9, label %10, label %11
10:
 call void @abort ()
 unreachable
11:
 ret i32 0
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @foo (i32 -3)
 %3 = call i32 @foo (i32 -99)
 call void @exit (i32 0)
 unreachable
}
