@.str = global [2 x i8] c"\0A\00"

define void @big (i64 %0) {
 %2 = alloca i64
 store i64 %0, i64* %2
 ret void
}

define void @doit (i32 %0, i32 %1, i8* %2) {
 %4 = alloca i32
 %5 = alloca i32
 %6 = alloca i8*
 store i32 %0, i32* %4
 store i32 %1, i32* %5
 store i8* %2, i8** %6
 %7 = load i8*, i8** %6
 %8 = load i8, i8* %7
 %9 = sext i8 %8 to i64
 call void @big (i64 %9)
 %10 = load i32, i32* %4
 %11 = zext i32 %10 to i64
 call void @big (i64 %11)
 %12 = load i32, i32* %5
 %13 = zext i32 %12 to i64
 call void @big (i64 %13)
 ret void
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @doit (i32 1, i32 1, i8* @.str)
 ret i32 0
}
