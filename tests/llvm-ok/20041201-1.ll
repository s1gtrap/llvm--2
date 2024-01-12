%struct.Scc2 = type { { i8, i8 }, { i8, i8 } }

@s = global %struct.Scc2 {{ i8, i8 } {i8 1, i8 2}, { i8, i8 } {i8 3, i8 4}}

define i32 @checkScc2 (i32 %0) {
 %2 = alloca %struct.Scc2
 store i32 %0, i32* %2
 %3 = getelementptr %struct.Scc2, i8* %2, i32 0, i32 0
 %4 = getelementptr { i8, i8 }, i8* %3, i32 0, i32 0
 %5 = load i8, i8* %4
 %6 = getelementptr { i8, i8 }, i8* %3, i32 0, i32 1
 %7 = load i8, i8* %6
 %8 = sext i8 %5 to i32
 %9 = sext i8 %7 to i32
 %10 = icmp ne i32 %8, 1
 %11 = icmp ne i32 %9, 2
 %12 = or i1 %10, %11
 br i1 %12, label %24, label %13
13:
 %14 = getelementptr %struct.Scc2, i8* %2, i32 0, i32 1
 %15 = getelementptr { i8, i8 }, i8* %14, i32 0, i32 0
 %16 = load i8, i8* %15
 %17 = getelementptr { i8, i8 }, i8* %14, i32 0, i32 1
 %18 = load i8, i8* %17
 %19 = sext i8 %16 to i32
 %20 = sext i8 %18 to i32
 %21 = icmp ne i32 %19, 3
 %22 = icmp ne i32 %20, 4
 %23 = or i1 %21, %22
 br label %24
24:
 %25 = phi i1 [1, %1], [%23, %13]
 %26 = zext i1 %25 to i32
 ret i32 %26
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = load i32, i32* @s
 %3 = call i32 @checkScc2 (i32 %2)
 ret i32 %3
}
