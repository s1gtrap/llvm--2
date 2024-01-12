declare void @abort()

define i32 @f (i32 %0, i32 %1, i32 %2) {
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i32
 %7 = alloca i8*
 store i32 %0, i32* %4
 store i32 %1, i32* %5
 store i32 %2, i32* %6
 %8 = load i32, i32* %4
 %9 = icmp ne i32 %8, 0
 br i1 %9, label %10, label %11
10:
 store i8* %5, i8** %7
 br label %12
11:
 store i8* %6, i8** %7
 br label %12
12:
 store i32 0, i32* %5
 %13 = load i8*, i8** %7
 %14 = load i32, i32* %13
 ret i32 %14
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @f (i32 1, i32 1, i32 2)
 %3 = icmp ne i32 %2, 0
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 ret i32 0
}
