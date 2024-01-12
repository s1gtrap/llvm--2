%struct.a = type { [100 x i8] }

declare void @abort()

define i32 @foo (i8* %0) {
 %2 = alloca i32
 %3 = alloca i8*
 store i8* %0, i8** %3
 %4 = load i8*, i8** %3
 %5 = getelementptr %struct.a, i8* %4, i32 0, i32 0
 %6 = icmp ne i8* %5, null
 br i1 %6, label %7, label %8
7:
 store i32 1, i32* %2
 br label %9
8:
 store i32 0, i32* %2
 br label %9
9:
 %10 = load i32, i32* %2
 ret i32 %10
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @foo (i8* null)
 %3 = icmp ne i32 %2, 0
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 ret i32 0
}
