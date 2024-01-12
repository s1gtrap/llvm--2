@u = global i32 0

declare void @abort()

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i16 @foo (i8* @u)
 %3 = zext i16 %2 to i32
 %4 = and i32 %3, 32768
 %5 = icmp ne i32 %4, 0
 br i1 %5, label %6, label %7
6:
 call void @abort ()
 unreachable
7:
 ret i32 0
}

define i16 @foo (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 %3 = load i8*, i8** %2
 %4 = load i32, i32* %3
 %5 = trunc i32 %4 to i16
 ret i16 %5
}
