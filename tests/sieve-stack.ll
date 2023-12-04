; ModuleID = 'tests/sieve-stack.c'
source_filename = "tests/sieve-stack.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-macosx14.0.0"

@.str = private unnamed_addr constant [4 x i8] c"%d \00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @main(i32 noundef %0, ptr noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca i32, align 4
  %7 = alloca ptr, align 8
  %8 = alloca i64, align 8
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  store i32 0, ptr %3, align 4
  store i32 %0, ptr %4, align 4
  store ptr %1, ptr %5, align 8
  %13 = load ptr, ptr %5, align 8
  %14 = getelementptr inbounds ptr, ptr %13, i64 1
  %15 = load ptr, ptr %14, align 8
  %16 = call i32 @atoi(ptr noundef %15)
  store i32 %16, ptr %6, align 4
  %17 = load i32, ptr %6, align 4
  %18 = add nsw i32 %17, 1
  %19 = zext i32 %18 to i64
  ;%20 = call ptr @llvm.stacksave()
  %20 = add i32 0, 0
  ;call i32 @printf(i8* @fmt, %20)
  ;store ptr %20, ptr %7, align 8
  %21 = alloca i8, i64 %19, align 16
  store i64 %19, ptr %8, align 8
  store i32 2, ptr %9, align 4
  br label %22

22:                                               ; preds = %30, %2
  %23 = load i32, ptr %9, align 4
  %24 = load i32, ptr %6, align 4
  %25 = icmp sle i32 %23, %24
  br i1 %25, label %26, label %33

26:                                               ; preds = %22
  %27 = load i32, ptr %9, align 4
  %28 = sext i32 %27 to i64
  %29 = getelementptr inbounds i8, ptr %21, i64 %28
  store i8 1, ptr %29, align 1
  br label %30

30:                                               ; preds = %26
  %31 = load i32, ptr %9, align 4
  %32 = add nsw i32 %31, 1
  store i32 %32, ptr %9, align 4
  br label %22, !llvm.loop !5

33:                                               ; preds = %22
  store i32 2, ptr %10, align 4
  br label %34

34:                                               ; preds = %64, %33
  %35 = load i32, ptr %10, align 4
  %36 = load i32, ptr %10, align 4
  %37 = mul nsw i32 %35, %36
  %38 = load i32, ptr %6, align 4
  %39 = icmp sle i32 %37, %38
  br i1 %39, label %40, label %67

40:                                               ; preds = %34
  %41 = load i32, ptr %10, align 4
  %42 = sext i32 %41 to i64
  %43 = getelementptr inbounds i8, ptr %21, i64 %42
  %44 = load i8, ptr %43, align 1
  %45 = trunc i8 %44 to i1
  br i1 %45, label %46, label %63

46:                                               ; preds = %40
  %47 = load i32, ptr %10, align 4
  %48 = load i32, ptr %10, align 4
  %49 = mul nsw i32 %47, %48
  store i32 %49, ptr %11, align 4
  br label %50

50:                                               ; preds = %58, %46
  %51 = load i32, ptr %11, align 4
  %52 = load i32, ptr %6, align 4
  %53 = icmp sle i32 %51, %52
  br i1 %53, label %54, label %62

54:                                               ; preds = %50
  %55 = load i32, ptr %11, align 4
  %56 = sext i32 %55 to i64
  %57 = getelementptr inbounds i8, ptr %21, i64 %56
  store i8 0, ptr %57, align 1
  br label %58

58:                                               ; preds = %54
  %59 = load i32, ptr %10, align 4
  %60 = load i32, ptr %11, align 4
  %61 = add nsw i32 %60, %59
  store i32 %61, ptr %11, align 4
  br label %50, !llvm.loop !7

62:                                               ; preds = %50
  br label %63

63:                                               ; preds = %62, %40
  br label %64

64:                                               ; preds = %63
  %65 = load i32, ptr %10, align 4
  %66 = add nsw i32 %65, 1
  store i32 %66, ptr %10, align 4
  br label %34, !llvm.loop !8

67:                                               ; preds = %34
  store i32 2, ptr %12, align 4
  br label %68

68:                                               ; preds = %82, %67
  %69 = load i32, ptr %12, align 4
  %70 = load i32, ptr %6, align 4
  %71 = icmp sle i32 %69, %70
  br i1 %71, label %72, label %85

72:                                               ; preds = %68
  %73 = load i32, ptr %12, align 4
  %74 = sext i32 %73 to i64
  %75 = getelementptr inbounds i8, ptr %21, i64 %74
  %76 = load i8, ptr %75, align 1
  %77 = trunc i8 %76 to i1
  br i1 %77, label %78, label %81

78:                                               ; preds = %72
  %79 = load i32, ptr %12, align 4
  %80 = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %79)
  br label %81

81:                                               ; preds = %78, %72
  br label %82

82:                                               ; preds = %81
  %83 = load i32, ptr %12, align 4
  %84 = add nsw i32 %83, 1
  store i32 %84, ptr %12, align 4
  br label %68, !llvm.loop !9

85:                                               ; preds = %68
  store i32 0, ptr %3, align 4
  ;%86 = load ptr, ptr %7, align 8 ; FIXME
  %86 = add i32 0, 0
  ;call void @llvm.stackrestore(ptr %86)
  %87 = load i32, ptr %3, align 4
  ret i32 %87
}

declare i32 @atoi(ptr noundef) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn
;declare ptr @llvm.stacksave() #2

declare i32 @printf(ptr noundef, ...) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.stackrestore(ptr) #2

attributes #0 = { noinline nounwind optnone ssp uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cmov,+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cmov,+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }
attributes #2 = { nocallback nofree nosync nounwind willreturn }

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
!9 = distinct !{!9, !6}
