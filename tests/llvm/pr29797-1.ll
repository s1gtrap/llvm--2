declare void @abort()

define i32 @bar () {
 ret i32 32768
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 store i32 0, i32* %1
 %3 = call i32 @bar ()
 store i32 %3, i32* %2
 %4 = load i32, i32* %2
 %5 = and i32 %4, 32768
 %6 = icmp ne i32 %5, 0
 br i1 %6, label %7, label %10
7:
 %8 = load i32, i32* %2
 %9 = or i32 %8, 65536
 store i32 %9, i32* %2
 br label %10
10:
 %11 = load i32, i32* %2
 %12 = icmp ne i32 %11, 98304
 br i1 %12, label %13, label %14
13:
 call void @abort ()
 unreachable
14:
 ret i32 0
}
