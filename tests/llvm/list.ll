%struct.myList = type { %struct.myStruct, i8* }
%struct.myStruct = type { i32, i32 }

@array = global [192 x i32] [i32 103, i32 198, i32 105, i32 115, i32 81, i32 255, i32 74, i32 236, i32 41, i32 205, i32 186, i32 171, i32 242, i32 251, i32 227, i32 70, i32 124, i32 194, i32 84, i32 248, i32 27, i32 232, i32 231, i32 141, i32 118, i32 90, i32 46, i32 99, i32 51, i32 159, i32 201, i32 154, i32 102, i32 50, i32 13, i32 183, i32 49, i32 88, i32 163, i32 90, i32 37, i32 93, i32 5, i32 23, i32 88, i32 233, i32 94, i32 212, i32 171, i32 178, i32 205, i32 198, i32 155, i32 180, i32 84, i32 17, i32 14, i32 130, i32 116, i32 65, i32 33, i32 61, i32 220, i32 135, i32 112, i32 233, i32 62, i32 161, i32 65, i32 225, i32 252, i32 103, i32 62, i32 1, i32 126, i32 151, i32 234, i32 220, i32 107, i32 150, i32 143, i32 56, i32 92, i32 42, i32 236, i32 176, i32 59, i32 251, i32 50, i32 175, i32 60, i32 84, i32 236, i32 24, i32 219, i32 92, i32 2, i32 26, i32 254, i32 67, i32 251, i32 250, i32 170, i32 58, i32 251, i32 41, i32 209, i32 230, i32 5, i32 60, i32 124, i32 148, i32 117, i32 216, i32 190, i32 97, i32 137, i32 249, i32 92, i32 187, i32 168, i32 153, i32 15, i32 149, i32 177, i32 235, i32 241, i32 179, i32 5, i32 239, i32 247, i32 0, i32 233, i32 161, i32 58, i32 229, i32 202, i32 11, i32 203, i32 208, i32 72, i32 71, i32 100, i32 189, i32 31, i32 35, i32 30, i32 168, i32 28, i32 123, i32 100, i32 197, i32 20, i32 115, i32 90, i32 197, i32 94, i32 75, i32 121, i32 99, i32 59, i32 112, i32 100, i32 36, i32 17, i32 158, i32 9, i32 220, i32 170, i32 212, i32 172, i32 242, i32 27, i32 16, i32 175, i32 59, i32 51, i32 205, i32 227, i32 80, i32 72, i32 71, i32 21, i32 92, i32 187, i32 111, i32 34, i32 25, i32 186, i32 155, i32 125, i32 245]
@.str = global [35 x i8] c"error: i = %d, x = %d, array = %d\0A\00"
@.str.1 = global [42 x i8] c"error: i = %d, y = %hhd, expected = %hhd\0A\00"

declare i8* @malloc(i64)
declare i32 @printf(i8*, ...)
declare void @free(i8*)

define void @test () {
 %1 = alloca i32
 %2 = alloca i32
 %3 = alloca i8*
 %4 = alloca i8*
 %5 = alloca i8*
 store i32 0, i32* %1
 store i32 192, i32* %2
 store i8* null, i8** %3
 %6 = load i32, i32* %1
 br label %7
7:
 %8 = load i32, i32* %1
 %9 = load i32, i32* %2
 %10 = icmp ult i32 %8, %9
 br i1 %10, label %11, label %35
11:
 %12 = call i8* @malloc (i64 16)
 store i8* %12, i8** %4
 %13 = load i8*, i8** %3
 %14 = load i8*, i8** %4
 %15 = getelementptr %struct.myList, i8* %14, i32 0, i32 1
 store i8* %13, i8** %15
 %16 = load i8*, i8** %4
 store i8* %16, i8** %3
 %17 = load i32, i32* %1
 %18 = zext i32 %17 to i64
 %19 = getelementptr [192 x i32], i8* @array, i64 0, i64 %18
 %20 = load i32, i32* %19
 %21 = load i8*, i8** %4
 %22 = getelementptr %struct.myList, i8* %21, i32 0, i32 0
 %23 = getelementptr %struct.myStruct, i8* %22, i32 0, i32 0
 store i32 %20, i32* %23
 %24 = load i32, i32* %1
 %25 = zext i32 %24 to i64
 %26 = getelementptr [192 x i32], i8* @array, i64 0, i64 %25
 %27 = load i32, i32* %26
 %28 = sub i32 %27, 1
 %29 = load i8*, i8** %4
 %30 = getelementptr %struct.myList, i8* %29, i32 0, i32 0
 %31 = getelementptr %struct.myStruct, i8* %30, i32 0, i32 1
 store i32 %28, i32* %31
 br label %32
32:
 %33 = load i32, i32* %1
 %34 = add i32 %33, 1
 store i32 %34, i32* %1
 br label %7
35:
 store i32 0, i32* %1
 br label %36
36:
 %37 = load i8*, i8** %3
 %38 = icmp ne i8* %37, null
 br i1 %38, label %39, label %100
39:
 %40 = load i32, i32* %1
 %41 = add i32 %40, 1
 store i32 %41, i32* %1
 %42 = load i8*, i8** %3
 %43 = getelementptr %struct.myList, i8* %42, i32 0, i32 0
 %44 = getelementptr %struct.myStruct, i8* %43, i32 0, i32 0
 %45 = load i32, i32* %44
 %46 = load i32, i32* %1
 %47 = sub i32 192, %46
 %48 = zext i32 %47 to i64
 %49 = getelementptr [192 x i32], i8* @array, i64 0, i64 %48
 %50 = load i32, i32* %49
 %51 = icmp ne i32 %45, %50
 br i1 %51, label %52, label %64
52:
 %53 = load i32, i32* %1
 %54 = load i8*, i8** %3
 %55 = getelementptr %struct.myList, i8* %54, i32 0, i32 0
 %56 = getelementptr %struct.myStruct, i8* %55, i32 0, i32 0
 %57 = load i32, i32* %56
 %58 = load i32, i32* %1
 %59 = sub i32 192, %58
 %60 = zext i32 %59 to i64
 %61 = getelementptr [192 x i32], i8* @array, i64 0, i64 %60
 %62 = load i32, i32* %61
 %63 = call i32 (i8*, ...) @printf (i8* @.str, i32 %53, i32 %57, i32 %62)
 br label %64
64:
 %65 = load i8*, i8** %3
 %66 = getelementptr %struct.myList, i8* %65, i32 0, i32 0
 %67 = getelementptr %struct.myStruct, i8* %66, i32 0, i32 1
 %68 = load i32, i32* %67
 %69 = load i32, i32* %1
 %70 = sub i32 192, %69
 %71 = zext i32 %70 to i64
 %72 = getelementptr [192 x i32], i8* @array, i64 0, i64 %71
 %73 = load i32, i32* %72
 %74 = sub i32 %73, 1
 %75 = and i32 %74, 127
 %76 = xor i32 %68, %75
 %77 = icmp ne i32 %76, 0
 br i1 %77, label %78, label %94
78:
 %79 = load i32, i32* %1
 %80 = load i8*, i8** %3
 %81 = getelementptr %struct.myList, i8* %80, i32 0, i32 0
 %82 = getelementptr %struct.myStruct, i8* %81, i32 0, i32 1
 %83 = load i32, i32* %82
 %84 = trunc i32 %83 to i8
 %85 = zext i8 %84 to i32
 %86 = load i32, i32* %1
 %87 = sub i32 192, %86
 %88 = zext i32 %87 to i64
 %89 = getelementptr [192 x i32], i8* @array, i64 0, i64 %88
 %90 = load i32, i32* %89
 %91 = sub i32 %90, 1
 %92 = and i32 %91, 127
 %93 = call i32 (i8*, ...) @printf (i8* @.str.1, i32 %79, i32 %85, i32 %92)
 br label %94
94:
 %95 = load i8*, i8** %3
 store i8* %95, i8** %5
 %96 = load i8*, i8** %3
 %97 = getelementptr %struct.myList, i8* %96, i32 0, i32 1
 %98 = load i8*, i8** %97
 store i8* %98, i8** %3
 %99 = load i8*, i8** %5
 call void @free (i8* %99)
 br label %36
100:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @test ()
 ret i32 0
}
