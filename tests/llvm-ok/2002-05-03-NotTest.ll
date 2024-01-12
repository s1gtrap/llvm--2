@.str = global [26 x i8] c"Bitwise Not: %d %d %d %d\0A\00"
@.str.1 = global [32 x i8] c"Boolean Not: %d %d %d %d %d %d\0A\00"

declare i32 @printf(i8*, ...)

define void @testBitWiseNot (i32 %0, i32 %1, i32 %2, i32 %3) {
 %5 = alloca i32
 %6 = alloca i32
 %7 = alloca i32
 %8 = alloca i32
 store i32 %0, i32* %5
 store i32 %1, i32* %6
 store i32 %2, i32* %7
 store i32 %3, i32* %8
 %9 = load i32, i32* %5
 %10 = xor i32 %9, -1
 %11 = load i32, i32* %6
 %12 = xor i32 %11, -1
 %13 = load i32, i32* %7
 %14 = xor i32 %13, -1
 %15 = load i32, i32* %8
 %16 = xor i32 %15, -1
 %17 = call i32 (i8*, ...) @printf (i8* @.str, i32 %10, i32 %12, i32 %14, i32 %16)
 ret void
}

define void @testBooleanNot (i32 %0, i32 %1, i32 %2, i32 %3) {
 %5 = alloca i32
 %6 = alloca i32
 %7 = alloca i32
 %8 = alloca i32
 store i32 %0, i32* %5
 store i32 %1, i32* %6
 store i32 %2, i32* %7
 store i32 %3, i32* %8
 %9 = load i32, i32* %5
 %10 = icmp sgt i32 %9, 0
 br i1 %10, label %11, label %14
11:
 %12 = load i32, i32* %6
 %13 = icmp sgt i32 %12, 0
 br label %14
14:
 %15 = phi i1 [0, %4], [%13, %11]
 %16 = xor i1 %15, 1
 %17 = zext i1 %16 to i32
 %18 = load i32, i32* %5
 %19 = icmp sgt i32 %18, 0
 br i1 %19, label %20, label %23
20:
 %21 = load i32, i32* %7
 %22 = icmp sgt i32 %21, 0
 br label %23
23:
 %24 = phi i1 [0, %14], [%22, %20]
 %25 = xor i1 %24, 1
 %26 = zext i1 %25 to i32
 %27 = load i32, i32* %5
 %28 = icmp sgt i32 %27, 0
 br i1 %28, label %29, label %32
29:
 %30 = load i32, i32* %8
 %31 = icmp sgt i32 %30, 0
 br label %32
32:
 %33 = phi i1 [0, %23], [%31, %29]
 %34 = xor i1 %33, 1
 %35 = zext i1 %34 to i32
 %36 = load i32, i32* %6
 %37 = icmp sgt i32 %36, 0
 br i1 %37, label %38, label %41
38:
 %39 = load i32, i32* %7
 %40 = icmp sgt i32 %39, 0
 br label %41
41:
 %42 = phi i1 [0, %32], [%40, %38]
 %43 = xor i1 %42, 1
 %44 = zext i1 %43 to i32
 %45 = load i32, i32* %6
 %46 = icmp sgt i32 %45, 0
 br i1 %46, label %47, label %50
47:
 %48 = load i32, i32* %8
 %49 = icmp sgt i32 %48, 0
 br label %50
50:
 %51 = phi i1 [0, %41], [%49, %47]
 %52 = xor i1 %51, 1
 %53 = zext i1 %52 to i32
 %54 = load i32, i32* %7
 %55 = icmp sgt i32 %54, 0
 br i1 %55, label %56, label %59
56:
 %57 = load i32, i32* %8
 %58 = icmp sgt i32 %57, 0
 br label %59
59:
 %60 = phi i1 [0, %50], [%58, %56]
 %61 = xor i1 %60, 1
 %62 = zext i1 %61 to i32
 %63 = call i32 (i8*, ...) @printf (i8* @.str.1, i32 %17, i32 %26, i32 %35, i32 %44, i32 %53, i32 %62)
 ret void
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @testBitWiseNot (i32 1, i32 2, i32 -3, i32 5)
 call void @testBooleanNot (i32 1, i32 2, i32 -3, i32 5)
 ret i32 0
}
