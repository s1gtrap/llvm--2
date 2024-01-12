declare void @abort()

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i64
 %3 = alloca i32
 store i32 0, i32* %1
 call void @set (i8* %2)
 %4 = load i64, i64* %2
 %5 = trunc i64 %4 to i32
 store i32 %5, i32* %3
 %6 = load i32, i32* %3
 %7 = shl i32 2, %6
 %8 = zext i32 %7 to i64
 store i64 %8, i64* %2
 %9 = load i64, i64* %2
 %10 = icmp ne i64 %9, 0
 br i1 %10, label %11, label %12
11:
 call void @abort ()
 unreachable
12:
 ret i32 0
}

define void @set (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 %3 = load i8*, i8** %2
 store i64 31, i64* %3
 ret void
}
