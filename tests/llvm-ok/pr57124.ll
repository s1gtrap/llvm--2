declare void @abort()
declare void @exit(i32)

define void @foo (i8* %0, i8* %1) {
 %3 = alloca i8*
 %4 = alloca i8*
 %5 = alloca i16
 %6 = alloca i16
 %7 = alloca i32
 %8 = alloca i32
 %9 = alloca i32
 %10 = alloca i32
 %11 = alloca i32
 store i8* %0, i8** %3
 store i8* %1, i8** %4
 %12 = load i8*, i8** %3
 %13 = load i16, i16* %12
 store i16 %13, i16* %5
 %14 = load i16, i16* %5
 %15 = zext i16 %14 to i32
 store i32 %15, i32* %7
 %16 = load i32, i32* %7
 %17 = mul i32 %16, 65536
 store i32 %17, i32* %8
 %18 = load i8*, i8** %4
 %19 = load i16, i16* %18
 store i16 %19, i16* %6
 %20 = load i16, i16* %6
 %21 = zext i16 %20 to i32
 store i32 %21, i32* %9
 %22 = load i32, i32* %8
 %23 = load i16, i16* %6
 %24 = zext i16 %23 to i32
 %25 = add i32 %22, %24
 store i32 %25, i32* %10
 %26 = load i32, i32* %10
 store i32 %26, i32* %11
 %27 = load i32, i32* %11
 %28 = icmp ule i32 %27, 268435455
 br i1 %28, label %29, label %30
29:
 call void @abort ()
 unreachable
30:
 call void @exit (i32 0)
 unreachable
}

define i32 @main () {
 %1 = alloca i16
 %2 = alloca i16
 store i16 -5, i16* %1
 store i16 -10, i16* %2
 call void @foo (i8* %1, i8* %2)
 ret i32 0
}
