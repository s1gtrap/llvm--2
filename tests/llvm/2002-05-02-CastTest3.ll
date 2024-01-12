@.str = global [11 x i8] c"s1   = %d\0A\00"
@.str.1 = global [11 x i8] c"us2  = %u\0A\00"

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
 %9 = icmp sge i32 %8, 3
 br i1 %9, label %10, label %12
10:
 %11 = load i32, i32* %4
 br label %13
12:
 br label %13
13:
 %14 = phi i32 [%11, %10], [-769, %12]
 %15 = trunc i32 %14 to i16
 store i16 %15, i16* %6
 %16 = load i16, i16* %6
 store i16 %16, i16* %7
 %17 = load i16, i16* %6
 %18 = sext i16 %17 to i32
 %19 = call i32 (i8*, ...) @printf (i8* @.str, i32 %18)
 %20 = load i16, i16* %7
 %21 = zext i16 %20 to i32
 %22 = call i32 (i8*, ...) @printf (i8* @.str.1, i32 %21)
 ret i32 0
}
