declare void @abort()

define i32 @foo (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 store i32 %0, i32* %3
 %4 = load i32, i32* %3
 switch i32 %4, label %6 [
    i32 4, label %5
    i32 6, label %5
    i32 9, label %5
    i32 11, label %5
  ]
5:
 store i32 30, i32* %2
 br label %7
6:
 store i32 31, i32* %2
 br label %7
7:
 %8 = load i32, i32* %2
 ret i32 %8
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 %3 = alloca i32
 store i32 0, i32* %1
 store i32 -1, i32* %2
 br label %4
4:
 %5 = load i32, i32* %2
 %6 = icmp slt i32 %5, 66
 br i1 %6, label %7, label %53
7:
 %8 = load i32, i32* %2
 %9 = call i32 @foo (i32 %8)
 store i32 %9, i32* %3
 %10 = load i32, i32* %2
 %11 = icmp eq i32 %10, 4
 br i1 %11, label %12, label %17
12:
 %13 = load i32, i32* %3
 %14 = icmp ne i32 %13, 30
 br i1 %14, label %15, label %16
15:
 call void @abort ()
 unreachable
16:
 br label %49
17:
 %18 = load i32, i32* %2
 %19 = icmp eq i32 %18, 6
 br i1 %19, label %20, label %25
20:
 %21 = load i32, i32* %3
 %22 = icmp ne i32 %21, 30
 br i1 %22, label %23, label %24
23:
 call void @abort ()
 unreachable
24:
 br label %48
25:
 %26 = load i32, i32* %2
 %27 = icmp eq i32 %26, 9
 br i1 %27, label %28, label %33
28:
 %29 = load i32, i32* %3
 %30 = icmp ne i32 %29, 30
 br i1 %30, label %31, label %32
31:
 call void @abort ()
 unreachable
32:
 br label %47
33:
 %34 = load i32, i32* %2
 %35 = icmp eq i32 %34, 11
 br i1 %35, label %36, label %41
36:
 %37 = load i32, i32* %3
 %38 = icmp ne i32 %37, 30
 br i1 %38, label %39, label %40
39:
 call void @abort ()
 unreachable
40:
 br label %46
41:
 %42 = load i32, i32* %3
 %43 = icmp ne i32 %42, 31
 br i1 %43, label %44, label %45
44:
 call void @abort ()
 unreachable
45:
 br label %46
46:
 br label %47
47:
 br label %48
48:
 br label %49
49:
 br label %50
50:
 %51 = load i32, i32* %2
 %52 = add i32 %51, 1
 store i32 %52, i32* %2
 br label %4
53:
 ret i32 0
}
