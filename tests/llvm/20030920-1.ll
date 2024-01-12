@.str = global [3 x i8] c"\FF\00"

declare void @abort()

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 %3 = alloca i8*
 %4 = alloca i8*
 store i32 0, i32* %1
 store i32 0, i32* %2
 store i8* @.str, i8** %4
 %5 = load i8*, i8** %4
 store i8* %5, i8** %3
 br label %6
6:
 %7 = load i8*, i8** %3
 %8 = load i8, i8* %7
 %9 = icmp ne i8 %8, 0
 br i1 %9, label %10, label %22
10:
 %11 = load i8*, i8** %3
 %12 = load i8, i8* %11
 %13 = zext i8 %12 to i32
 %14 = icmp ult i32 %13, 128
 br i1 %14, label %18, label %15
15:
 %16 = load i32, i32* %2
 %17 = add i32 %16, 1
 store i32 %17, i32* %2
 br label %18
18:
 br label %19
19:
 %20 = load i8*, i8** %3
 %21 = getelementptr i8, i8* %20, i32 1
 store i8* %21, i8** %3
 br label %6
22:
 %23 = load i32, i32* %2
 %24 = icmp ne i32 %23, 1
 br i1 %24, label %25, label %26
25:
 call void @abort ()
 unreachable
26:
 ret i32 0
}
