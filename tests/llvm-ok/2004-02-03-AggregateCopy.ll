%struct.agg = type { i32 }

@.str = global [12 x i8] c"%d, %d, %d\0A\00"

declare void @llvm.memcpy.p0.p0.i64(i8*, i8*, i64, i1)
declare i32 @printf(i8*, ...)

define i32 @main () {
 %1 = alloca i32
 %2 = alloca %struct.agg
 %3 = alloca %struct.agg
 %4 = alloca %struct.agg
 store i32 0, i32* %1
 %5 = getelementptr %struct.agg, i8* %2, i32 0, i32 0
 store i32 123, i32* %5
 call void @memcpy (i8* %4, i8* %2, i64 4, i1 0)
 call void @memcpy (i8* %3, i8* %4, i64 4, i1 0)
 %6 = getelementptr %struct.agg, i8* %2, i32 0, i32 0
 %7 = load i32, i32* %6
 %8 = getelementptr %struct.agg, i8* %3, i32 0, i32 0
 %9 = load i32, i32* %8
 %10 = getelementptr %struct.agg, i8* %4, i32 0, i32 0
 %11 = load i32, i32* %10
 %12 = call i32 (i8*, ...) @printf (i8* @.str, i32 %7, i32 %9, i32 %11)
 ret i32 0
}
