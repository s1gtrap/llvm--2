@.str = global [13 x i8] c"hello world\0A\00"

declare i32 @puts(i8*)

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @puts (i8* @.str)
 ret i32 0
}
