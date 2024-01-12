@.str = global [4 x i8] c"int\00"
@.str.1 = global [5 x i8] c"char\00"
@.str.2 = global [6 x i8] c"short\00"
@.str.3 = global [5 x i8] c"long\00"
@.str.4 = global [14 x i8] c"unsigned char\00"
@.str.5 = global [12 x i8] c"signed char\00"
@.str.6 = global [15 x i8] c"unsigned short\00"
@.str.7 = global [13 x i8] c"unsigned int\00"
@.str.8 = global [9 x i8] c"unsigned\00"
@.str.9 = global [14 x i8] c"unsigned long\00"
@.str.10 = global [5 x i8] c"void\00"
@.str.11 = global [6 x i8] c"float\00"
@.str.12 = global [7 x i8] c"double\00"
@.str.13 = global [12 x i8] c"long double\00"
@.str.14 = global [8 x i8] c"integer\00"
@.str.15 = global [8 x i8] c"boolean\00"
@.str.16 = global [11 x i8] c"short real\00"
@.str.17 = global [5 x i8] c"real\00"
@.str.18 = global [10 x i8] c"stringptr\00"
@.str.19 = global [10 x i8] c"character\00"
@.str.20 = global [10 x i8] c"logical*1\00"
@.str.21 = global [10 x i8] c"logical*2\00"
@.str.22 = global [10 x i8] c"logical*4\00"
@.str.23 = global [8 x i8] c"logical\00"
@.str.24 = global [8 x i8] c"complex\00"
@.str.25 = global [15 x i8] c"double complex\00"
@.str.26 = global [10 x i8] c"integer*1\00"
@.str.27 = global [10 x i8] c"integer*2\00"
@.str.28 = global [10 x i8] c"integer*4\00"
@.str.29 = global [6 x i8] c"wchar\00"
@.str.30 = global [10 x i8] c"long long\00"
@.str.31 = global [19 x i8] c"unsigned long long\00"
@.str.32 = global [10 x i8] c"logical*8\00"
@.str.33 = global [10 x i8] c"integer*8\00"

declare void @abort()

define i32 @stab_xcoff_builtin_type (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 %4 = alloca i8*
 store i32 %0, i32* %3
 %5 = load i32, i32* %3
 %6 = icmp sge i32 %5, 0
 br i1 %6, label %10, label %7
7:
 %8 = load i32, i32* %3
 %9 = icmp slt i32 %8, -34
 br i1 %9, label %10, label %11
10:
 store i32 0, i32* %2
 br label %53
11:
 %12 = load i32, i32* %3
 %13 = sub i32 0, %12
 switch i32 %13, label %48 [
    i32 1, label %14
    i32 2, label %15
    i32 3, label %16
    i32 4, label %17
    i32 5, label %18
    i32 6, label %19
    i32 7, label %20
    i32 8, label %21
    i32 9, label %22
    i32 10, label %23
    i32 11, label %24
    i32 12, label %25
    i32 13, label %26
    i32 14, label %27
    i32 15, label %28
    i32 16, label %29
    i32 17, label %30
    i32 18, label %31
    i32 19, label %32
    i32 20, label %33
    i32 21, label %34
    i32 22, label %35
    i32 23, label %36
    i32 24, label %37
    i32 25, label %38
    i32 26, label %39
    i32 27, label %40
    i32 28, label %41
    i32 29, label %42
    i32 30, label %43
    i32 31, label %44
    i32 32, label %45
    i32 33, label %46
    i32 34, label %47
  ]
14:
 store i8* @.str, i8** %4
 br label %48
15:
 store i8* @.str.1, i8** %4
 br label %16
16:
 store i8* @.str.2, i8** %4
 br label %48
17:
 store i8* @.str.3, i8** %4
 br label %18
18:
 store i8* @.str.4, i8** %4
 br label %19
19:
 store i8* @.str.5, i8** %4
 br label %20
20:
 store i8* @.str.6, i8** %4
 br label %21
21:
 store i8* @.str.7, i8** %4
 br label %22
22:
 store i8* @.str.8, i8** %4
 br label %23
23:
 store i8* @.str.9, i8** %4
 br label %24
24:
 store i8* @.str.10, i8** %4
 br label %25
25:
 store i8* @.str.11, i8** %4
 br label %26
26:
 store i8* @.str.12, i8** %4
 br label %27
27:
 store i8* @.str.13, i8** %4
 br label %28
28:
 store i8* @.str.14, i8** %4
 br label %29
29:
 store i8* @.str.15, i8** %4
 br label %30
30:
 store i8* @.str.16, i8** %4
 br label %31
31:
 store i8* @.str.17, i8** %4
 br label %32
32:
 store i8* @.str.18, i8** %4
 br label %33
33:
 store i8* @.str.19, i8** %4
 br label %34
34:
 store i8* @.str.20, i8** %4
 br label %35
35:
 store i8* @.str.21, i8** %4
 br label %36
36:
 store i8* @.str.22, i8** %4
 br label %37
37:
 store i8* @.str.23, i8** %4
 br label %38
38:
 store i8* @.str.24, i8** %4
 br label %39
39:
 store i8* @.str.25, i8** %4
 br label %40
40:
 store i8* @.str.26, i8** %4
 br label %41
41:
 store i8* @.str.27, i8** %4
 br label %42
42:
 store i8* @.str.28, i8** %4
 br label %43
43:
 store i8* @.str.29, i8** %4
 br label %44
44:
 store i8* @.str.30, i8** %4
 br label %45
45:
 store i8* @.str.31, i8** %4
 br label %46
46:
 store i8* @.str.32, i8** %4
 br label %47
47:
 store i8* @.str.33, i8** %4
 br label %48
48:
 %49 = load i8*, i8** %4
 %50 = getelementptr i8, i8* %49, i64 0
 %51 = load i8, i8* %50
 %52 = sext i8 %51 to i32
 store i32 %52, i32* %2
 br label %53
53:
 %54 = load i32, i32* %2
 ret i32 %54
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 store i32 0, i32* %1
 %3 = call i32 @stab_xcoff_builtin_type (i32 0)
 %4 = icmp ne i32 %3, 0
 br i1 %4, label %5, label %6
5:
 call void @abort ()
 unreachable
6:
 %7 = call i32 @stab_xcoff_builtin_type (i32 -1)
 %8 = icmp ne i32 %7, 105
 br i1 %8, label %9, label %10
9:
 call void @abort ()
 unreachable
10:
 %11 = call i32 @stab_xcoff_builtin_type (i32 -2)
 %12 = icmp ne i32 %11, 115
 br i1 %12, label %13, label %14
13:
 call void @abort ()
 unreachable
14:
 %15 = call i32 @stab_xcoff_builtin_type (i32 -3)
 %16 = icmp ne i32 %15, 115
 br i1 %16, label %17, label %18
17:
 call void @abort ()
 unreachable
18:
 store i32 -4, i32* %2
 br label %19
19:
 %20 = load i32, i32* %2
 %21 = icmp sge i32 %20, -34
 br i1 %21, label %22, label %31
22:
 %23 = load i32, i32* %2
 %24 = call i32 @stab_xcoff_builtin_type (i32 %23)
 %25 = icmp ne i32 %24, 105
 br i1 %25, label %26, label %27
26:
 call void @abort ()
 unreachable
27:
 br label %28
28:
 %29 = load i32, i32* %2
 %30 = add i32 %29, -1
 store i32 %30, i32* %2
 br label %19
31:
 %32 = call i32 @stab_xcoff_builtin_type (i32 -35)
 %33 = icmp ne i32 %32, 0
 br i1 %33, label %34, label %35
34:
 call void @abort ()
 unreachable
35:
 ret i32 0
}
