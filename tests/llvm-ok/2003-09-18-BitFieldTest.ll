%struct.rtx_def = type { i8, [3 x i8] }

@.str = global [7 x i8] c"%d %d\0A\00"

declare i32 @printf(i8*, ...)

define void @i2 (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 %3 = load i8*, i8** %2
 %4 = load i8, i8* %3
 %5 = and i8 %4, -2
 %6 = or i8 %5, 0
 store i8 %6, i8* %3
 ret void
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca %struct.rtx_def
 store i32 0, i32* %1
 %3 = load i8, i8* %2
 %4 = and i8 %3, -3
 %5 = or i8 %4, 2
 store i8 %5, i8* %2
 call void @i2 (i8* %2)
 %6 = load i8, i8* %2
 %7 = and i8 %6, 1
 %8 = zext i8 %7 to i32
 %9 = load i8, i8* %2
 %10 = lshr i8 %9, 1
 %11 = and i8 %10, 1
 %12 = zext i8 %11 to i32
 %13 = call i32 (i8*, ...) @printf (i8* @.str, i32 %8, i32 %12)
 ret i32 0
}
