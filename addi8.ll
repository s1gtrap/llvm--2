; ModuleID = 'tests/addi8.c'
source_filename = "tests/addi8.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [21 x i8] c"%dhh + %dhh != %dhh\0A\00", align 1
@.str.1 = private unnamed_addr constant [21 x i8] c"%dhh + %dhh == %dhh\0A\00", align 1

; Function Attrs: nofree nounwind sspstrong uwtable
define dso_local void @assert(i8 noundef zeroext %0, i8 noundef zeroext %1, i8 noundef zeroext %2) local_unnamed_addr #0 {
  %4 = zext i8 %0 to i32
  %5 = zext i8 %1 to i32
  %6 = add nuw nsw i32 %5, %4
  %7 = zext i8 %2 to i32
  %8 = icmp eq i32 %6, %7
  %9 = select i1 %8, ptr @.str.1, ptr @.str
  %10 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) %9, i32 noundef %4, i32 noundef %5, i32 noundef %7)
  ret void
}

; Function Attrs: nofree nounwind
declare noundef i32 @printf(ptr nocapture noundef readonly, ...) local_unnamed_addr #1

; Function Attrs: nofree nounwind sspstrong uwtable
define dso_local i32 @main(i32 noundef %0, ptr nocapture noundef readnone %1) local_unnamed_addr #0 {
  %3 = and i32 %0, 255
  %4 = icmp eq i32 %3, 0
  %5 = select i1 %4, ptr @.str.1, ptr @.str
  %6 = tail call i32 (ptr, ...) @printf(ptr noundef nonnull dereferenceable(1) %5, i32 noundef %3, i32 noundef 0, i32 noundef 0)
  ret i32 0
}

attributes #0 = { nofree nounwind sspstrong uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nofree nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"clang version 16.0.6"}
