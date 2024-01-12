declare void @abort()

define void @test1 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = icmp eq i32 %3, 12
 br i1 %4, label %5, label %6
5:
 br label %14
6:
 %7 = load i32, i32* %2
 %8 = icmp ne i32 %7, 17
 br i1 %8, label %9, label %14
9:
 %10 = load i32, i32* %2
 %11 = icmp eq i32 %10, 15
 br i1 %11, label %12, label %13
12:
 br label %14
13:
 call void @abort ()
 unreachable
14:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @test1 (i32 15)
 ret i32 0
}
