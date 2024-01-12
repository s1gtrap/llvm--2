@.str = global [6 x i8] c"hello\00"
@a = global i32 0

declare i32 @strcmp(i8*, i8*)
declare void @abort()

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = load i32, i32* @a
 call void @foo (i8* @.str, i32 %2)
 call void @bar (i8* @.str)
 ret i32 0
}

define void @foo (i8* %0, i32 %1) {
 %3 = alloca i8*
 %4 = alloca i32
 store i8* %0, i8** %3
 store i32 %1, i32* %4
 %5 = load i8*, i8** %3
 %6 = call i32 @strcmp (i8* %5, i8* @.str)
 %7 = icmp ne i32 %6, 0
 br i1 %7, label %8, label %9
8:
 call void @abort ()
 unreachable
9:
 ret void
}

define void @bar (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 %3 = load i8*, i8** %2
 %4 = call i32 @strcmp (i8* %3, i8* @.str)
 %5 = icmp ne i32 %4, 0
 br i1 %5, label %6, label %7
6:
 call void @abort ()
 unreachable
7:
 ret void
}
