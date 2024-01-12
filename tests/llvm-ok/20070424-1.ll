declare void @exit(i32)
declare void @abort()

define void @do_exit () {
 call void @exit (i32 0)
 unreachable
}

define void @do_abort () {
 call void @abort ()
 unreachable
}

define void @foo (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %3
 %6 = load i32, i32* %4
 %7 = icmp slt i32 %5, %6
 br i1 %7, label %8, label %9
8:
 br label %15
9:
 call void @do_exit ()
 %10 = load i32, i32* %3
 %11 = load i32, i32* %4
 %12 = icmp ne i32 %10, %11
 br i1 %12, label %13, label %14
13:
 br label %15
14:
 call void @do_abort ()
 br label %16
15:
 call void @do_abort ()
 br label %16
16:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @foo (i32 1, i32 0)
 ret i32 0
}
