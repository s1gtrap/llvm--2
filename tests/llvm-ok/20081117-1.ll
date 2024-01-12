%struct.s = type { i64 }

@s = global { i8, i8, i8, i8, i8, i8, i8, i8 } {i8 1, i8 0, i8 33, i8 67, i8 101, i8 -121, i8 2, i8 0}

declare void @abort()

define i32 @f (i64 %0, i32 %1) {
 %3 = alloca %struct.s
 %4 = alloca i32
 %5 = getelementptr %struct.s, i8* %3, i32 0, i32 0
 store i64 %0, i64* %5
 store i32 %1, i32* %4
 %6 = load i64, i64* %3
 %7 = lshr i64 %6, 16
 %8 = and i64 %7, 4294967295
 %9 = trunc i64 %8 to i32
 %10 = load i32, i32* %4
 %11 = icmp eq i32 %9, %10
 %12 = zext i1 %11 to i32
 ret i32 %12
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = load i64, i64* @s
 %3 = call i32 @f (i64 %2, i32 -2023406815)
 %4 = icmp ne i32 %3, 0
 br i1 %4, label %6, label %5
5:
 call void @abort ()
 unreachable
6:
 ret i32 0
}
