@.str = global [11 x i8] c"error: %d\0A\00"

declare i32 @printf(i8*, ...)

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 (i8*, ...) @printf (i8* @.str, i64 24)
 ret i32 0
}
