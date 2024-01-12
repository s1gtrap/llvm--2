declare void @abort()
declare void @exit(i32)

define i32 @add512 (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i8*
 %5 = alloca i32
 store i32 %0, i32* %3
 store i8* %1, i8** %4
 %6 = load i32, i32* %3
 %7 = add i32 %6, 512
 store i32 %7, i32* %5
 %8 = load i32, i32* %5
 %9 = icmp ne i32 %8, 0
 br i1 %9, label %10, label %13
10:
 %11 = load i32, i32* %3
 %12 = load i8*, i8** %4
 store i32 %11, i32* %12
 br label %13
13:
 %14 = load i32, i32* %5
 ret i32 %14
}

define i32 @add513 (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i8*
 %5 = alloca i32
 store i32 %0, i32* %3
 store i8* %1, i8** %4
 %6 = load i32, i32* %3
 %7 = add i32 %6, 513
 store i32 %7, i32* %5
 %8 = load i32, i32* %5
 %9 = icmp eq i32 %8, 0
 br i1 %9, label %10, label %13
10:
 %11 = load i32, i32* %3
 %12 = load i8*, i8** %4
 store i32 %11, i32* %12
 br label %13
13:
 %14 = load i32, i32* %5
 ret i32 %14
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 %3 = alloca i32
 store i32 0, i32* %1
 store i32 -1, i32* %2
 store i32 -1, i32* %3
 %4 = call i32 @add512 (i32 -512, i8* %2)
 %5 = icmp ne i32 %4, 0
 br i1 %5, label %15, label %6
6:
 %7 = load i32, i32* %2
 %8 = icmp ne i32 %7, -1
 br i1 %8, label %15, label %9
9:
 %10 = call i32 @add513 (i32 -513, i8* %3)
 %11 = icmp ne i32 %10, 0
 br i1 %11, label %15, label %12
12:
 %13 = load i32, i32* %3
 %14 = icmp ne i32 %13, -513
 br i1 %14, label %15, label %16
15:
 call void @abort ()
 unreachable
16:
 call void @exit (i32 0)
 unreachable
}
