declare void @print_integer(i64)
declare i64 @read_integer()

define i64 @dolphin_main () {
 %a257 = alloca i64
 store i64 1, i64* %a257
 store i64 5, i64* %a257
 %tmp263 = load i64, i64* %a257
 br label %for_cond259
for_cond259:
 %temp264 = load i64, i64* %a257
 %tmp265 = icmp sgt i64 %temp264, 0
 br i1 %tmp265, label %for_body261, label %for_after262
for_body261:
 br label %for_after262
dead_code266:
 br label %for_update260
for_update260:
 %temp267 = load i64, i64* %a257
 %tmp268 = sub i64 %temp267, 1
 br label %for_cond259
for_after262:
 ret i64 0
}

