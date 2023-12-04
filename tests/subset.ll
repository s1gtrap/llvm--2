; ModuleID = 'tests/subset.c'
source_filename = "tests/subset.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-macosx14.0.0"

@.str = private unnamed_addr constant [3 x i8] c"{ \00", align 1
@.str.1 = private unnamed_addr constant [4 x i8] c"%s \00", align 1
@.str.2 = private unnamed_addr constant [3 x i8] c"}\0A\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @subsets(i32 noundef %0, ptr noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store ptr %1, ptr %4, align 8
  store i32 0, ptr %5, align 4
  br label %7

7:                                                ; preds = %38, %2
  %8 = load i32, ptr %5, align 4
  %9 = load i32, ptr %3, align 4
  %10 = shl i32 1, %9
  %11 = icmp slt i32 %8, %10
  br i1 %11, label %12, label %41

12:                                               ; preds = %7
  %13 = call i32 (ptr, ...) @printf(ptr noundef @.str)
  store i32 0, ptr %6, align 4
  br label %14

14:                                               ; preds = %33, %12
  %15 = load i32, ptr %6, align 4
  %16 = load i32, ptr %3, align 4
  %17 = icmp slt i32 %15, %16
  br i1 %17, label %18, label %36

18:                                               ; preds = %14
  %19 = load i32, ptr %5, align 4
  %20 = load i32, ptr %6, align 4
  %21 = shl i32 1, %20
  %22 = and i32 %19, %21
  %23 = icmp ne i32 %22, 0
  br i1 %23, label %24, label %32

24:                                               ; preds = %18
  %25 = load ptr, ptr %4, align 8
  %26 = load i32, ptr %6, align 4
  %27 = add nsw i32 %26, 1
  %28 = sext i32 %27 to i64
  %29 = getelementptr inbounds ptr, ptr %25, i64 %28
  %30 = load ptr, ptr %29, align 8
  %31 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, ptr noundef %30)
  br label %32

32:                                               ; preds = %24, %18
  br label %33

33:                                               ; preds = %32
  %34 = load i32, ptr %6, align 4
  %35 = add nsw i32 %34, 1
  store i32 %35, ptr %6, align 4
  br label %14, !llvm.loop !5

36:                                               ; preds = %14
  %37 = call i32 (ptr, ...) @printf(ptr noundef @.str.2)
  br label %38

38:                                               ; preds = %36
  %39 = load i32, ptr %5, align 4
  %40 = add nsw i32 %39, 1
  store i32 %40, ptr %5, align 4
  br label %7, !llvm.loop !7

41:                                               ; preds = %7
  %42 = load i32, ptr %5, align 4
  ret i32 %42
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
  %6 = load i32, ptr %4, align 4
  %7 = sub nsw i32 %6, 1
  %8 = load ptr, ptr %5, align 8
  %9 = call i32 @subsets(i32 noundef %7, ptr noundef %8)
  ret i32 %9
}

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
