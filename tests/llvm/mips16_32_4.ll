@.str = global [16 x i8] c"in foo: mips16\0A\00"
@.str.1 = global [16 x i8] c"in foo: mips32\0A\00"
@.str.2 = global [17 x i8] c"in main: mips16\0A\00"

declare i32 @printf(i8*, ...)

define void @foo () {
 %1 = call i32 (i8*, ...) @printf (i8* @.str)
 ret void
}

define void @nofoo () {
 %1 = call i32 (i8*, ...) @printf (i8* @.str.1)
 ret void
}

define i32 @main () {
 call void @foo ()
 call void @nofoo ()
 %1 = call i32 (i8*, ...) @printf (i8* @.str.2)
 ret i32 0
}
