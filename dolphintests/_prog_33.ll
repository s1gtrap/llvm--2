declare void @print_integer(i64)
declare i64 @read_integer()

define i64 @dolphin_main () {
 %i295 = alloca i64
 %x289 = alloca i64
 store i64 0, i64* %x289
 store i64 0, i64* %i295
 br label %for_cond291
for_cond291:
 %temp296 = load i64, i64* %i295
 %tmp297 = icmp slt i64 %temp296, 10
 br i1 %tmp297, label %for_body293, label %for_after294
for_body293:
 %temp300 = load i64, i64* %x289
 %tmp301 = add i64 %temp300, 1
 store i64 %tmp301, i64* %x289
 %tmp302 = load i64, i64* %x289
 br label %for_update292
dead_code303:
 %temp305 = load i64, i64* %x289
 %tmp306 = sub i64 %temp305, 100
 store i64 %tmp306, i64* %x289
 %tmp307 = load i64, i64* %x289
 br label %for_update292
for_update292:
 %temp308 = load i64, i64* %i295
 %tmp309 = add i64 %temp308, 1
 store i64 %tmp309, i64* %i295
 %tmp310 = load i64, i64* %i295
 br label %for_cond291
for_after294:
 %temp312 = load i64, i64* %x289
 call void @print_integer (i64 %temp312)
 ret i64 0
}

