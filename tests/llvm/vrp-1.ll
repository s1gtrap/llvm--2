declare void @abort()
declare void @exit(i32)

define i32 @f (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 store i32 %0, i32* %3
 %4 = load i32, i32* %3
 %5 = icmp ne i32 %4, 2
 br i1 %5, label %6, label %13
6:
 %7 = load i32, i32* %3
 %8 = sub i32 0, %7
 store i32 %8, i32* %3
 %9 = load i32, i32* %3
 %10 = icmp eq i32 %9, 2
 br i1 %10, label %11, label %12
11:
 store i32 0, i32* %2
 br label %14
12:
 store i32 1, i32* %2
 br label %14
13:
 store i32 1, i32* %2
 br label %14
14:
 %15 = load i32, i32* %2
 ret i32 %15
}

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 %6 = call i32 @f (i32 -2)
 %7 = icmp ne i32 %6, 0
 br i1 %7, label %8, label %9
8:
 call void @abort ()
 unreachable
9:
 call void @exit (i32 0)
 unreachable
}
