@a = global i32 4660

declare void @abort()

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 store i32 0, i32* %1
 store i32 4660, i32* %2
 %3 = load i32, i32* @a
 %4 = call i32 @swap (i32 %3)
 %5 = icmp ne i32 %4, 13330
 br i1 %5, label %6, label %7
6:
 call void @abort ()
 unreachable
7:
 %8 = load i32, i32* %2
 %9 = call i32 @swap (i32 %8)
 %10 = icmp ne i32 %9, 13330
 br i1 %10, label %11, label %12
11:
 call void @abort ()
 unreachable
12:
 ret i32 0
}

define i32 @swap (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = trunc i32 %3 to i16
 %5 = zext i16 %4 to i32
 %6 = shl i32 %5, 8
 %7 = load i32, i32* %2
 %8 = trunc i32 %7 to i16
 %9 = zext i16 %8 to i32
 %10 = ashr i32 %9, 8
 %11 = or i32 %6, %10
 %12 = trunc i32 %11 to i16
 %13 = zext i16 %12 to i32
 ret i32 %13
}
