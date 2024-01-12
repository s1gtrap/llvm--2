declare void @abort()
declare void @exit(i32)

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 %3 = alloca i32
 store i32 0, i32* %1
 store i32 924, i32* %2
 %4 = load i32, i32* %2
 %5 = mul i32 %4, 2
 %6 = add i32 %5, 4
 %7 = sub i32 %6, 8
 %8 = udiv i32 %7, 2
 store i32 %8, i32* %3
 %9 = load i32, i32* %3
 %10 = icmp ne i32 %9, 922
 br i1 %10, label %11, label %12
11:
 call void @abort ()
 unreachable
12:
 %13 = load i32, i32* %2
 %14 = mul i32 %13, 2
 %15 = sub i32 %14, 4
 %16 = add i32 %15, 2
 %17 = udiv i32 %16, 2
 store i32 %17, i32* %3
 %18 = load i32, i32* %3
 %19 = icmp ne i32 %18, 923
 br i1 %19, label %20, label %21
20:
 call void @abort ()
 unreachable
21:
 %22 = load i32, i32* %2
 %23 = add i32 %22, 2
 %24 = mul i32 %23, 2
 %25 = sub i32 %24, 8
 %26 = sub i32 %25, 4
 %27 = udiv i32 %26, 2
 store i32 %27, i32* %3
 %28 = load i32, i32* %3
 %29 = icmp ne i32 %28, 920
 br i1 %29, label %30, label %31
30:
 call void @abort ()
 unreachable
31:
 %32 = load i32, i32* %2
 %33 = add i32 %32, 2
 %34 = mul i32 %33, 2
 %35 = sub i32 %34, 12
 %36 = udiv i32 %35, 2
 store i32 %36, i32* %3
 %37 = load i32, i32* %3
 %38 = icmp ne i32 %37, 920
 br i1 %38, label %39, label %40
39:
 call void @abort ()
 unreachable
40:
 %41 = load i32, i32* %2
 %42 = mul i32 %41, 4
 %43 = add i32 %42, 2
 %44 = sub i32 %43, 4
 %45 = udiv i32 %44, 2
 store i32 %45, i32* %3
 %46 = load i32, i32* %3
 %47 = icmp ne i32 %46, 1847
 br i1 %47, label %48, label %49
48:
 call void @abort ()
 unreachable
49:
 call void @exit (i32 0)
 unreachable
}
