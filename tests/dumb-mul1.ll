declare i32 @atoi(i8*)

define i32 @add (i32 %0, i32 %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i32
 store i32 %0, i32* %3
 store i32 %1, i32* %4
 %6 = load i32, i32* %3
 %7 = load i32, i32* %4
 %8 = add i32 %6, %7
 store i32 %8, i32* %5
 %9 = load i32, i32* %5
 ret i32 %9
}

define i32 @mul (i32 %0, i32 %1) {
2:
 %3 = icmp sgt i32 %0, 0
 br i1 %3, label %6, label %4
4:
 %5 = phi i32 [0, %2], [%9, %6]
 ret i32 %5
6:
 %7 = phi i32 [%10, %6], [0, %2]
 %8 = phi i32 [%9, %6], [0, %2]
 %9 = call i32 @add (i32 %8, i32 %1)
 %10 = add i32 %7, 1
 %11 = icmp eq i32 %10, %0
 br i1 %11, label %4, label %6
}

define i32 @main(i32 %0, i8* %1) {
 %3 = getelementptr i8*, i8** %1, i64 1
 %4 = load i8*, i8** %3
 %5 = call i32 @atoi (i8* %4)
 %6 = getelementptr i8*, i8** %1, i64 2
 %7 = load i8*, i8** %6
 %8 = call i32 @atoi (i8* %7)
 %9 = call i32 @mul (i32 %5, i32 %8)
 ret i32 %9
}
