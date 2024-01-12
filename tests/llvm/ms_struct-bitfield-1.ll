declare void @abort()

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 %6 = alloca i32
 %7 = alloca i32
 %8 = alloca i32
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 store i32 40, i32* %6
 store i32 8, i32* %7
 store i32 32, i32* %8
 %9 = load i32, i32* %6
 %10 = icmp ne i32 %9, 40
 br i1 %10, label %11, label %12
11:
 call void @abort ()
 unreachable
12:
 %13 = load i32, i32* %7
 %14 = icmp ne i32 %13, 8
 br i1 %14, label %15, label %16
15:
 call void @abort ()
 unreachable
16:
 %17 = load i32, i32* %8
 %18 = icmp ne i32 %17, 32
 br i1 %18, label %19, label %20
19:
 call void @abort ()
 unreachable
20:
 ret i32 0
}
