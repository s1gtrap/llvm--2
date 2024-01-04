@.str = global [3 x i8] c"2 \00"
@.str.1 = global [4 x i8] c"%i \00"

declare i32 @printf(i8*, ...)
declare i32 @atoi(i8*)

define i32 @fac (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %2
 store i32 0, i32* %3
 br label %5
5:
 %6 = load i32, i32* %2
 %7 = and i32 %6, 1
 %8 = icmp eq i32 %7, 0
 br i1 %8, label %9, label %16
9:
 %10 = call i32 (i8*, ...) @printf (i8* @.str)
 br label %11
11:
 %12 = load i32, i32* %2
 %13 = sdiv i32 %12, 2
 store i32 %13, i32* %2
 %14 = load i32, i32* %3
 %15 = add i32 %14, 1
 store i32 %15, i32* %3
 br label %5
16:
 store i32 3, i32* %4
 br label %17
17:
 %18 = load i32, i32* %4
 %19 = load i32, i32* %4
 %20 = mul i32 %18, %19
 %21 = load i32, i32* %2
 %22 = icmp sle i32 %20, %21
 br i1 %22, label %23, label %42
23:
 br label %24
24:
 %25 = load i32, i32* %2
 %26 = load i32, i32* %4
 %27 = srem i32 %25, %26
 %28 = icmp eq i32 %27, 0
 br i1 %28, label %29, label %38
29:
 %30 = load i32, i32* %4
 %31 = call i32 (i8*, ...) @printf (i8* @.str.1, i32 %30)
 br label %32
32:
 %33 = load i32, i32* %4
 %34 = load i32, i32* %2
 %35 = sdiv i32 %34, %33
 store i32 %35, i32* %2
 %36 = load i32, i32* %3
 %37 = add i32 %36, 1
 store i32 %37, i32* %3
 br label %24
38:
 br label %39
39:
 %40 = load i32, i32* %4
 %41 = add i32 %40, 2
 store i32 %41, i32* %4
 br label %17
42:
 %43 = load i32, i32* %2
 %44 = icmp sgt i32 %43, 2
 br i1 %44, label %45, label %50
45:
 %46 = load i32, i32* %2
 %47 = call i32 (i8*, ...) @printf (i8* @.str.1, i32 %46)
 %48 = load i32, i32* %3
 %49 = add i32 %48, 1
 store i32 %49, i32* %3
 br label %50
50:
 %51 = load i32, i32* %3
 ret i32 %51
}

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 %6 = load i8*, i8** %5
 %7 = getelementptr i8*, i8* %6, i64 1
 %8 = load i8*, i8** %7
 %9 = call i32 @atoi (i8* %8)
 %10 = call i32 @fac (i32 %9)
 ret i32 %10
}
