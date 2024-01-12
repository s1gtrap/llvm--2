@v = global i8 0

declare void @abort()

define i32 @bar () {
 %1 = load i8, i8* @v
 %2 = sext i8 %1 to i32
 %3 = icmp sge i32 %2, 0
 %4 = zext i1 %3 to i32
 %5 = call i8 @foo (i32 %4, i32 7)
 %6 = sext i8 %5 to i32
 %7 = icmp sge i32 %6, 1
 %8 = zext i1 %7 to i32
 ret i32 %8
}

define i8 @foo (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %3
 %6 = load i32, i32* %4
 %7 = shl i32 %5, %6
 %8 = trunc i32 %7 to i8
 ret i8 %8
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @bar ()
 %3 = icmp ne i32 %2, 0
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 ret i32 0
}
