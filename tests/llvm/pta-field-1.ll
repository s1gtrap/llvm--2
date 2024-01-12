%struct.Foo = type { i8*, i8* }

declare void @abort()

define void @bar (i8* %0) {
 %2 = alloca i8*
 %3 = alloca i8*
 store i8* %0, i8** %2
 %4 = load i8*, i8** %2
 store i8* %4, i8** %3
 %5 = load i8*, i8** %3
 %6 = getelementptr %struct.Foo, i8* %5, i32 0, i32 1
 %7 = load i8*, i8** %6
 store i32 0, i32* %7
 ret void
}

define i32 @foo () {
 %1 = alloca %struct.Foo
 %2 = alloca i32
 %3 = alloca i32
 store i32 1, i32* %2
 store i32 2, i32* %3
 %4 = getelementptr %struct.Foo, i8* %1, i32 0, i32 0
 store i8* %2, i8** %4
 %5 = getelementptr %struct.Foo, i8* %1, i32 0, i32 1
 store i8* %3, i8** %5
 %6 = getelementptr %struct.Foo, i8* %1, i32 0, i32 0
 call void @bar (i8* %6)
 %7 = load i32, i32* %3
 ret i32 %7
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @foo ()
 %3 = icmp ne i32 %2, 0
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 ret i32 0
}
