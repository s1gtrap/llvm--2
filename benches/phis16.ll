@.str = global [4 x i8] c"%d\0A\00"
declare i32 @printf(i8*, ...)

define i32 @main() {
0:
  %1 = add i32 0, 1
  %2 = add i32 2, 3
  %3 = add i32 4, 5
  %4 = add i32 6, 7
  %5 = add i32 8, 9
  %6 = add i32 10, 11
  %7 = add i32 12, 13
  %8 = add i32 14, 15
  %9 = add i32 16, 17
  %10 = add i32 18, 19
  %11 = add i32 20, 21
  %12 = add i32 22, 23
  %13 = add i32 24, 25
  %14 = add i32 26, 27
  %15 = add i32 28, 29
  %16 = add i32 30, 31
  br label %17
17:
  %18 = phi i32 [0, %0], [%51, %17]
  %19 = phi i32 [%1, %0], [%19, %17]
  %20 = phi i32 [%2, %0], [%20, %17]
  %21 = phi i32 [%3, %0], [%21, %17]
  %22 = phi i32 [%4, %0], [%22, %17]
  %23 = phi i32 [%5, %0], [%23, %17]
  %24 = phi i32 [%6, %0], [%24, %17]
  %25 = phi i32 [%7, %0], [%25, %17]
  %26 = phi i32 [%8, %0], [%26, %17]
  %27 = phi i32 [%9, %0], [%27, %17]
  %28 = phi i32 [%10, %0], [%28, %17]
  %29 = phi i32 [%11, %0], [%29, %17]
  %30 = phi i32 [%12, %0], [%30, %17]
  %31 = phi i32 [%13, %0], [%31, %17]
  %32 = phi i32 [%14, %0], [%32, %17]
  %33 = phi i32 [%15, %0], [%33, %17]
  %34 = phi i32 [%16, %0], [%34, %17]
;  call void @printf (i8* @.str, i32 %19)
;  call void @printf (i8* @.str, i32 %20)
;  call void @printf (i8* @.str, i32 %21)
;  call void @printf (i8* @.str, i32 %22)
;  call void @printf (i8* @.str, i32 %23)
;  call void @printf (i8* @.str, i32 %24)
;  call void @printf (i8* @.str, i32 %25)
;  call void @printf (i8* @.str, i32 %26)
;  call void @printf (i8* @.str, i32 %27)
;  call void @printf (i8* @.str, i32 %28)
;  call void @printf (i8* @.str, i32 %29)
;  call void @printf (i8* @.str, i32 %30)
;  call void @printf (i8* @.str, i32 %31)
;  call void @printf (i8* @.str, i32 %32)
;  call void @printf (i8* @.str, i32 %33)
;  call void @printf (i8* @.str, i32 %34)
  %35 = add i32 %19, %34
  %36 = add i32 %20, %33
  %37 = add i32 %21, %32
  %38 = add i32 %22, %31
  %39 = add i32 %23, %30
  %40 = add i32 %24, %29
  %41 = add i32 %25, %28
  %42 = add i32 %26, %27
  %43 = add i32 %27, %26
  %44 = add i32 %28, %25
  %45 = add i32 %29, %24
  %46 = add i32 %30, %23
  %47 = add i32 %31, %22
  %48 = add i32 %32, %21
  %49 = add i32 %33, %20
  %50 = add i32 %34, %19
;  call void @printf (i8* @.str, i32 %35)
;  call void @printf (i8* @.str, i32 %36)
;  call void @printf (i8* @.str, i32 %37)
;  call void @printf (i8* @.str, i32 %38)
;  call void @printf (i8* @.str, i32 %39)
;  call void @printf (i8* @.str, i32 %40)
;  call void @printf (i8* @.str, i32 %41)
;  call void @printf (i8* @.str, i32 %42)
;  call void @printf (i8* @.str, i32 %43)
;  call void @printf (i8* @.str, i32 %44)
;  call void @printf (i8* @.str, i32 %45)
;  call void @printf (i8* @.str, i32 %46)
;  call void @printf (i8* @.str, i32 %47)
;  call void @printf (i8* @.str, i32 %48)
;  call void @printf (i8* @.str, i32 %49)
;  call void @printf (i8* @.str, i32 %50)
  %51 = add i32 %18, 1
  %52 = icmp eq i32 %51, 65535
  br i1 %52, label %53, label %17
53:
  ret i32 0
}
