@.str = global [9 x i8] c"in main\0A\00"
@.str.1 = global [10 x i8] c"Exiting!\0A\00"

declare i32 @atexit(i8*)
declare i32 @printf(i8*, ...)

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @atexit (i8* @foo)
 %3 = call i32 (i8*, ...) @printf (i8* @.str)
 ret i32 0
}

define void @foo () {
 %1 = call i32 (i8*, ...) @printf (i8* @.str.1)
 ret void
}
