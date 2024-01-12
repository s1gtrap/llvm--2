declare void @abort()

define i32 @foo (i8 %0) {
 %2 = alloca i8
 %3 = alloca i32
 store i8 %0, i8* %2
 store i32 0, i32* %3
 %4 = load i8, i8* %2
 %5 = sext i8 %4 to i32
 switch i32 %5, label %41 [
    i32 0, label %6
    i32 1, label %7
    i32 2, label %8
    i32 3, label %9
    i32 4, label %10
    i32 5, label %11
    i32 6, label %12
    i32 7, label %13
    i32 8, label %14
    i32 9, label %15
    i32 10, label %16
    i32 11, label %17
    i32 12, label %18
    i32 13, label %19
    i32 14, label %20
    i32 15, label %21
    i32 16, label %22
    i32 17, label %23
    i32 18, label %24
    i32 19, label %25
    i32 20, label %26
    i32 21, label %27
    i32 22, label %28
    i32 23, label %29
    i32 24, label %30
    i32 25, label %31
    i32 26, label %32
    i32 27, label %33
    i32 28, label %34
    i32 29, label %35
    i32 30, label %36
    i32 31, label %37
    i32 32, label %38
    i32 98, label %39
    i32 -62, label %40
  ]
6:
 store i32 1, i32* %3
 br label %41
7:
 store i32 7, i32* %3
 br label %41
8:
 store i32 2, i32* %3
 br label %41
9:
 store i32 19, i32* %3
 br label %41
10:
 store i32 5, i32* %3
 br label %41
11:
 store i32 17, i32* %3
 br label %41
12:
 store i32 31, i32* %3
 br label %41
13:
 store i32 8, i32* %3
 br label %41
14:
 store i32 28, i32* %3
 br label %41
15:
 store i32 16, i32* %3
 br label %41
16:
 store i32 31, i32* %3
 br label %41
17:
 store i32 12, i32* %3
 br label %41
18:
 store i32 15, i32* %3
 br label %41
19:
 store i32 111, i32* %3
 br label %41
20:
 store i32 17, i32* %3
 br label %41
21:
 store i32 10, i32* %3
 br label %41
22:
 store i32 31, i32* %3
 br label %41
23:
 store i32 7, i32* %3
 br label %41
24:
 store i32 2, i32* %3
 br label %41
25:
 store i32 19, i32* %3
 br label %41
26:
 store i32 5, i32* %3
 br label %41
27:
 store i32 107, i32* %3
 br label %41
28:
 store i32 31, i32* %3
 br label %41
29:
 store i32 8, i32* %3
 br label %41
30:
 store i32 28, i32* %3
 br label %41
31:
 store i32 106, i32* %3
 br label %41
32:
 store i32 31, i32* %3
 br label %41
33:
 store i32 102, i32* %3
 br label %41
34:
 store i32 105, i32* %3
 br label %41
35:
 store i32 111, i32* %3
 br label %41
36:
 store i32 17, i32* %3
 br label %41
37:
 store i32 10, i32* %3
 br label %41
38:
 store i32 31, i32* %3
 br label %41
39:
 store i32 18, i32* %3
 br label %41
40:
 store i32 19, i32* %3
 br label %41
41:
 %42 = load i32, i32* %3
 ret i32 %42
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @foo (i8 98)
 %3 = icmp ne i32 %2, 18
 br i1 %3, label %10, label %4
4:
 %5 = call i32 @foo (i8 97)
 %6 = icmp ne i32 %5, 0
 br i1 %6, label %10, label %7
7:
 %8 = call i32 @foo (i8 99)
 %9 = icmp ne i32 %8, 0
 br i1 %9, label %10, label %11
10:
 call void @abort ()
 unreachable
11:
 %12 = call i32 @foo (i8 -62)
 %13 = icmp ne i32 %12, 19
 br i1 %13, label %20, label %14
14:
 %15 = call i32 @foo (i8 -63)
 %16 = icmp ne i32 %15, 0
 br i1 %16, label %20, label %17
17:
 %18 = call i32 @foo (i8 -61)
 %19 = icmp ne i32 %18, 0
 br i1 %19, label %20, label %21
20:
 call void @abort ()
 unreachable
21:
 %22 = call i32 @foo (i8 28)
 %23 = icmp ne i32 %22, 105
 br i1 %23, label %30, label %24
24:
 %25 = call i32 @foo (i8 27)
 %26 = icmp ne i32 %25, 102
 br i1 %26, label %30, label %27
27:
 %28 = call i32 @foo (i8 29)
 %29 = icmp ne i32 %28, 111
 br i1 %29, label %30, label %31
30:
 call void @abort ()
 unreachable
31:
 ret i32 0
}
