@.str = global [13 x i8] c"Inside quux\0A\00"
@.str.1 = global [27 x i8] c"Longjmping from quux: 927\0A\00"
@.str.2 = global [12 x i8] c"Inside qux\0A\00"
@.str.3 = global [33 x i8] c"Error: Shouldn't be here in qux\0A\00"
@.str.4 = global [12 x i8] c"Inside baz\0A\00"
@.str.5 = global [33 x i8] c"Error: Shouldn't be here in baz\0A\00"
@.str.6 = global [12 x i8] c"Inside bar\0A\00"
@.str.7 = global [12 x i8] c"Inside foo\0A\00"
@.str.8 = global [33 x i8] c"Returning from longjmp into foo\0A\00"

declare i32 @printf(i8*, ...)
declare void @longjmp(i8*, i32)
declare i32 @setjmp(i8*)

define void @quux (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 %3 = call i32 (i8*, ...) @printf (i8* @.str)
 %4 = call i32 (i8*, ...) @printf (i8* @.str.1)
 %5 = load i8*, i8** %2
 call void @longjmp (i8* %5, i32 927)
 unreachable
}

define void @qux (i8* %0) {
 %2 = alloca i8*
 %3 = alloca [37 x i32]
 store i8* %0, i8** %2
 %4 = call i32 (i8*, ...) @printf (i8* @.str.2)
 %5 = getelementptr [37 x i32], i8* %3, i64 0, i64 0
 %6 = call i32 @setjmp (i8* %5)
 %7 = icmp ne i32 %6, 0
 br i1 %7, label %10, label %8
8:
 %9 = load i8*, i8** %2
 call void @quux (i8* %9)
 br label %12
10:
 %11 = call i32 (i8*, ...) @printf (i8* @.str.3)
 br label %12
12:
 ret void
}

define void @baz (i8* %0) {
 %2 = alloca i8*
 %3 = alloca [37 x i32]
 store i8* %0, i8** %2
 %4 = call i32 (i8*, ...) @printf (i8* @.str.4)
 %5 = getelementptr [37 x i32], i8* %3, i64 0, i64 0
 %6 = call i32 @setjmp (i8* %5)
 %7 = icmp ne i32 %6, 0
 br i1 %7, label %10, label %8
8:
 %9 = load i8*, i8** %2
 call void @qux (i8* %9)
 br label %12
10:
 %11 = call i32 (i8*, ...) @printf (i8* @.str.5)
 br label %12
12:
 ret void
}

define void @bar (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 %3 = call i32 (i8*, ...) @printf (i8* @.str.6)
 %4 = load i8*, i8** %2
 call void @baz (i8* %4)
 ret void
}

define void @foo () {
 %1 = alloca [37 x i32]
 %2 = call i32 (i8*, ...) @printf (i8* @.str.7)
 %3 = getelementptr [37 x i32], i8* %1, i64 0, i64 0
 %4 = call i32 @setjmp (i8* %3)
 %5 = icmp ne i32 %4, 0
 br i1 %5, label %8, label %6
6:
 %7 = getelementptr [37 x i32], i8* %1, i64 0, i64 0
 call void @bar (i8* %7)
 br label %10
8:
 %9 = call i32 (i8*, ...) @printf (i8* @.str.8)
 br label %10
10:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @foo ()
 ret i32 0
}
