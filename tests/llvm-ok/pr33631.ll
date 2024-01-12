%struct.anon = type { i32, %union.pthread_mutex_t }
%union.pthread_mutex_t = type { i32 }

declare void @llvm.memset.p0.i64(i8*, i8, i64, i1)
declare void @abort()

define i32 @main () {
 %1 = alloca i32
 %2 = alloca %struct.anon
 store i32 0, i32* %1
 call void @memset (i8* %2, i8 0, i64 8, i1 0)
 %3 = getelementptr %struct.anon, i8* %2, i32 0, i32 0
 %4 = load i32, i32* %3
 %5 = icmp ne i32 %4, 0
 br i1 %5, label %6, label %7
6:
 call void @abort ()
 unreachable
7:
 ret i32 0
}
