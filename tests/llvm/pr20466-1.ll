declare void @abort()
declare void @exit(i32)

define i32 @f (i8* %0, i8* %1, i8* %2, i8* %3, i8* %4) {
 %6 = alloca i8*
 %7 = alloca i8*
 %8 = alloca i8*
 %9 = alloca i8*
 %10 = alloca i8*
 store i8* %0, i8** %6
 store i8* %1, i8** %7
 store i8* %2, i8** %8
 store i8* %3, i8** %9
 store i8* %4, i8** %10
 %11 = load i8*, i8** %7
 %12 = load i32, i32* %11
 %13 = load i8*, i8** %6
 %14 = load i8*, i8** %13
 store i32 %12, i32* %14
 %15 = load i8*, i8** %8
 %16 = load i8*, i8** %6
 store i8* %15, i8** %16
 %17 = load i8*, i8** %10
 %18 = load i8*, i8** %17
 %19 = load i8*, i8** %9
 store i8* %18, i8** %19
 %20 = load i8*, i8** %6
 %21 = load i8*, i8** %20
 store i32 99, i32* %21
 ret i32 3
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i32
 %7 = alloca i8*
 %8 = alloca i8*
 %9 = alloca i8*
 store i32 0, i32* %1
 store i32 42, i32* %2
 store i32 66, i32* %3
 store i32 1, i32* %4
 store i32 -1, i32* %5
 store i32 55, i32* %6
 store i8* %2, i8** %7
 store i8* %5, i8** %8
 store i8* %6, i8** %9
 %10 = call i32 @f (i8* %7, i8* %3, i8* %4, i8* %8, i8* %9)
 %11 = load i32, i32* %2
 %12 = icmp ne i32 %11, 66
 br i1 %12, label %29, label %13
13:
 %14 = load i8*, i8** %7
 %15 = icmp ne i8* %14, %4
 br i1 %15, label %29, label %16
16:
 %17 = load i32, i32* %4
 %18 = icmp ne i32 %17, 99
 br i1 %18, label %29, label %19
19:
 %20 = load i32, i32* %5
 %21 = icmp ne i32 %20, -1
 br i1 %21, label %29, label %22
22:
 %23 = load i8*, i8** %8
 %24 = load i8*, i8** %9
 %25 = icmp ne i8* %23, %24
 br i1 %25, label %29, label %26
26:
 %27 = load i32, i32* %6
 %28 = icmp ne i32 %27, 55
 br i1 %28, label %29, label %30
29:
 call void @abort ()
 unreachable
30:
 call void @exit (i32 0)
 unreachable
}
