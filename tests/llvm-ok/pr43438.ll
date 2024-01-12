@g_2 = global i8 1
@l_8 = global i8* @g_9
@g_9 = global i32 0

declare void @abort()

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i8
 store i32 0, i32* %1
 store i8 -2, i8* %2
 %3 = load i8, i8* @g_2
 %4 = zext i8 %3 to i32
 %5 = load i8*, i8** @l_8
 %6 = load i32, i32* %5
 %7 = or i32 %6, %4
 store i32 %7, i32* %5
 %8 = load i8*, i8** @l_8
 %9 = load i32, i32* %8
 %10 = load i8, i8* %2
 %11 = zext i8 %10 to i32
 %12 = or i32 %11, %9
 %13 = trunc i32 %12 to i8
 store i8 %13, i8* %2
 %14 = load i8, i8* %2
 %15 = zext i8 %14 to i32
 call void @func_12 (i32 %15)
 %16 = load i32, i32* @g_9
 %17 = icmp ne i32 %16, 1
 br i1 %17, label %18, label %19
18:
 call void @abort ()
 unreachable
19:
 ret i32 0
}

define void @func_12 (i32 %0) {
 %2 = alloca i32
 %3 = alloca i8*
 store i32 %0, i32* %2
 store i8* @g_9, i8** %3
 %4 = load i32, i32* %2
 %5 = icmp slt i32 0, %4
 %6 = zext i1 %5 to i32
 %7 = load i8*, i8** %3
 %8 = load i32, i32* %7
 %9 = and i32 %8, %6
 store i32 %9, i32* %7
 ret void
}
