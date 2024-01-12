%struct.List = type { i8*, i32 }

@Node0 = global %struct.List {i8* null, i32 5}
@Node1 = global %struct.List {i8* @Node0, i32 4}
@Node2 = global %struct.List {i8* @Node1, i32 3}
@Node3 = global %struct.List {i8* @Node2, i32 2}
@Node4 = global %struct.List {i8* @Node3, i32 1}
@Node5 = global %struct.List {i8* @Node4, i32 0}
@.str = global [7 x i8] c"%d %d\0A\00"

declare i32 @printf(i8*, ...)

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i8*
 %3 = alloca i8*
 store i32 0, i32* %1
 store i8* null, i8** %2
 store i8* @Node5, i8** %3
 br label %4
4:
 %5 = load i8*, i8** %3
 %6 = icmp ne i8* %5, null
 br i1 %6, label %7, label %26
7:
 %8 = load i8*, i8** %3
 %9 = getelementptr %struct.List, i8* %8, i32 0, i32 1
 %10 = load i32, i32* %9
 %11 = load i8*, i8** %2
 %12 = icmp ne i8* %11, null
 br i1 %12, label %13, label %17
13:
 %14 = load i8*, i8** %2
 %15 = getelementptr %struct.List, i8* %14, i32 0, i32 1
 %16 = load i32, i32* %15
 br label %18
17:
 br label %18
18:
 %19 = phi i32 [%16, %13], [-1, %17]
 %20 = call i32 (i8*, ...) @printf (i8* @.str, i32 %10, i32 %19)
 br label %21
21:
 %22 = load i8*, i8** %3
 store i8* %22, i8** %2
 %23 = load i8*, i8** %3
 %24 = getelementptr %struct.List, i8* %23, i32 0, i32 0
 %25 = load i8*, i8** %24
 store i8* %25, i8** %3
 br label %4
26:
 ret i32 0
}
