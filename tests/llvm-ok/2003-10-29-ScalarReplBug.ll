%struct.data = type { [80 x i8], i32, i32 }

@.str = global [4 x i8] c"%u\0A\00"

declare i32 @printf(i8*, ...)

define i32 @main () {
 %1 = alloca i32
 %2 = alloca %struct.data
 store i32 0, i32* %1
 %3 = getelementptr %struct.data, i8* %2, i32 0, i32 2
 store i32 0, i32* %3
 call void @iter (i8* @callback, i8* %2)
 ret i32 0
}

define void @iter (i8* %0, i8* %1) {
 %3 = alloca i8*
 %4 = alloca i8*
 store i8* %0, i8** %3
 store i8* %1, i8** %4
 %5 = load i8*, i8** %3
 %6 = load i8*, i8** %4
 %7 = call i32 %5 (i8* %6)
 ret void
}

define i32 @callback (i8* %0) {
 %2 = alloca i8*
 %3 = alloca i8*
 store i8* %0, i8** %2
 %4 = load i8*, i8** %2
 store i8* %4, i8** %3
 %5 = load i8*, i8** %3
 %6 = getelementptr %struct.data, i8* %5, i32 0, i32 2
 %7 = load i32, i32* %6
 %8 = call i32 (i8*, ...) @printf (i8* @.str, i32 %7)
 %9 = load i8*, i8** %3
 %10 = getelementptr %struct.data, i8* %9, i32 0, i32 2
 %11 = load i32, i32* %10
 %12 = icmp eq i32 %11, 0
 %13 = zext i1 %12 to i32
 ret i32 %13
}
