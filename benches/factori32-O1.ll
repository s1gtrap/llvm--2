@.str = global [3 x i8] c"2 \00"
@.str.1 = global [4 x i8] c"%i \00"

declare i32 @printf(i8*, ...)
declare i32 @atoi(i8*)

define i32 @fac (i32 %0) {
1:
 %2 = and i32 %0, 1
 %3 = icmp eq i32 %2, 0
 br i1 %3, label %8, label %4
4:
 %5 = phi i32 [%0, %1], [%12, %8]
 %6 = phi i32 [0, %1], [%13, %8]
 %7 = icmp slt i32 %5, 9
 br i1 %7, label %22, label %16
8:
 %9 = phi i32 [%13, %8], [0, %1]
 %10 = phi i32 [%12, %8], [%0, %1]
 %11 = call i32 (i8*, ...) @printf (i8* @.str)
 %12 = sdiv i32 %10, 2
 %13 = add i32 %9, 1
 %14 = and i32 %12, 1
 %15 = icmp eq i32 %14, 0
 br i1 %15, label %8, label %4
16:
 %17 = phi i32 [%37, %34], [3, %4]
 %18 = phi i32 [%36, %34], [%6, %4]
 %19 = phi i32 [%35, %34], [%5, %4]
 %20 = srem i32 %19, %17
 %21 = icmp eq i32 %20, 0
 br i1 %21, label %26, label %34
22:
 %23 = phi i32 [%5, %4], [%35, %34]
 %24 = phi i32 [%6, %4], [%36, %34]
 %25 = icmp sgt i32 %23, 2
 br i1 %25, label %40, label %43
26:
 %27 = phi i32 [%31, %26], [%18, %16]
 %28 = phi i32 [%30, %26], [%19, %16]
 %29 = call i32 (i8*, ...) @printf (i8* @.str.1, i32 %17)
 %30 = sdiv i32 %28, %17
 %31 = add i32 %27, 1
 %32 = srem i32 %30, %17
 %33 = icmp eq i32 %32, 0
 br i1 %33, label %26, label %34
34:
 %35 = phi i32 [%19, %16], [%30, %26]
 %36 = phi i32 [%18, %16], [%31, %26]
 %37 = add i32 %17, 2
 %38 = mul i32 %37, %37
 %39 = icmp sgt i32 %38, %35
 br i1 %39, label %22, label %16
40:
 %41 = call i32 (i8*, ...) @printf (i8* @.str.1, i32 %23)
 %42 = add i32 %24, 1
 br label %43
43:
 %44 = phi i32 [%42, %40], [%24, %22]
 ret i32 %44
}

define i32 @main (i32 %0, i8* %1) {
2:
 %3 = getelementptr i8*, i8* %1, i64 1
 %4 = load i8*, i8** %3
 %5 = call i32 @atoi (i8* %4)
 %6 = and i32 %5, 1
 %7 = icmp eq i32 %6, 0
 br i1 %7, label %12, label %8
8:
 %9 = phi i32 [%5, %2], [%16, %12]
 %10 = phi i32 [0, %2], [%17, %12]
 %11 = icmp slt i32 %9, 9
 br i1 %11, label %26, label %20
12:
 %13 = phi i32 [%17, %12], [0, %2]
 %14 = phi i32 [%16, %12], [%5, %2]
 %15 = call i32 (i8*, ...) @printf (i8* @.str)
 %16 = sdiv i32 %14, 2
 %17 = add i32 %13, 1
 %18 = and i32 %16, 1
 %19 = icmp eq i32 %18, 0
 br i1 %19, label %12, label %8
20:
 %21 = phi i32 [%41, %38], [3, %8]
 %22 = phi i32 [%40, %38], [%10, %8]
 %23 = phi i32 [%39, %38], [%9, %8]
 %24 = srem i32 %23, %21
 %25 = icmp eq i32 %24, 0
 br i1 %25, label %30, label %38
26:
 %27 = phi i32 [%9, %8], [%39, %38]
 %28 = phi i32 [%10, %8], [%40, %38]
 %29 = icmp sgt i32 %27, 2
 br i1 %29, label %44, label %47
30:
 %31 = phi i32 [%35, %30], [%22, %20]
 %32 = phi i32 [%34, %30], [%23, %20]
 %33 = call i32 (i8*, ...) @printf (i8* @.str.1, i32 %21)
 %34 = sdiv i32 %32, %21
 %35 = add i32 %31, 1
 %36 = srem i32 %34, %21
 %37 = icmp eq i32 %36, 0
 br i1 %37, label %30, label %38
38:
 %39 = phi i32 [%23, %20], [%34, %30]
 %40 = phi i32 [%22, %20], [%35, %30]
 %41 = add i32 %21, 2
 %42 = mul i32 %41, %41
 %43 = icmp sgt i32 %42, %39
 br i1 %43, label %26, label %20
44:
 %45 = call i32 (i8*, ...) @printf (i8* @.str.1, i32 %27)
 %46 = add i32 %28, 1
 br label %47
47:
 %48 = phi i32 [%46, %44], [%28, %26]
 ret i32 %48
}
