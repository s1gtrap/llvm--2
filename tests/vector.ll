%struct.vector = type { i8, i32, i32 }

@__const.main.v1 = global %struct.vector {i8 97, i32 12, i32 34}
@__const.main.v2 = global %struct.vector {i8 97, i32 13, i32 37}
@.str = global [12 x i8] c"x=%d, y=%d\0A\00"
@.str.1 = global [4 x i8] c"%p\0A\00"

declare void @memcpy(i8*, i8*, i64, i1)
declare i32 @printf(i8*, ...)

define void @dot (i8* %0, i8* %1) {
 %3 = alloca i8*
 %4 = alloca i8*
 store i8* %0, i8** %3
 store i8* %1, i8** %4
 %5 = load i8*, i8** %4
 call void @printf (i8* @.str.1, i8* %5)
 %6 = getelementptr %struct.vector, i8* %5, i32 0, i32 1
 call void @printf (i8* @.str.1, i8* %6)
 %7 = load i32, i32* %6
 %8 = load i8*, i8** %3
 call void @printf (i8* @.str.1, i8* %8)
 %9 = getelementptr %struct.vector, i8* %8, i32 0, i32 1
 call void @printf (i8* @.str.1, i8* %9)
 %10 = load i32, i32* %9
 %11 = add i32 %10, %7
 store i32 %11, i32* %9
 %12 = load i8*, i8** %4
 call void @printf (i8* @.str.1, i8* %12)
 %13 = getelementptr %struct.vector, i8* %12, i32 0, i32 2
 call void @printf (i8* @.str.1, i8* %13)
 %14 = load i32, i32* %13
 %15 = load i8*, i8** %3
 call void @printf (i8* @.str.1, i8* %15)
 %16 = getelementptr %struct.vector, i8* %15, i32 0, i32 2
 call void @printf (i8* @.str.1, i8* %16)
 %17 = load i32, i32* %16
 %18 = add i32 %17, %14
 store i32 %18, i32* %16
 ret void
}

define i32 @main () {
 %1 = alloca %struct.vector
 %2 = alloca %struct.vector
 call void @memcpy (i8* %1, i8* @__const.main.v1, i64 12, i1 0)
 call void @memcpy (i8* %2, i8* @__const.main.v2, i64 12, i1 0)
 call void @dot (i8* %1, i8* %2)
 %3 = getelementptr %struct.vector, i8* %1, i32 0, i32 1
 %4 = load i32, i32* %3
 %5 = getelementptr %struct.vector, i8* %1, i32 0, i32 2
 %6 = load i32, i32* %5
 %7 = call i32 (i8*, ...) @printf (i8* @.str, i32 %4, i32 %6)
 ret i32 0
}
