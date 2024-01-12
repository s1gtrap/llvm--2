%struct.container = type { [1 x i8] }

@space = global [6 x i8] c"\01\02\03\04\05\06"

declare void @abort()

define i32 @foo (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 %3 = load i8*, i8** %2
 %4 = getelementptr %struct.container, i8* %3, i32 0, i32 0
 %5 = getelementptr [1 x i8], i8* %4, i64 0, i64 4
 %6 = load i8, i8* %5
 %7 = zext i8 %6 to i32
 ret i32 %7
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @foo (i8* @space)
 %3 = icmp ne i32 %2, 5
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 ret i32 0
}
