%struct.event = type { %struct.anon }
%struct.anon = type { i32 }
%union.anon = type { i32, [4 x i8] }

declare void @llvm.memcpy.p0.p0.i64(i8*, i8*, i64, i1)
declare void @llvm.memset.p0.i64(i8*, i8, i64, i1)

define void @frob_entry (i8* %0) {
 %2 = alloca i8*
 %3 = alloca %struct.event
 store i8* %0, i8** %2
 %4 = load i8*, i8** %2
 call void @memcpy (i8* %3, i8* %4, i64 4, i1 0)
 %5 = getelementptr %struct.event, i8* %3, i32 0, i32 0
 %6 = getelementptr %struct.anon, i8* %5, i32 0, i32 0
 %7 = load i32, i32* %6
 %8 = icmp ult i32 %7, 64
 br i1 %8, label %9, label %13
9:
 %10 = getelementptr %struct.event, i8* %3, i32 0, i32 0
 %11 = getelementptr %struct.anon, i8* %10, i32 0, i32 0
 store i32 -1, i32* %11
 %12 = load i8*, i8** %2
 call void @memcpy (i8* %12, i8* %3, i64 4, i1 0)
 br label %13
13:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca %union.anon
 store i32 0, i32* %1
 call void @memset (i8* %2, i8 0, i64 8, i1 0)
 %3 = getelementptr [5 x i8], i8* %2, i64 0, i64 1
 call void @frob_entry (i8* %3)
 ret i32 0
}
