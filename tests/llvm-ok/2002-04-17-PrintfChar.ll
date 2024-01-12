@.str = global [11 x i8] c"'%c' '%c'\0A\00"
@.str.1 = global [2 x i8] c"e\00"

declare i32 @printf(i8*, ...)

define void @printArgsNoRet (i8 %0, i8* %1) {
 %3 = alloca i8
 %4 = alloca i8*
 store i8 %0, i8* %3
 store i8* %1, i8** %4
 %5 = load i8, i8* %3
 %6 = sext i8 %5 to i32
 %7 = load i8*, i8** %4
 %8 = load i8, i8* %7
 %9 = sext i8 %8 to i32
 %10 = call i32 (i8*, ...) @printf (i8* @.str, i32 %6, i32 %9)
 ret void
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @printArgsNoRet (i8 99, i8* @.str.1)
 ret i32 0
}
