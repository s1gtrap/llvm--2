@.str = global [10 x i8] c"FAILURE!\0A\00"
@.str.1 = global [9 x i8] c"SUCCESS\0A\00"

declare i8* @malloc(i64)
declare i32 @printf(i8*, ...)
declare void @exit(i32)

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i8*
 store i32 0, i32* %1
 %3 = call i8* @malloc (i64 64)
 store i8* %3, i8** %2
 %4 = load i8*, i8** %2
 %5 = icmp eq i8* %4, null
 br i1 %5, label %6, label %8
6:
 %7 = call i32 (i8*, ...) @printf (i8* @.str)
 call void @exit (i32 1)
 unreachable
8:
 %9 = call i32 (i8*, ...) @printf (i8* @.str.1)
 ret i32 0
}
