@.str = global [4 x i8] c"%s\0A\00"
@.str.1 = global [5 x i8] c"long\00"

declare i32 @printf(i8*, ...)

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 store i32 0, i32* %1
 store i32 0, i32* %2
 %3 = call i32 (i8*, ...) @printf (i8* @.str, i8* @.str.1)
 ret i32 0
}
