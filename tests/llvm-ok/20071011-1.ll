declare void @abort()

define void @foo (i8* %0) {
 %2 = alloca i8*
 %3 = alloca i32
 %4 = alloca i32
 store i8* %0, i8** %2
 %5 = load i8*, i8** %2
 %6 = load i32, i32* %5
 store i32 %6, i32* %3
 %7 = load i8*, i8** %2
 store i32 0, i32* %7
 %8 = load i8*, i8** %2
 %9 = load i32, i32* %8
 store i32 %9, i32* %4
 %10 = load i32, i32* %3
 %11 = load i32, i32* %4
 %12 = icmp ne i32 %10, %11
 br i1 %12, label %13, label %14
13:
 ret void
14:
 call void @abort ()
 unreachable
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 store i32 0, i32* %1
 store i32 1, i32* %2
 call void @foo (i8* %2)
 ret i32 0
}
