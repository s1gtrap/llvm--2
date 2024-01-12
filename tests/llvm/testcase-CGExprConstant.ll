%struct.S1 = type { i32, i32 }
%struct.S2 = type { %struct.S1, i8*, [2 x i32] }

@gs1 = global %struct.S1 {i32 1, i32 2}
@.compoundliteral = global %struct.S2 {%struct.S1 {i32 1, i32 2}, i8* @gs1, [2 x i32] [i32 1, i32 2]}
@s = global i8* @.compoundliteral
@.str = global [3 x i8] c"%d\00"

declare i32 @printf(i8*, ...)

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = load i8*, i8** @s
 %3 = getelementptr %struct.S2, i8* %2, i32 0, i32 0
 %4 = getelementptr %struct.S1, i8* %3, i32 0, i32 1
 %5 = load i32, i32* %4
 %6 = icmp ne i32 %5, 2
 br i1 %6, label %7, label %8
7:
 store i32 2, i32* %1
 br label %21
8:
 %9 = load i8*, i8** @s
 %10 = getelementptr %struct.S2, i8* %9, i32 0, i32 2
 %11 = getelementptr [2 x i32], i8* %10, i64 0, i64 1
 %12 = load i32, i32* %11
 %13 = icmp ne i32 %12, 2
 br i1 %13, label %14, label %15
14:
 store i32 6, i32* %1
 br label %21
15:
 %16 = load i8*, i8** @s
 %17 = getelementptr %struct.S2, i8* %16, i32 0, i32 2
 %18 = getelementptr [2 x i32], i8* %17, i64 0, i64 1
 %19 = load i32, i32* %18
 %20 = call i32 (i8*, ...) @printf (i8* @.str, i32 %19)
 store i32 0, i32* %1
 br label %21
21:
 %22 = load i32, i32* %1
 ret i32 %22
}
