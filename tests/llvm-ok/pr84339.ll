%struct.S = type { i32, [1 x i8] }

@.str = global [8 x i8] c"abcdefg\00"

declare i64 @strlen(i8*)
declare i8* @malloc(i64)
declare i8* @strcpy(i8*, i8*)
declare void @abort()
declare void @free(i8*)

define i32 @foo (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 %3 = load i8*, i8** %2
 %4 = getelementptr %struct.S, i8* %3, i32 0, i32 1
 %5 = getelementptr [1 x i8], i8* %4, i64 0, i64 0
 %6 = call i64 @strlen (i8* %5)
 %7 = trunc i64 %6 to i32
 ret i32 %7
}

define i32 @bar (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 %3 = load i8*, i8** %2
 %4 = getelementptr %struct.S, i8* %3, i32 0, i32 1
 %5 = getelementptr [1 x i8], i8* %4, i64 0, i64 0
 %6 = call i64 @strlen (i8* %5)
 %7 = trunc i64 %6 to i32
 ret i32 %7
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i8*
 store i32 0, i32* %1
 %3 = call i8* @malloc (i64 24)
 store i8* %3, i8** %2
 %4 = load i8*, i8** %2
 %5 = icmp ne i8* %4, null
 br i1 %5, label %6, label %23
6:
 %7 = load i8*, i8** %2
 %8 = getelementptr %struct.S, i8* %7, i32 0, i32 0
 store i32 1, i32* %8
 %9 = load i8*, i8** %2
 %10 = getelementptr %struct.S, i8* %9, i32 0, i32 1
 %11 = getelementptr [1 x i8], i8* %10, i64 0, i64 0
 %12 = call i8* @strcpy (i8* %11, i8* @.str)
 %13 = load i8*, i8** %2
 %14 = call i32 @foo (i8* %13)
 %15 = icmp ne i32 %14, 7
 br i1 %15, label %20, label %16
16:
 %17 = load i8*, i8** %2
 %18 = call i32 @bar (i8* %17)
 %19 = icmp ne i32 %18, 7
 br i1 %19, label %20, label %21
20:
 call void @abort ()
 unreachable
21:
 %22 = load i8*, i8** %2
 call void @free (i8* %22)
 br label %23
23:
 ret i32 0
}
