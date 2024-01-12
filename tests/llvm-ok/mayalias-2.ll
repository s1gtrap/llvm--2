%struct.test = type { i16 }

declare void @abort()

define i32 @f () {
 %1 = alloca i32
 %2 = alloca i8*
 store i32 10, i32* %1
 store i8* %1, i8** %2
 %3 = load i8*, i8** %2
 %4 = getelementptr %struct.test, i8* %3, i32 0, i32 0
 store i16 1, i16* %4
 %5 = load i32, i32* %1
 ret i32 %5
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @f ()
 %3 = icmp eq i32 %2, 10
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 ret i32 0
}
