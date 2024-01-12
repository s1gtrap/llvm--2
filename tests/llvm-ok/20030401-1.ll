declare void @abort()

define i32 @bar () {
 ret i32 1
}

define void @foo (i32 %0) {
 %2 = alloca i32
 %3 = alloca i8
 store i32 %0, i32* %2
 store i8 0, i8* %3
 %4 = load i32, i32* %2
 %5 = icmp eq i32 %4, 0
 br i1 %5, label %9, label %6
6:
 %7 = call i32 @bar ()
 %8 = icmp ne i32 %7, 0
 br label %9
9:
 %10 = phi i1 [1, %1], [%8, %6]
 %11 = zext i1 %10 to i32
 %12 = trunc i32 %11 to i8
 store i8 %12, i8* %3
 %13 = icmp ne i8 %12, 0
 br i1 %13, label %16, label %14
14:
 %15 = call i32 @bar ()
 br label %16
16:
 %17 = load i8, i8* %3
 %18 = icmp ne i8 %17, 0
 br i1 %18, label %20, label %19
19:
 call void @abort ()
 unreachable
20:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @foo (i32 1)
 ret i32 0
}
