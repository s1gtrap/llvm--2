declare void @abort()
declare void @exit(i32)

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 %3 = alloca i8
 %4 = alloca i8
 store i32 0, i32* %1
 store i32 127, i32* %2
 %5 = load i32, i32* %2
 %6 = shl i32 %5, 1
 %7 = trunc i32 %6 to i8
 %8 = sext i8 %7 to i32
 %9 = sdiv i32 %8, 2
 %10 = trunc i32 %9 to i8
 store i8 %10, i8* %3
 %11 = load i8, i8* %3
 %12 = sext i8 %11 to i32
 %13 = icmp ne i32 %12, -1
 br i1 %13, label %14, label %15
14:
 call void @abort ()
 unreachable
15:
 %16 = load i32, i32* %2
 %17 = mul i32 %16, 2
 %18 = trunc i32 %17 to i8
 %19 = sext i8 %18 to i32
 %20 = sdiv i32 %19, 2
 %21 = trunc i32 %20 to i8
 store i8 %21, i8* %3
 %22 = load i8, i8* %3
 %23 = sext i8 %22 to i32
 %24 = icmp ne i32 %23, -1
 br i1 %24, label %25, label %26
25:
 call void @abort ()
 unreachable
26:
 store i32 255, i32* %2
 %27 = load i32, i32* %2
 %28 = shl i32 %27, 1
 %29 = trunc i32 %28 to i8
 %30 = zext i8 %29 to i32
 %31 = sdiv i32 %30, 2
 %32 = trunc i32 %31 to i8
 store i8 %32, i8* %4
 %33 = load i8, i8* %4
 %34 = zext i8 %33 to i32
 %35 = icmp ne i32 %34, 127
 br i1 %35, label %36, label %37
36:
 call void @abort ()
 unreachable
37:
 %38 = load i32, i32* %2
 %39 = mul i32 %38, 2
 %40 = trunc i32 %39 to i8
 %41 = zext i8 %40 to i32
 %42 = sdiv i32 %41, 2
 %43 = trunc i32 %42 to i8
 store i8 %43, i8* %4
 %44 = load i8, i8* %4
 %45 = zext i8 %44 to i32
 %46 = icmp ne i32 %45, 127
 br i1 %46, label %47, label %48
47:
 call void @abort ()
 unreachable
48:
 call void @exit (i32 0)
 unreachable
}
