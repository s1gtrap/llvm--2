declare i64 @strtoull(i8*, i8*, i32)

define i32 @main (i32 %0, i8* %1) {
2:
 %3 = getelementptr i8*, i8* %1, i64 1
 %4 = load i8*, i8** %3
 %5 = call i64 @strtoull (i8* %4, i8* null, i32 10)
 %6 = icmp eq i64 %5, 0
 br i1 %6, label %7, label %8
7:
 ret i32 0
8:
 %9 = phi i64 [%10, %8], [0, %2]
 %10 = add i64 %9, 1
 %11 = icmp eq i64 %9, %5
 br i1 %11, label %7, label %8
}
