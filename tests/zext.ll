@fmt = global [6 x i8] c"%08X\0A\00"

declare i32 @printf(i8*, ...)

define i32 @main () {
 %v0 = add i32 4294967295, 0
 call i32 (i8*, i32) @printf (i8* @fmt, i32 %v0)
 %v1 = trunc i32 %v0 to i8
 call i32 (i8*, i8) @printf (i8* @fmt, i8 %v1)
 %v2 = zext i8 %v1 to i32
 call i32 (i8*, i32) @printf (i8* @fmt, i32 %v2)
 ret i32 %v2
}
