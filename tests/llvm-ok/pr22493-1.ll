declare void @abort()
declare void @exit(i32)

define void @f (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = icmp sgt i32 %3, 0
 br i1 %4, label %5, label %6
5:
 call void @abort ()
 unreachable
6:
 %7 = load i32, i32* %2
 %8 = sub i32 0, %7
 store i32 %8, i32* %2
 %9 = load i32, i32* %2
 %10 = icmp slt i32 %9, 0
 br i1 %10, label %11, label %12
11:
 ret void
12:
 call void @abort ()
 unreachable
}

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 call void @f (i32 -2147483648)
 call void @exit (i32 0)
 unreachable
}
