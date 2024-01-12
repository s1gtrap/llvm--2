@.str = global [11 x i8] c"us2  = %u\0A\00"

declare i32 @atoi(i8*)
declare i32 @printf(i8*, ...)

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 %6 = alloca i16
 %7 = alloca i16
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 %8 = load i32, i32* %4
 %9 = icmp sgt i32 %8, 120
 br i1 %9, label %10, label %15
10:
 %11 = load i8*, i8** %5
 %12 = getelementptr i8*, i8* %11, i64 1
 %13 = load i8*, i8** %12
 %14 = call i32 @atoi (i8* %13)
 br label %16
15:
 br label %16
16:
 %17 = phi i32 [%14, %10], [-769, %15]
 %18 = trunc i32 %17 to i16
 store i16 %18, i16* %6
 %19 = load i16, i16* %6
 store i16 %19, i16* %7
 %20 = load i16, i16* %7
 %21 = zext i16 %20 to i32
 %22 = call i32 (i8*, ...) @printf (i8* @.str, i32 %21)
 ret i32 0
}
