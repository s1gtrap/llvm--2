%union.U = type { i32 }

@__const.main.u = global { i16, [2 x i8] } {i16 -1, [2 x i8] 0}

declare void @memcpy(i8*, i8*, i64, i1)
declare void @abort()

define i32 @f (i32 %0, i32 %1, i32 %2, i32 %3, i32 %4) {
 %6 = alloca %union.U
 %7 = alloca i32
 %8 = alloca i32
 %9 = alloca i32
 %10 = alloca i32
 %11 = getelementptr %union.U, i8* %6, i32 0, i32 0
 store i32 %4, i32* %11
 store i32 %0, i32* %7
 store i32 %1, i32* %8
 store i32 %2, i32* %9
 store i32 %3, i32* %10
 %12 = load i16, i16* %6
 %13 = sext i16 %12 to i32
 %14 = icmp sle i32 %13, 0
 %15 = zext i1 %14 to i32
 %16 = load i16, i16* %6
 %17 = zext i16 %16 to i32
 %18 = add i32 %15, %17
 ret i32 %18
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca %union.U
 store i32 0, i32* %1
 call void @memcpy (i8* %2, i8* @__const.main.u, i64 4, i1 0)
 %3 = getelementptr %union.U, i8* %2, i32 0, i32 0
 %4 = load i32, i32* %3
 %5 = call i32 @f (i32 0, i32 0, i32 0, i32 0, i32 %4)
 %6 = icmp ne i32 %5, 65536
 br i1 %6, label %7, label %8
7:
 call void @abort ()
 unreachable
8:
 ret i32 0
}
