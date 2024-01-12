%struct.s = type { i32, i8* }

@.str = global [10 x i8] c"hey there\00"

declare void @abort()
declare void @exit(i32)

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 %3 = alloca i8*
 %4 = alloca %struct.s
 store i32 0, i32* %1
 store i32 0, i32* %2
 br label %5
5:
 %6 = load i32, i32* %2
 %7 = icmp slt i32 %6, 4
 br i1 %7, label %8, label %28
8:
 %9 = getelementptr %struct.s, i8* %4, i32 0, i32 0
 store i32 3, i32* %9
 %10 = getelementptr %struct.s, i8* %4, i32 0, i32 1
 store i8* @.str, i8** %10
 store i8* %4, i8** %3
 %11 = load i8*, i8** %3
 %12 = getelementptr %struct.s, i8* %11, i32 0, i32 0
 %13 = load i32, i32* %12
 %14 = icmp ne i32 %13, 3
 br i1 %14, label %15, label %16
15:
 call void @abort ()
 unreachable
16:
 %17 = load i8*, i8** %3
 %18 = getelementptr %struct.s, i8* %17, i32 0, i32 0
 store i32 4, i32* %18
 %19 = load i8*, i8** %3
 %20 = getelementptr %struct.s, i8* %19, i32 0, i32 0
 %21 = load i32, i32* %20
 %22 = icmp ne i32 %21, 4
 br i1 %22, label %23, label %24
23:
 call void @abort ()
 unreachable
24:
 br label %25
25:
 %26 = load i32, i32* %2
 %27 = add i32 %26, 1
 store i32 %27, i32* %2
 br label %5
28:
 call void @exit (i32 0)
 unreachable
}
