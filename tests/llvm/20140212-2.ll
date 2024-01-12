declare void @abort()

define i32 @f (i16 %0) {
 %2 = alloca i16
 %3 = alloca i32
 %4 = alloca i32
 store i16 %0, i16* %2
 store i32 -1, i32* %3
 %5 = load i16, i16* %2
 %6 = zext i16 %5 to i32
 %7 = icmp ne i32 65535, %6
 br i1 %7, label %8, label %11
8:
 %9 = load i16, i16* %2
 %10 = zext i16 %9 to i32
 store i32 %10, i32* %3
 br label %11
11:
 %12 = load i32, i32* %3
 ret i32 %12
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @f (i16 1)
 %3 = icmp ne i32 %2, 1
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 %6 = call i32 @f (i16 -1)
 %7 = icmp ne i32 %6, -1
 br i1 %7, label %8, label %9
8:
 call void @abort ()
 unreachable
9:
 ret i32 0
}
