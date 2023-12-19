@fmt = global [13 x i8] c"%%%s = %08x\0A\00"
@base = global [5 x i8] c"base\00"
@i = global [2 x i8] c"i\00"
@prod = global [5 x i8] c"prod\00"

declare i32 @printf(i8*, ...)

define i32 @main(i32 %base) {
l1:
  %o2 = icmp sgt i32 %base, 0
  br i1 %o2, label %l3, label %l9                    ; succs = %o3, %o9
l3:                                                ; preds = %o1, %o3
  %i = phi i32 [ %base, %l1 ], [ %o7, %l3 ]
  %prod = phi i32 [ 0, %l1 ], [ %o6, %l3 ]
  call i32 @printf(i8* @fmt, i8* @base, i32 %base)
  call i32 @printf(i8* @fmt, i8* @i, i32 %i)
  call i32 @printf(i8* @fmt, i8* @prod, i32 %prod)
  %o6 = add i32 %prod, %base
  call i32 @printf(i8* @fmt, i8* @prod, i32 %o6)
  %o7 = sub i32 %i, 1
  call i32 @printf(i8* @fmt, i8* @i, i32 %o7)
  %o8 = icmp ugt i32 %o7, 0
  br i1 %o8, label %l3, label %l9                    ; succs = %o3, %o9
l9:                                                ; preds = %o3, %o1
  %o10 = phi i32 [ 0, %l1 ], [ %o6, %l3 ]
  ret i32 %o10
}
