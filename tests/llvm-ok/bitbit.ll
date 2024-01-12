@.str = global [15 x i8] c"i_result = %x\0A\00"
@.str.1 = global [4 x i8] c"ok\0A\00"
@.str.2 = global [6 x i8] c"fail\0A\00"

declare i32 @printf(i8*, ...)

define i32 @my_test () {
 %1 = alloca i32
 %2 = alloca i32
 %3 = alloca i32
 %4 = alloca i32
 store i32 2097151, i32* %1
 store i32 1048575, i32* %2
 %5 = load i32, i32* %1
 %6 = xor i32 %5, -1
 store i32 %6, i32* %3
 %7 = load i32, i32* %3
 store i32 %7, i32* %4
 %8 = load i32, i32* %4
 %9 = call i32 (i8*, ...) @printf (i8* @.str, i32 %8)
 %10 = load i32, i32* %1
 %11 = load i32, i32* %2
 %12 = xor i32 %10, %11
 store i32 %12, i32* %3
 %13 = load i32, i32* %3
 store i32 %13, i32* %4
 %14 = load i32, i32* %4
 %15 = call i32 (i8*, ...) @printf (i8* @.str, i32 %14)
 %16 = load i32, i32* %1
 %17 = load i32, i32* %2
 %18 = and i32 %16, %17
 store i32 %18, i32* %3
 %19 = load i32, i32* %3
 %20 = load i32, i32* %2
 %21 = icmp eq i32 %19, %20
 br i1 %21, label %22, label %24
22:
 %23 = call i32 (i8*, ...) @printf (i8* @.str.1)
 br label %26
24:
 %25 = call i32 (i8*, ...) @printf (i8* @.str.2)
 br label %26
26:
 %27 = load i32, i32* %1
 %28 = load i32, i32* %2
 %29 = or i32 %27, %28
 store i32 %29, i32* %3
 %30 = load i32, i32* %3
 %31 = load i32, i32* %1
 %32 = icmp eq i32 %30, %31
 br i1 %32, label %33, label %35
33:
 %34 = call i32 (i8*, ...) @printf (i8* @.str.1)
 br label %37
35:
 %36 = call i32 (i8*, ...) @printf (i8* @.str.2)
 br label %37
37:
 %38 = load i32, i32* %1
 store i32 %38, i32* %3
 %39 = load i32, i32* %2
 %40 = load i32, i32* %3
 %41 = and i32 %40, %39
 store i32 %41, i32* %3
 %42 = load i32, i32* %3
 %43 = load i32, i32* %2
 %44 = icmp eq i32 %42, %43
 br i1 %44, label %45, label %47
45:
 %46 = call i32 (i8*, ...) @printf (i8* @.str.1)
 br label %49
47:
 %48 = call i32 (i8*, ...) @printf (i8* @.str.2)
 br label %49
49:
 %50 = load i32, i32* %1
 store i32 %50, i32* %3
 %51 = load i32, i32* %2
 %52 = load i32, i32* %3
 %53 = or i32 %52, %51
 store i32 %53, i32* %3
 %54 = load i32, i32* %3
 %55 = load i32, i32* %1
 %56 = icmp eq i32 %54, %55
 br i1 %56, label %57, label %59
57:
 %58 = call i32 (i8*, ...) @printf (i8* @.str.1)
 br label %61
59:
 %60 = call i32 (i8*, ...) @printf (i8* @.str.2)
 br label %61
61:
 %62 = load i32, i32* %1
 %63 = ashr i32 %62, 20
 store i32 %63, i32* %3
 %64 = load i32, i32* %3
 store i32 %64, i32* %4
 %65 = load i32, i32* %4
 %66 = call i32 (i8*, ...) @printf (i8* @.str, i32 %65)
 %67 = load i32, i32* %2
 %68 = shl i32 %67, 1
 store i32 %68, i32* %3
 %69 = load i32, i32* %3
 %70 = add i32 %69, 1
 store i32 %70, i32* %3
 %71 = load i32, i32* %3
 %72 = load i32, i32* %1
 %73 = icmp ne i32 %71, %72
 br i1 %73, label %74, label %76
74:
 %75 = call i32 (i8*, ...) @printf (i8* @.str.2)
 br label %78
76:
 %77 = call i32 (i8*, ...) @printf (i8* @.str.1)
 br label %78
78:
 %79 = load i32, i32* %2
 store i32 %79, i32* %3
 %80 = load i32, i32* %3
 %81 = shl i32 %80, 1
 store i32 %81, i32* %3
 %82 = load i32, i32* %3
 %83 = add i32 %82, 1
 store i32 %83, i32* %3
 %84 = load i32, i32* %3
 %85 = load i32, i32* %1
 %86 = icmp ne i32 %84, %85
 br i1 %86, label %87, label %89
87:
 %88 = call i32 (i8*, ...) @printf (i8* @.str.2)
 br label %91
89:
 %90 = call i32 (i8*, ...) @printf (i8* @.str.1)
 br label %91
91:
 ret i32 0
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @my_test ()
 ret i32 0
}
