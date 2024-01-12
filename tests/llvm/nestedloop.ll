@.str = global [4 x i8] c"%d\0A\00"

declare i32 @atoi(i8*)
declare i32 @printf(i8*, ...)

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 %6 = alloca i32
 %7 = alloca i32
 %8 = alloca i32
 %9 = alloca i32
 %10 = alloca i32
 %11 = alloca i32
 %12 = alloca i32
 %13 = alloca i32
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 %14 = load i32, i32* %4
 %15 = icmp eq i32 %14, 2
 br i1 %15, label %16, label %21
16:
 %17 = load i8*, i8** %5
 %18 = getelementptr i8*, i8* %17, i64 1
 %19 = load i8*, i8** %18
 %20 = call i32 @atoi (i8* %19)
 br label %22
21:
 br label %22
22:
 %23 = phi i32 [%20, %16], [46, %21]
 store i32 %23, i32* %6
 store i32 0, i32* %13
 store i32 0, i32* %7
 br label %24
24:
 %25 = load i32, i32* %7
 %26 = load i32, i32* %6
 %27 = icmp slt i32 %25, %26
 br i1 %27, label %28, label %79
28:
 store i32 0, i32* %8
 br label %29
29:
 %30 = load i32, i32* %8
 %31 = load i32, i32* %6
 %32 = icmp slt i32 %30, %31
 br i1 %32, label %33, label %75
33:
 store i32 0, i32* %9
 br label %34
34:
 %35 = load i32, i32* %9
 %36 = load i32, i32* %6
 %37 = icmp slt i32 %35, %36
 br i1 %37, label %38, label %71
38:
 store i32 0, i32* %10
 br label %39
39:
 %40 = load i32, i32* %10
 %41 = load i32, i32* %6
 %42 = icmp slt i32 %40, %41
 br i1 %42, label %43, label %67
43:
 store i32 0, i32* %11
 br label %44
44:
 %45 = load i32, i32* %11
 %46 = load i32, i32* %6
 %47 = icmp slt i32 %45, %46
 br i1 %47, label %48, label %63
48:
 store i32 0, i32* %12
 br label %49
49:
 %50 = load i32, i32* %12
 %51 = load i32, i32* %6
 %52 = icmp slt i32 %50, %51
 br i1 %52, label %53, label %59
53:
 %54 = load i32, i32* %13
 %55 = add i32 %54, 1
 store i32 %55, i32* %13
 br label %56
56:
 %57 = load i32, i32* %12
 %58 = add i32 %57, 1
 store i32 %58, i32* %12
 br label %49
59:
 br label %60
60:
 %61 = load i32, i32* %11
 %62 = add i32 %61, 1
 store i32 %62, i32* %11
 br label %44
63:
 br label %64
64:
 %65 = load i32, i32* %10
 %66 = add i32 %65, 1
 store i32 %66, i32* %10
 br label %39
67:
 br label %68
68:
 %69 = load i32, i32* %9
 %70 = add i32 %69, 1
 store i32 %70, i32* %9
 br label %34
71:
 br label %72
72:
 %73 = load i32, i32* %8
 %74 = add i32 %73, 1
 store i32 %74, i32* %8
 br label %29
75:
 br label %76
76:
 %77 = load i32, i32* %7
 %78 = add i32 %77, 1
 store i32 %78, i32* %7
 br label %24
79:
 %80 = load i32, i32* %13
 %81 = call i32 (i8*, ...) @printf (i8* @.str, i32 %80)
 ret i32 0
}
