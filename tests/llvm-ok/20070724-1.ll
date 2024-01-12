@value = global i8 -99
@magic = global [2 x i8] c"\9D\00"

declare void @abort()

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = load i8, i8* @value
 %3 = zext i8 %2 to i32
 %4 = load i8, i8* @magic
 %5 = zext i8 %4 to i32
 %6 = icmp ne i32 %3, %5
 br i1 %6, label %7, label %8
7:
 call void @abort ()
 unreachable
8:
 ret i32 0
}
