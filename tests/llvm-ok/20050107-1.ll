%struct.S = type { i8, i8 }

declare void @abort()

define void @foo (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 %3 = load i8*, i8** %2
 %4 = getelementptr %struct.S, i8* %3, i32 0, i32 0
 %5 = load i8, i8* %4
 %6 = zext i8 %5 to i32
 %7 = icmp ne i32 %6, 1
 br i1 %7, label %14, label %8
8:
 %9 = load i8*, i8** %2
 %10 = getelementptr %struct.S, i8* %9, i32 0, i32 1
 %11 = load i8, i8* %10
 %12 = zext i8 %11 to i32
 %13 = icmp ne i32 %12, 2
 br i1 %13, label %14, label %15
14:
 call void @abort ()
 unreachable
15:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca %struct.S
 store i32 0, i32* %1
 %3 = getelementptr %struct.S, i8* %2, i32 0, i32 0
 store i8 1, i8* %3
 %4 = getelementptr %struct.S, i8* %2, i32 0, i32 1
 store i8 2, i8* %4
 call void @foo (i8* %2)
 ret i32 0
}
