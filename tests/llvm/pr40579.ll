declare void @abort()

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 %3 = alloca i32
 %4 = alloca i8*
 store i32 0, i32* %1
 store i32 -2147483644, i32* %2
 store i32 0, i32* %3
 br label %5
5:
 %6 = load i32, i32* %3
 %7 = icmp slt i32 %6, 4
 br i1 %7, label %8, label %18
8:
 %9 = load i32, i32* %2
 %10 = add i32 %9, -1
 store i32 %10, i32* %2
 %11 = load i32, i32* %2
 %12 = call i8* @itos (i32 %11)
 store i8* %12, i8** %4
 %13 = load i32, i32* %3
 %14 = load i8*, i8** %4
 call void @foo (i32 %13, i8* %14)
 br label %15
15:
 %16 = load i32, i32* %3
 %17 = add i32 %16, 1
 store i32 %17, i32* %3
 br label %5
18:
 ret i32 0
}

define i8* @itos (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 ret i8* null
}

define void @foo (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i8*
 store i32 %0, i32* %3
 store i8* %1, i8** %4
 %5 = load i32, i32* %3
 %6 = icmp sge i32 %5, 4
 br i1 %6, label %7, label %8
7:
 call void @abort ()
 unreachable
8:
 ret void
}
