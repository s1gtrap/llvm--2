declare void @print_integer(i64)
declare i64 @read_integer()

define i64 @dolphin_main () {
 br label %for_cond281
for_cond281:
 br label %for_body283
for_body283:
 br label %for_after284
dead_code285:
 br label %for_update282
for_update282:
 br label %for_cond281
for_after284:
 ret i64 0
}

