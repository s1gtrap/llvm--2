declare void @abort()
declare void @exit(i32)

define i32 @sub1 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 ret i32 %3
}

define i32 @testcond (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i32
 store i32 %0, i32* %3
 %7 = load i32, i32* %3
 store i32 %7, i32* %5
 %8 = load i32, i32* %5
 store i32 %8, i32* %6
 %9 = load i32, i32* %6
 %10 = call i32 @sub1 (i32 %9)
 %11 = icmp eq i32 %10, 0
 %12 = zext i1 %11 to i32
 store i32 %12, i32* %4
 br label %13
13:
 %14 = load i32, i32* %4
 %15 = icmp ne i32 %14, 0
 br i1 %15, label %16, label %17
16:
 store i32 5046272, i32* %2
 br label %18
17:
 store i32 0, i32* %2
 br label %18
18:
 %19 = load i32, i32* %2
 ret i32 %19
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @testcond (i32 1)
 %3 = icmp ne i32 %2, 0
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 call void @exit (i32 0)
 unreachable
}
