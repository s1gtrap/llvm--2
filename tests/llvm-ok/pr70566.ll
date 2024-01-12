%struct.mystruct = type { i8, [3 x i8] }

declare void @abort()

define void @myfunc (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i8*
 store i32 %0, i32* %3
 store i8* %1, i8** %4
 ret void
}

define i32 @myfunc2 (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 ret i32 0
}

define void @foo (i8* %0) {
 %2 = alloca i8*
 %3 = alloca i8*
 store i8* %0, i8** %2
 %4 = load i8*, i8** %2
 store i8* %4, i8** %3
 %5 = load i8*, i8** %3
 %6 = load i8, i8* %5
 %7 = lshr i8 %6, 1
 %8 = and i8 %7, 1
 %9 = zext i8 %8 to i32
 %10 = icmp ne i32 %9, 0
 br i1 %10, label %13, label %11
11:
 %12 = load i8*, i8** %3
 call void @set_f2 (i8* %12, i32 1)
 br label %13
13:
 ret void
}

define void @set_f2 (i8* %0, i32 %1) {
 %3 = alloca i8*
 %4 = alloca i32
 store i8* %0, i8** %3
 store i32 %1, i32* %4
 %5 = load i8*, i8** %3
 %6 = load i8, i8* %5
 %7 = lshr i8 %6, 1
 %8 = and i8 %7, 1
 %9 = zext i8 %8 to i32
 %10 = load i32, i32* %4
 %11 = icmp ne i32 %9, %10
 br i1 %11, label %12, label %14
12:
 %13 = call i32 @myfunc2 (i8* null)
 call void @myfunc (i32 %13, i8* null)
 br label %15
14:
 call void @abort ()
 unreachable
15:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca %struct.mystruct
 store i32 0, i32* %1
 %3 = load i8, i8* %2
 %4 = and i8 %3, -2
 %5 = or i8 %4, 1
 store i8 %5, i8* %2
 %6 = load i8, i8* %2
 %7 = and i8 %6, -3
 %8 = or i8 %7, 0
 store i8 %8, i8* %2
 call void @foo (i8* %2)
 ret i32 0
}
