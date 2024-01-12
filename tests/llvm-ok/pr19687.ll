%union.U = type { [4 x i32] }

@__const.main.t = global { i32, [12 x i8] } {i32 0, [12 x i8] 0}

declare void @llvm.memcpy.p0.p0.i64(i8*, i8*, i64, i1)
declare void @abort()

define i32 @main () {
 %1 = alloca i32
 %2 = alloca %union.U
 %3 = alloca i32
 store i32 0, i32* %1
 call void @memcpy (i8* %2, i8* @__const.main.t, i64 16, i1 0)
 store i32 0, i32* %3
 br label %4
4:
 %5 = load i32, i32* %3
 %6 = icmp slt i32 %5, 4
 br i1 %6, label %7, label %18
7:
 %8 = load i32, i32* %3
 %9 = sext i32 %8 to i64
 %10 = getelementptr [4 x i32], i8* %2, i64 0, i64 %9
 %11 = load i32, i32* %10
 %12 = icmp ne i32 %11, 0
 br i1 %12, label %13, label %14
13:
 call void @abort ()
 unreachable
14:
 br label %15
15:
 %16 = load i32, i32* %3
 %17 = add i32 %16, 1
 store i32 %17, i32* %3
 br label %4
18:
 ret i32 0
}
