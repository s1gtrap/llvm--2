declare void @print_integer(i64)
declare i64 @read_integer()

define i64 @dolphin_main () {
 %a190 = alloca i1
 %tmp182 = icmp sgt i64 1, 0
 %cmp183 = icmp eq i1 %tmp182, 1
 br i1 %cmp183, label %leftTrue184, label %leftFalse185
leftTrue184:
 br label %merge186
leftFalse185:
 %tmp187 = sdiv i64 1, 0
 %tmp188 = icmp sgt i64 %tmp187, 0
 br label %merge186
merge186:
 %tmp189 = phi i1 [1, %leftTrue184], [%tmp188, %leftFalse185]
 store i1 %tmp189, i1* %a190
 ret i64 0
}
