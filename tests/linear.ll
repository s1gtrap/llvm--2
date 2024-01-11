@.str = global [28 x i8] c"*%p = \22%s\22\0Aatoi(\22%s\22) = %d\0A\00"
@.str.1 = global [11 x i8] c"%d = %lld\0A\00"
@.str.2 = global [24 x i8] c"%d = floor(sqrt(%lld))\0A\00"

declare i32 @atoi(i8*)
declare i32 @printf(i8*, ...)
declare i64 @strtoll(i8*, i8**, i32)

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
  %3 = getelementptr i8*, i8** %1, i64 1
  %4 = load i8*, i8** %3
  %5 = call i32 @atoi (i8* %4)
  call i32 @printf (i8* @.str, i8** %3, i8* %4, i8* %4, i32 %5)
  %7 = call i32 @isqrt (i32 %5)
  %8 = call i64 @strtoll (i8* %4, i8* null, i32 10)
  call i32 @printf (i8* @.str.1, i32 %5, i64 %8)
  call i32 @printf (i8* @.str.2, i32 %7, i32 %5)
  ret i32 %5
}
