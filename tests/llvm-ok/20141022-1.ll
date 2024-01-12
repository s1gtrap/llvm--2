@.str = global [9 x i8] c"assert.\0A\00"

declare i32 @printf(i8*, ...)
declare void @abort()

define i32 @f (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 %4 = alloca i32
 store i32 %0, i32* %2
 %5 = load i32, i32* %2
 %6 = sext i32 %5 to i64
 %7 = and i64 %6, 4294967291
 %8 = trunc i64 %7 to i32
 store i32 %8, i32* %4
 %9 = load i32, i32* %2
 %10 = icmp eq i32 %9, 6
 %11 = zext i1 %10 to i64
 %12 = select i1 %10, i32 0, i32 15
 store i32 %12, i32* %3
 %13 = load i32, i32* %4
 %14 = icmp ne i32 %13, 1
 br i1 %14, label %15, label %17
15:
 %16 = load i32, i32* %3
 br label %18
17:
 br label %18
18:
 %19 = phi i32 [%16, %15], [0, %17]
 store i32 %19, i32* %3
 %20 = load i32, i32* %3
 ret i32 %20
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @f (i32 0)
 %3 = icmp ne i32 %2, 15
 br i1 %3, label %4, label %8
4:
 br label %5
5:
 %6 = call i32 (i8*, ...) @printf (i8* @.str)
 call void @abort ()
 unreachable
7:
 br label %8
8:
 %9 = call i32 @f (i32 1)
 %10 = icmp ne i32 %9, 0
 br i1 %10, label %11, label %15
11:
 br label %12
12:
 %13 = call i32 (i8*, ...) @printf (i8* @.str)
 call void @abort ()
 unreachable
14:
 br label %15
15:
 %16 = call i32 @f (i32 6)
 %17 = icmp ne i32 %16, 0
 br i1 %17, label %18, label %22
18:
 br label %19
19:
 %20 = call i32 (i8*, ...) @printf (i8* @.str)
 call void @abort ()
 unreachable
21:
 br label %22
22:
 %23 = call i32 @f (i32 5)
 %24 = icmp ne i32 %23, 0
 br i1 %24, label %25, label %29
25:
 br label %26
26:
 %27 = call i32 (i8*, ...) @printf (i8* @.str)
 call void @abort ()
 unreachable
28:
 br label %29
29:
 %30 = call i32 @f (i32 15)
 %31 = icmp ne i32 %30, 15
 br i1 %31, label %32, label %36
32:
 br label %33
33:
 %34 = call i32 (i8*, ...) @printf (i8* @.str)
 call void @abort ()
 unreachable
35:
 br label %36
36:
 ret i32 0
}
