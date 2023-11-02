declare void @print_integer(i64)
declare i64 @read_integer()

define i64 @dolphin_main () {
 br label %for_cond272
for_cond272:
 %tmp276 = icmp sgt i64 1, 0
 br i1 %tmp276, label %for_body274, label %for_after275
for_body274:
 br label %for_after275
dead_code277:
 br label %for_update273
for_update273:
 br label %for_cond272
for_after275:
 ret i64 0
}

