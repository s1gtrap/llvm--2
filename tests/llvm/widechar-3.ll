@.str = global [7 x i32] [i32 97, i32 98, i32 99, i32 100, i32 101, i32 102, i32 0]

declare void @abort()
declare void @exit(i32)
declare i64 @strlen(i8*)

define i32 @foo () {
 %1 = call i32 @f (i8* @.str)
 ret i32 %1
}

define i32 @f (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 %3 = load i8*, i8** %2
 %4 = call i64 @strlen (i8* %3)
 %5 = trunc i64 %4 to i32
 ret i32 %5
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @foo ()
 %3 = icmp ne i32 %2, 1
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 call void @exit (i32 0)
 unreachable
}
