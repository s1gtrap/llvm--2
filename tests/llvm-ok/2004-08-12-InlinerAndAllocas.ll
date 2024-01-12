@.str = global [4 x i8] c"%d\0A\00"

declare i32 @printf(i8*, ...)
declare i32 @__sprintf_chk(i8*, i32, i64, i8*, ...)
declare i64 @llvm.objectsize.i64.p0(i8*, i1, i1, i1)

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 %3 = alloca i32
 store i32 0, i32* %1
 store i32 0, i32* %3
 store i32 0, i32* %2
 br label %4
4:
 %5 = load i32, i32* %2
 %6 = icmp slt i32 %5, 10000
 br i1 %6, label %7, label %15
7:
 %8 = load i32, i32* %2
 %9 = call i32 @Callee (i32 %8)
 %10 = load i32, i32* %3
 %11 = add i32 %10, %9
 store i32 %11, i32* %3
 br label %12
12:
 %13 = load i32, i32* %2
 %14 = add i32 %13, 1
 store i32 %14, i32* %2
 br label %4
15:
 %16 = load i32, i32* %3
 %17 = call i32 (i8*, ...) @printf (i8* @.str, i32 %16)
 ret i32 0
}

define i32 @Callee (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 %4 = alloca i8*
 store i32 %0, i32* %3
 %5 = load i32, i32* %3
 %6 = icmp ne i32 %5, 0
 br i1 %6, label %7, label %18
7:
 %8 = alloca i8, i64 1000
 store i8* %8, i8** %4
 %9 = load i8*, i8** %4
 %10 = load i8*, i8** %4
 %11 = call i64 @llvm.objectsize.i64.p0 (i8* %10, i1 0, i1 1, i1 0)
 %12 = load i32, i32* %3
 %13 = call i32 (i8*, i32, i64, i8*, ...) @__sprintf_chk (i8* %9, i32 0, i64 %11, i8* @.str, i32 %12)
 %14 = load i8*, i8** %4
 %15 = getelementptr i8, i8* %14, i64 0
 %16 = load i8, i8* %15
 %17 = sext i8 %16 to i32
 store i32 %17, i32* %2
 br label %19
18:
 store i32 0, i32* %2
 br label %19
19:
 %20 = load i32, i32* %2
 ret i32 %20
}
