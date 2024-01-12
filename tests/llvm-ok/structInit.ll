%struct.Connection_Type = type { i32, [10 x i8], i32 }

@link = global [3 x %struct.Connection_Type] [%struct.Connection_Type {i32 1, [10 x i8] c"link1\00\00\00\00\00", i32 10}, %struct.Connection_Type {i32 2, [10 x i8] c"link2\00\00\00\00\00", i32 20}, %struct.Connection_Type {i32 3, [10 x i8] c"link3\00\00\00\00\00", i32 30}]
@.str = global [12 x i8] c"%d, %s, %d\0A\00"

declare i32 @printf(i8*, ...)

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 store i32 0, i32* %1
 store i32 0, i32* %2
 br label %3
3:
 %4 = load i32, i32* %2
 %5 = icmp slt i32 %4, 3
 br i1 %5, label %6, label %26
6:
 %7 = load i32, i32* %2
 %8 = sext i32 %7 to i64
 %9 = getelementptr [3 x %struct.Connection_Type], i8* @link, i64 0, i64 %8
 %10 = getelementptr %struct.Connection_Type, i8* %9, i32 0, i32 0
 %11 = load i32, i32* %10
 %12 = load i32, i32* %2
 %13 = sext i32 %12 to i64
 %14 = getelementptr [3 x %struct.Connection_Type], i8* @link, i64 0, i64 %13
 %15 = getelementptr %struct.Connection_Type, i8* %14, i32 0, i32 1
 %16 = getelementptr [10 x i8], i8* %15, i64 0, i64 0
 %17 = load i32, i32* %2
 %18 = sext i32 %17 to i64
 %19 = getelementptr [3 x %struct.Connection_Type], i8* @link, i64 0, i64 %18
 %20 = getelementptr %struct.Connection_Type, i8* %19, i32 0, i32 2
 %21 = load i32, i32* %20
 %22 = call i32 (i8*, ...) @printf (i8* @.str, i32 %11, i8* %16, i32 %21)
 br label %23
23:
 %24 = load i32, i32* %2
 %25 = add i32 %24, 1
 store i32 %25, i32* %2
 br label %3
26:
 ret i32 0
}
