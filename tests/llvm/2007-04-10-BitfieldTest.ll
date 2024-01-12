%union.u = type { %struct.anon }
%struct.anon = type { i64 }

@.str = global [12 x i8] c"p = 0x%02X\0A\00"

declare i32 @printf(i8*, ...)

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 %6 = alloca %union.u
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 store i64 82351535429844991, i64* %6
 %7 = load i64, i64* %6
 %8 = lshr i64 %7, 48
 %9 = and i64 %8, 255
 %10 = trunc i64 %9 to i32
 %11 = call i32 (i8*, ...) @printf (i8* @.str, i32 %10)
 ret i32 0
}
