%struct.A = type { i32 }

declare void @abort()

define i32 @main () {
 %1 = alloca i32
 %2 = alloca %struct.A
 store i32 0, i32* %1
 %3 = getelementptr %struct.A, i8* %2, i32 0, i32 0
 store i32 0, i32* %3
 call void @foo (i8* %2)
 %4 = getelementptr %struct.A, i8* %2, i32 0, i32 0
 %5 = load i32, i32* %4
 %6 = icmp ne i32 %5, 1
 br i1 %6, label %7, label %8
7:
 call void @abort ()
 unreachable
8:
 ret i32 0
}

define void @foo (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 %3 = load i8*, i8** %2
 %4 = getelementptr %struct.A, i8* %3, i32 0, i32 0
 store i32 1, i32* %4
 ret void
}
