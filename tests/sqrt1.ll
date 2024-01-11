declare i32 @atoi(i8*)

define i32 @isqrt (i32 %0) {
1:
 %2 = icmp ult i32 %0, 2
 br i1 %2, label %10, label %3
3:
 %4 = icmp slt i32 %0, 1
 br i1 %4, label %10, label %5
5:
 %6 = phi i32 [%7, %5], [1, %3]
 %7 = add i32 %6, 1
 %8 = mul i32 %7, %7
 %9 = icmp sgt i32 %8, %0
 br i1 %9, label %10, label %5
10:
 %11 = phi i32 [%0, %1], [0, %3], [%6, %5]
 ret i32 %11
}

define i32 @main (i32 %0, i8* %1) {
 %3 = getelementptr i8*, i8* %1, i64 1
 %4 = load i8*, i8** %3
 %5 = call i32 @atoi (i8* %4)
 %6 = icmp ult i32 %5, 2
 br i1 %6, label %14, label %7
7:
 %8 = icmp slt i32 %5, 1
 br i1 %8, label %14, label %9
9:
 %10 = phi i32 [%11, %9], [1, %7]
 %11 = add i32 %10, 1
 %12 = mul i32 %11, %11
 %13 = icmp sgt i32 %12, %5
 br i1 %13, label %14, label %9
14:
 %15 = phi i32 [%5, %2], [0, %7], [%10, %9]
 ret i32 %15
}
