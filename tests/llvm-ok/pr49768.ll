%struct.anon = type { i8, [3 x i8] }

@main.s = global %struct.anon {i8 2, [3 x i8] 0}

declare void @abort()

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = load i8, i8* @main.s
 %3 = lshr i8 %2, 1
 %4 = and i8 %3, 1
 %5 = zext i8 %4 to i32
 %6 = icmp ne i32 %5, 1
 br i1 %6, label %7, label %8
7:
 call void @abort ()
 unreachable
8:
 ret i32 0
}
