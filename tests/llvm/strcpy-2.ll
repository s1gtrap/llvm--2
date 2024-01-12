@a = global [7 x i8] c"Hi!THE\00"
@.str = global [7 x i8] c"Hi!THE\00"

declare i8* @strcpy(i8*, i8*)
declare void @memset(i8*, i8, i64, i1)
declare void @abort()

define void @f (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 %3 = load i8*, i8** %2
 %4 = call i8* @strcpy (i8* %3, i8* @.str)
 ret void
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 %3 = alloca [7 x i8]
 store i32 0, i32* %1
 call void @memset (i8* %3, i8 0, i64 7, i1 0)
 %4 = getelementptr [7 x i8], i8* %3, i64 0, i64 0
 call void @f (i8* %4)
 store i32 0, i32* %2
 br label %5
5:
 %6 = load i32, i32* %2
 %7 = sext i32 %6 to i64
 %8 = icmp ult i64 %7, 7
 br i1 %8, label %9, label %26
9:
 %10 = load i32, i32* %2
 %11 = sext i32 %10 to i64
 %12 = getelementptr [7 x i8], i8* @a, i64 0, i64 %11
 %13 = load i8, i8* %12
 %14 = sext i8 %13 to i32
 %15 = load i32, i32* %2
 %16 = sext i32 %15 to i64
 %17 = getelementptr [7 x i8], i8* %3, i64 0, i64 %16
 %18 = load i8, i8* %17
 %19 = sext i8 %18 to i32
 %20 = icmp ne i32 %14, %19
 br i1 %20, label %21, label %22
21:
 call void @abort ()
 unreachable
22:
 br label %23
23:
 %24 = load i32, i32* %2
 %25 = add i32 %24, 1
 store i32 %25, i32* %2
 br label %5
26:
 ret i32 0
}
