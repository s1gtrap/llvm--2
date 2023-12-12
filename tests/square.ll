declare i32 @atoi(ptr nocapture noundef) local_unnamed_addr #1

define i32 @main(i32 noundef %0, ptr nocapture noundef readonly %1) local_unnamed_addr #0 {
  %3 = icmp sgt i32 %0, 0
  br i1 %3, label %4, label %6

4:                                                ; preds = %2
  %5 = zext i32 %0 to i64
  br label %8

6:                                                ; preds = %8, %2
  %7 = phi i32 [ 0, %2 ], [ %11, %8 ]
  ret i32 %7

8:                                                ; preds = %4, %8
  %9 = phi i64 [ %5, %4 ], [ %12, %8 ]
  %10 = phi i32 [ 0, %4 ], [ %11, %8 ]
  %11 = add nsw i32 %10, %0
  %12 = add nsw i64 %9, -1
  %13 = icmp ugt i64 %9, 1
  br i1 %13, label %8, label %6
}
