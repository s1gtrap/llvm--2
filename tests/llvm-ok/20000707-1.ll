%struct.baz = type { i32, i32, i32 }

@__const.main.x = global %struct.baz {i32 3, i32 4, i32 5}

declare void @abort()
declare void @memcpy(i8*, i8*, i64, i1)
declare void @exit(i32)

define void @foo (i32 %0, i32 %1, i32 %2) {
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i32
 store i32 %0, i32* %4
 store i32 %1, i32* %5
 store i32 %2, i32* %6
 %7 = load i32, i32* %4
 %8 = icmp ne i32 %7, 4
 br i1 %8, label %9, label %10
9:
 call void @abort ()
 unreachable
10:
 ret void
}

define void @bar (i64 %0, i32 %1, i32 %2, i32 %3) {
 %5 = alloca %struct.baz
 %6 = alloca { i64, i32 }
 %7 = alloca i32
 %8 = alloca i32
 %9 = getelementptr { i64, i32 }, i8* %6, i32 0, i32 0
 store i64 %0, i64* %9
 %10 = getelementptr { i64, i32 }, i8* %6, i32 0, i32 1
 store i32 %1, i32* %10
 call void @memcpy (i8* %5, i8* %6, i64 12, i1 0)
 store i32 %2, i32* %7
 store i32 %3, i32* %8
 %11 = getelementptr %struct.baz, i8* %5, i32 0, i32 1
 %12 = load i32, i32* %11
 %13 = load i32, i32* %7
 %14 = load i32, i32* %8
 call void @foo (i32 %12, i32 %13, i32 %14)
 ret void
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca %struct.baz
 %3 = alloca { i64, i32 }
 store i32 0, i32* %1
 call void @memcpy (i8* %2, i8* @__const.main.x, i64 12, i1 0)
 call void @memcpy (i8* %3, i8* %2, i64 12, i1 0)
 %4 = getelementptr { i64, i32 }, i8* %3, i32 0, i32 0
 %5 = load i64, i64* %4
 %6 = getelementptr { i64, i32 }, i8* %3, i32 0, i32 1
 %7 = load i32, i32* %6
 call void @bar (i64 %5, i32 %7, i32 1, i32 2)
 call void @exit (i32 0)
 unreachable
}
