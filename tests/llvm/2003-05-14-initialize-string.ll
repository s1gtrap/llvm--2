@__const.main.title = global [15 x i8] c"foo and stuff\0A\00"
@.str = global [3 x i8] c"%s\00"

declare void @memcpy(i8*, i8*, i64, i1)
declare i32 @printf(i8*, ...)

define i32 @main () {
 %1 = alloca i32
 %2 = alloca [15 x i8]
 store i32 0, i32* %1
 call void @memcpy (i8* %2, i8* @__const.main.title, i64 15, i1 0)
 %3 = getelementptr [15 x i8], i8* %2, i64 0, i64 0
 %4 = call i32 (i8*, ...) @printf (i8* @.str, i8* %3)
 ret i32 0
}
