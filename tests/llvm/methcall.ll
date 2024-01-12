%struct.Toggle = type { i8, i8*, i8* }
%struct.NthToggle = type { i8, i8*, i8*, i32, i32 }

@.str = global [6 x i8] c"true\0A\00"
@.str.1 = global [7 x i8] c"false\0A\00"

declare i8* @malloc(i64)
declare i32 @atoi(i8*)
declare i32 @puts(i8*)
declare void @free(i8*)

define i8 @toggle_value (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 %3 = load i8*, i8** %2
 %4 = getelementptr %struct.Toggle, i8* %3, i32 0, i32 0
 %5 = load i8, i8* %4
 ret i8 %5
}

define i8* @toggle_activate (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 %3 = load i8*, i8** %2
 %4 = getelementptr %struct.Toggle, i8* %3, i32 0, i32 0
 %5 = load i8, i8* %4
 %6 = icmp ne i8 %5, 0
 %7 = xor i1 %6, 1
 %8 = zext i1 %7 to i32
 %9 = trunc i32 %8 to i8
 %10 = load i8*, i8** %2
 %11 = getelementptr %struct.Toggle, i8* %10, i32 0, i32 0
 store i8 %9, i8* %11
 %12 = load i8*, i8** %2
 ret i8* %12
}

define i8* @init_Toggle (i8* %0, i8 %1) {
 %3 = alloca i8*
 %4 = alloca i8
 store i8* %0, i8** %3
 store i8 %1, i8* %4
 %5 = load i8, i8* %4
 %6 = load i8*, i8** %3
 %7 = getelementptr %struct.Toggle, i8* %6, i32 0, i32 0
 store i8 %5, i8* %7
 %8 = load i8*, i8** %3
 %9 = getelementptr %struct.Toggle, i8* %8, i32 0, i32 1
 store i8* @toggle_value, i8** %9
 %10 = load i8*, i8** %3
 %11 = getelementptr %struct.Toggle, i8* %10, i32 0, i32 2
 store i8* @toggle_activate, i8** %11
 %12 = load i8*, i8** %3
 ret i8* %12
}

define i8* @new_Toggle (i8 %0) {
 %2 = alloca i8
 %3 = alloca i8*
 store i8 %0, i8* %2
 %4 = call i8* @malloc (i64 24)
 store i8* %4, i8** %3
 %5 = load i8*, i8** %3
 %6 = load i8, i8* %2
 %7 = call i8* @init_Toggle (i8* %5, i8 %6)
 ret i8* %7
}

define i8* @nth_toggle_activate (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 %3 = load i8*, i8** %2
 %4 = getelementptr %struct.NthToggle, i8* %3, i32 0, i32 4
 %5 = load i32, i32* %4
 %6 = add i32 %5, 1
 store i32 %6, i32* %4
 %7 = load i8*, i8** %2
 %8 = getelementptr %struct.NthToggle, i8* %7, i32 0, i32 3
 %9 = load i32, i32* %8
 %10 = icmp sge i32 %6, %9
 br i1 %10, label %11, label %23
11:
 %12 = load i8*, i8** %2
 %13 = getelementptr %struct.NthToggle, i8* %12, i32 0, i32 0
 %14 = load i8, i8* %13
 %15 = icmp ne i8 %14, 0
 %16 = xor i1 %15, 1
 %17 = zext i1 %16 to i32
 %18 = trunc i32 %17 to i8
 %19 = load i8*, i8** %2
 %20 = getelementptr %struct.NthToggle, i8* %19, i32 0, i32 0
 store i8 %18, i8* %20
 %21 = load i8*, i8** %2
 %22 = getelementptr %struct.NthToggle, i8* %21, i32 0, i32 4
 store i32 0, i32* %22
 br label %23
23:
 %24 = load i8*, i8** %2
 ret i8* %24
}

define i8* @init_NthToggle (i8* %0, i32 %1) {
 %3 = alloca i8*
 %4 = alloca i32
 store i8* %0, i8** %3
 store i32 %1, i32* %4
 %5 = load i32, i32* %4
 %6 = load i8*, i8** %3
 %7 = getelementptr %struct.NthToggle, i8* %6, i32 0, i32 3
 store i32 %5, i32* %7
 %8 = load i8*, i8** %3
 %9 = getelementptr %struct.NthToggle, i8* %8, i32 0, i32 4
 store i32 0, i32* %9
 %10 = load i8*, i8** %3
 %11 = getelementptr %struct.NthToggle, i8* %10, i32 0, i32 2
 store i8* @nth_toggle_activate, i8** %11
 %12 = load i8*, i8** %3
 ret i8* %12
}

define i8* @new_NthToggle (i8 %0, i32 %1) {
 %3 = alloca i8
 %4 = alloca i32
 %5 = alloca i8*
 store i8 %0, i8* %3
 store i32 %1, i32* %4
 %6 = call i8* @malloc (i64 32)
 store i8* %6, i8** %5
 %7 = load i8*, i8** %5
 %8 = load i8, i8* %3
 %9 = call i8* @init_Toggle (i8* %7, i8 %8)
 store i8* %9, i8** %5
 %10 = load i8*, i8** %5
 %11 = load i32, i32* %4
 %12 = call i8* @init_NthToggle (i8* %10, i32 %11)
 ret i8* %12
}

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 %6 = alloca i32
 %7 = alloca i32
 %8 = alloca i8*
 %9 = alloca i8*
 %10 = alloca i8
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 %11 = load i32, i32* %4
 %12 = icmp eq i32 %11, 2
 br i1 %12, label %13, label %18
13:
 %14 = load i8*, i8** %5
 %15 = getelementptr i8*, i8* %14, i64 1
 %16 = load i8*, i8** %15
 %17 = call i32 @atoi (i8* %16)
 br label %19
18:
 br label %19
19:
 %20 = phi i32 [%17, %13], [500000000, %18]
 store i32 %20, i32* %7
 store i8 1, i8* %10
 %21 = call i8* @new_Toggle (i8 1)
 store i8* %21, i8** %8
 store i32 0, i32* %6
 br label %22
22:
 %23 = load i32, i32* %6
 %24 = load i32, i32* %7
 %25 = icmp slt i32 %23, %24
 br i1 %25, label %26, label %39
26:
 %27 = load i8*, i8** %8
 %28 = getelementptr %struct.Toggle, i8* %27, i32 0, i32 2
 %29 = load i8*, i8** %28
 %30 = load i8*, i8** %8
 %31 = call i8* %29 (i8* %30)
 %32 = getelementptr %struct.Toggle, i8* %31, i32 0, i32 1
 %33 = load i8*, i8** %32
 %34 = load i8*, i8** %8
 %35 = call i8 %33 (i8* %34)
 store i8 %35, i8* %10
 br label %36
36:
 %37 = load i32, i32* %6
 %38 = add i32 %37, 1
 store i32 %38, i32* %6
 br label %22
39:
 %40 = load i8, i8* %10
 %41 = sext i8 %40 to i32
 %42 = icmp ne i32 %41, 0
 %43 = zext i1 %42 to i64
 %44 = select i1 %42, i8* @.str, i8* @.str.1
 %45 = call i32 @puts (i8* %44)
 %46 = load i8*, i8** %8
 call void @free (i8* %46)
 store i8 1, i8* %10
 %47 = load i8, i8* %10
 %48 = call i8* @new_NthToggle (i8 %47, i32 3)
 store i8* %48, i8** %9
 store i32 0, i32* %6
 br label %49
49:
 %50 = load i32, i32* %6
 %51 = load i32, i32* %7
 %52 = icmp slt i32 %50, %51
 br i1 %52, label %53, label %66
53:
 %54 = load i8*, i8** %9
 %55 = getelementptr %struct.NthToggle, i8* %54, i32 0, i32 2
 %56 = load i8*, i8** %55
 %57 = load i8*, i8** %9
 %58 = call i8* %56 (i8* %57)
 %59 = getelementptr %struct.Toggle, i8* %58, i32 0, i32 1
 %60 = load i8*, i8** %59
 %61 = load i8*, i8** %9
 %62 = call i8 %60 (i8* %61)
 store i8 %62, i8* %10
 br label %63
63:
 %64 = load i32, i32* %6
 %65 = add i32 %64, 1
 store i32 %65, i32* %6
 br label %49
66:
 %67 = load i8, i8* %10
 %68 = sext i8 %67 to i32
 %69 = icmp ne i32 %68, 0
 %70 = zext i1 %69 to i64
 %71 = select i1 %69, i8* @.str, i8* @.str.1
 %72 = call i32 @puts (i8* %71)
 %73 = load i8*, i8** %9
 call void @free (i8* %73)
 ret i32 0
}
