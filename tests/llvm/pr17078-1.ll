declare void @abort()

define void @test (i8* %0) {
 %2 = alloca i8*
 %3 = alloca i32
 store i8* %0, i8** %2
 store i32 1, i32* %3
 br label %6
4:
 br i1 0, label %5, label %7
5:
 br label %6
6:
 store i32 0, i32* %3
 br label %8
7:
 store i32 1, i32* %3
 br label %8
8:
 %9 = load i32, i32* %3
 %10 = load i8*, i8** %2
 store i32 %9, i32* %10
 ret void
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 store i32 0, i32* %1
 store i32 1, i32* %2
 call void @test (i8* %2)
 %3 = load i32, i32* %2
 %4 = icmp ne i32 %3, 0
 br i1 %4, label %5, label %6
5:
 call void @abort ()
 unreachable
6:
 ret i32 0
}
