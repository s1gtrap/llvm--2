; ModuleID = 'factor0.c'
source_filename = "factor0.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-macosx14.0.0"

@.str = private unnamed_addr constant [3 x i8] c"2 \00", align 1
@.str.1 = private unnamed_addr constant [4 x i8] c"%i \00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @fac(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  store i32 0, ptr %3, align 4
  br label %5

5:                                                ; preds = %11, %1
  %6 = load i32, ptr %2, align 4
  %7 = and i32 %6, 1
  %8 = icmp eq i32 %7, 0
  br i1 %8, label %9, label %16

9:                                                ; preds = %5
  %10 = call i32 (ptr, ...) @printf(ptr noundef @.str)
  br label %11

11:                                               ; preds = %9
  %12 = load i32, ptr %2, align 4
  %13 = sdiv i32 %12, 2
  store i32 %13, ptr %2, align 4
  %14 = load i32, ptr %3, align 4
  %15 = add nsw i32 %14, 1
  store i32 %15, ptr %3, align 4
  br label %5, !llvm.loop !5

16:                                               ; preds = %5
  store i32 3, ptr %4, align 4
  br label %17

17:                                               ; preds = %39, %16
  %18 = load i32, ptr %4, align 4
  %19 = load i32, ptr %4, align 4
  %20 = mul nsw i32 %18, %19
  %21 = load i32, ptr %2, align 4
  %22 = icmp sle i32 %20, %21
  br i1 %22, label %23, label %42

23:                                               ; preds = %17
  br label %24

24:                                               ; preds = %32, %23
  %25 = load i32, ptr %2, align 4
  %26 = load i32, ptr %4, align 4
  %27 = srem i32 %25, %26
  %28 = icmp eq i32 %27, 0
  br i1 %28, label %29, label %38

29:                                               ; preds = %24
  %30 = load i32, ptr %4, align 4
  %31 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, i32 noundef %30)
  br label %32

32:                                               ; preds = %29
  %33 = load i32, ptr %4, align 4
  %34 = load i32, ptr %2, align 4
  %35 = sdiv i32 %34, %33
  store i32 %35, ptr %2, align 4
  %36 = load i32, ptr %3, align 4
  %37 = add nsw i32 %36, 1
  store i32 %37, ptr %3, align 4
  br label %24, !llvm.loop !7

38:                                               ; preds = %24
  br label %39

39:                                               ; preds = %38
  %40 = load i32, ptr %4, align 4
  %41 = add nsw i32 %40, 2
  store i32 %41, ptr %4, align 4
  br label %17, !llvm.loop !8

42:                                               ; preds = %17
  %43 = load i32, ptr %2, align 4
  %44 = icmp sgt i32 %43, 2
  br i1 %44, label %45, label %50

45:                                               ; preds = %42
  %46 = load i32, ptr %2, align 4
  %47 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, i32 noundef %46)
  %48 = load i32, ptr %3, align 4
  %49 = add nsw i32 %48, 1
  store i32 %49, ptr %3, align 4
  br label %50

50:                                               ; preds = %45, %42
  %51 = load i32, ptr %3, align 4
  ret i32 %51
}

declare i32 @printf(ptr noundef, ...) #1

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @main(i32 noundef %0, ptr noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  store i32 0, ptr %3, align 4
  store i32 %0, ptr %4, align 4
  store ptr %1, ptr %5, align 8
  %6 = load ptr, ptr %5, align 8
  %7 = getelementptr inbounds ptr, ptr %6, i64 1
  %8 = load ptr, ptr %7, align 8
  %9 = call i32 @atoi(ptr noundef %8)
  %10 = call i32 @fac(i32 noundef %9)
  ret i32 %10
}

declare i32 @atoi(ptr noundef) #1

attributes #0 = { noinline nounwind optnone ssp uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cmov,+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cmov,+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 2}
!3 = !{i32 7, !"frame-pointer", i32 2}
!4 = !{!"Homebrew clang version 17.0.6"}
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loop.mustprogress"}
!7 = distinct !{!7, !6}
!8 = distinct !{!8, !6}
