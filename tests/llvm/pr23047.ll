declare void @abort()
declare void @exit(i32)

define void @f (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = icmp sgt i32 %3, 0
 br i1 %4, label %5, label %7
5:
 %6 = load i32, i32* %2
 br label %10
7:
 %8 = load i32, i32* %2
 %9 = sub i32 0, %8
 br label %10
10:
 %11 = phi i32 [%6, %5], [%9, %7]
 store i32 %11, i32* %2
 %12 = load i32, i32* %2
 %13 = icmp slt i32 %12, 0
 br i1 %13, label %14, label %15
14:
 ret void
15:
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
