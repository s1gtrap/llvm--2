declare void @abort()
declare void @exit(i32)

define void @check (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = icmp ne i32 %3, 1
 br i1 %4, label %5, label %6
5:
 call void @abort ()
 unreachable
6:
 ret void
}

define void @test (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %3
 %6 = icmp ne i32 %5, 0
 %7 = zext i1 %6 to i64
 %8 = select i1 %6, i32 1, i32 0
 %9 = load i32, i32* %4
 %10 = icmp ne i32 %9, 0
 %11 = zext i1 %10 to i64
 %12 = select i1 %10, i32 2, i32 0
 %13 = or i32 %8, %12
 call void @check (i32 %13)
 ret void
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @test (i32 1, i32 0)
 call void @exit (i32 0)
 unreachable
}
