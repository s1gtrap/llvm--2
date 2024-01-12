%struct.S = type { i32, [5 x i8] }

@__const.main.s = global %struct.S {i32 1, [5 x i8] c"\02\03\04\05\06"}

declare void @memcpy(i8*, i8*, i64, i1)
declare void @abort()

define i32 @foo (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 %3 = load i8*, i8** %2
 %4 = getelementptr i8, i8* %3, i64 0
 %5 = load i8, i8* %4
 %6 = zext i8 %5 to i32
 %7 = shl i32 %6, 24
 %8 = load i8*, i8** %2
 %9 = getelementptr i8, i8* %8, i64 1
 %10 = load i8, i8* %9
 %11 = zext i8 %10 to i32
 %12 = shl i32 %11, 16
 %13 = or i32 %7, %12
 %14 = load i8*, i8** %2
 %15 = getelementptr i8, i8* %14, i64 2
 %16 = load i8, i8* %15
 %17 = zext i8 %16 to i32
 %18 = shl i32 %17, 8
 %19 = or i32 %13, %18
 %20 = load i8*, i8** %2
 %21 = getelementptr i8, i8* %20, i64 3
 %22 = load i8, i8* %21
 %23 = zext i8 %22 to i32
 %24 = or i32 %19, %23
 ret i32 %24
}

define i32 @bar (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 %3 = load i8*, i8** %2
 %4 = getelementptr i8, i8* %3, i64 3
 %5 = load i8, i8* %4
 %6 = zext i8 %5 to i32
 %7 = shl i32 %6, 24
 %8 = load i8*, i8** %2
 %9 = getelementptr i8, i8* %8, i64 2
 %10 = load i8, i8* %9
 %11 = zext i8 %10 to i32
 %12 = shl i32 %11, 16
 %13 = or i32 %7, %12
 %14 = load i8*, i8** %2
 %15 = getelementptr i8, i8* %14, i64 1
 %16 = load i8, i8* %15
 %17 = zext i8 %16 to i32
 %18 = shl i32 %17, 8
 %19 = or i32 %13, %18
 %20 = load i8*, i8** %2
 %21 = getelementptr i8, i8* %20, i64 0
 %22 = load i8, i8* %21
 %23 = zext i8 %22 to i32
 %24 = or i32 %19, %23
 ret i32 %24
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca %struct.S
 store i32 0, i32* %1
 call void @memcpy (i8* %2, i8* @__const.main.s, i64 12, i1 0)
 %3 = getelementptr %struct.S, i8* %2, i32 0, i32 1
 %4 = getelementptr [5 x i8], i8* %3, i64 0, i64 1
 %5 = call i32 @foo (i8* %4)
 %6 = icmp ne i32 %5, 50595078
 br i1 %6, label %12, label %7
7:
 %8 = getelementptr %struct.S, i8* %2, i32 0, i32 1
 %9 = getelementptr [5 x i8], i8* %8, i64 0, i64 1
 %10 = call i32 @bar (i8* %9)
 %11 = icmp ne i32 %10, 100992003
 br i1 %11, label %12, label %13
12:
 call void @abort ()
 unreachable
13:
 ret i32 0
}
