%struct.myStruct = type { i32, i32 }

@.str = global [7 x i8] c"error\0A\00"

declare i8* @malloc(i64)
declare void @free(i8*)
declare i32 @printf(i8*, ...)

define void @mem_test (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 store i32 %0, i32* %2
 %6 = load i32, i32* %2
 store i32 %6, i32* %3
 store i32 0, i32* %4
 %7 = load i32, i32* %3
 %8 = sext i32 %7 to i64
 %9 = mul i64 4, %8
 %10 = call i8* @malloc (i64 %9)
 store i8* %10, i8** %5
 store i32 0, i32* %4
 br label %11
11:
 %12 = load i32, i32* %4
 %13 = load i32, i32* %2
 %14 = icmp ult i32 %12, %13
 br i1 %14, label %15, label %24
15:
 %16 = load i32, i32* %4
 %17 = load i8*, i8** %5
 %18 = load i32, i32* %4
 %19 = zext i32 %18 to i64
 %20 = getelementptr i32, i8* %17, i64 %19
 store i32 %16, i32* %20
 br label %21
21:
 %22 = load i32, i32* %4
 %23 = add i32 %22, 1
 store i32 %23, i32* %4
 br label %11
24:
 %25 = load i8*, i8** %5
 call void @free (i8* %25)
 ret void
}

define void @mem_test2 () {
 %1 = alloca i8*
 %2 = call i8* @malloc (i64 8)
 store i8* %2, i8** %1
 %3 = load i8*, i8** %1
 %4 = getelementptr %struct.myStruct, i8* %3, i32 0, i32 1
 store i32 0, i32* %4
 %5 = load i8*, i8** %1
 %6 = getelementptr %struct.myStruct, i8* %5, i32 0, i32 1
 %7 = load i32, i32* %6
 %8 = icmp ne i32 %7, 0
 br i1 %8, label %9, label %11
9:
 %10 = call i32 (i8*, ...) @printf (i8* @.str)
 br label %11
11:
 %12 = load i8*, i8** %1
 %13 = getelementptr %struct.myStruct, i8* %12, i32 0, i32 1
 %14 = load i32, i32* %13
 %15 = add i32 %14, 1
 store i32 %15, i32* %13
 %16 = load i8*, i8** %1
 %17 = getelementptr %struct.myStruct, i8* %16, i32 0, i32 0
 store i32 %15, i32* %17
 %18 = load i8*, i8** %1
 %19 = getelementptr %struct.myStruct, i8* %18, i32 0, i32 0
 %20 = load i32, i32* %19
 %21 = mul i32 %20, 2
 store i32 %21, i32* %19
 %22 = load i8*, i8** %1
 %23 = getelementptr %struct.myStruct, i8* %22, i32 0, i32 0
 %24 = load i32, i32* %23
 %25 = load i8*, i8** %1
 %26 = getelementptr %struct.myStruct, i8* %25, i32 0, i32 1
 %27 = load i32, i32* %26
 %28 = sub i32 %24, %27
 %29 = icmp ne i32 %28, 1
 br i1 %29, label %30, label %32
30:
 %31 = call i32 (i8*, ...) @printf (i8* @.str)
 br label %32
32:
 %33 = load i8*, i8** %1
 call void @free (i8* %33)
 ret void
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @mem_test (i32 255)
 call void @mem_test2 ()
 ret i32 0
}
