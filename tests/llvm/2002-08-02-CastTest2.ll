@.str = global [11 x i8] c"s1   = %d\0A\00"
@.str.1 = global [11 x i8] c"us2  = %u\0A\00"

declare i32 @printf(i8*, ...)

define void @test (i16 %0) {
 %2 = alloca i16
 %3 = alloca i16
 store i16 %0, i16* %2
 %4 = load i16, i16* %2
 store i16 %4, i16* %3
 %5 = load i16, i16* %2
 %6 = sext i16 %5 to i32
 %7 = call i32 (i8*, ...) @printf (i8* @.str, i32 %6)
 %8 = load i16, i16* %3
 %9 = zext i16 %8 to i32
 %10 = call i32 (i8*, ...) @printf (i8* @.str.1, i32 %9)
 ret void
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @test (i16 -769)
 ret i32 0
}
