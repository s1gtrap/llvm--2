define void @g (i64 %0, i32 %1, i32 %2, i8* %3) {
 %5 = alloca i64
 %6 = alloca i32
 %7 = alloca i32
 %8 = alloca i8*
 %9 = alloca i32
 store i64 %0, i64* %5
 store i32 %1, i32* %6
 store i32 %2, i32* %7
 store i8* %3, i8** %8
 %10 = load i64, i64* %5
 %11 = load i32, i32* %6
 %12 = zext i32 %11 to i64
 %13 = lshr i64 %10, %12
 %14 = and i64 %13, 4294967295
 %15 = load i32, i32* %7
 %16 = and i32 %15, 31
 %17 = zext i32 %16 to i64
 %18 = shl i64 %14, %17
 %19 = trunc i64 %18 to i32
 store i32 %19, i32* %9
 %20 = load i32, i32* %9
 %21 = zext i32 %20 to i64
 %22 = and i64 %21, 4294967295
 %23 = load i32, i32* %7
 %24 = zext i32 %23 to i64
 %25 = shl i64 %22, %24
 %26 = load i8*, i8** %8
 %27 = load i64, i64* %26
 %28 = or i64 %27, %25
 store i64 %28, i64* %26
 ret void
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i64
 store i32 0, i32* %1
 store i64 0, i64* %2
 call void @g (i64 -2401053092593056409, i32 0, i32 0, i8* %2)
 %3 = load i64, i64* %2
 %4 = icmp eq i64 %3, 19088743
 %5 = zext i1 %4 to i64
 %6 = select i1 %4, i32 0, i32 1
 ret i32 %6
}
