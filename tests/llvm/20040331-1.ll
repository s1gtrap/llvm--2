%struct.anon = type { i32 }

declare void @memset(i8*, i8, i64, i1)
declare void @abort()
declare void @exit(i32)

define i32 @main () {
 %1 = alloca i32
 %2 = alloca %struct.anon
 store i32 0, i32* %1
 call void @memset (i8* %2, i8 0, i64 4, i1 0)
 br label %3
3:
 %4 = load i32, i32* %2
 %5 = shl i32 %4, 1
 %6 = ashr i32 %5, 1
 %7 = add i32 %6, -1
 %8 = load i32, i32* %2
 %9 = and i32 %7, 2147483647
 %10 = and i32 %8, -2147483648
 %11 = or i32 %10, %9
 store i32 %11, i32* %2
 %12 = shl i32 %9, 1
 %13 = ashr i32 %12, 1
 %14 = icmp ne i32 %6, 0
 br i1 %14, label %15, label %16
15:
 call void @abort ()
 unreachable
16:
 call void @exit (i32 0)
 unreachable
}
