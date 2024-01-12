@n = global i32 1

declare void @abort()
declare void @exit(i32)

define void @check (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = icmp ne i32 %3, -1
 br i1 %4, label %5, label %6
5:
 call void @abort ()
 unreachable
6:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 store i32 0, i32* %1
 %3 = load i32, i32* @n
 %4 = sub i32 2, %3
 %5 = or i32 1, %4
 %6 = load i32, i32* @n
 %7 = sub i32 0, %6
 %8 = or i32 %5, %7
 store i32 %8, i32* %2
 %9 = load i32, i32* %2
 call void @check (i32 %9)
 call void @exit (i32 0)
 unreachable
}
