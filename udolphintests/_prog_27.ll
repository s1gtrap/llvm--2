declare void @print_integer(i64)
declare i64 @read_integer()

define i64 @dolphin_main () {
 %x236 = alloca i64
 %a235 = alloca i64
 store i64 5, i64* %a235
 store i64 0, i64* %x236
 br label %for_cond231
for_cond231:
 %temp237 = load i64, i64* %a235
 %tmp238 = icmp sgt i64 %temp237, 0
 br i1 %tmp238, label %for_body233, label %for_after234
for_body233:
 %temp241 = load i64, i64* %x236
 %tmp242 = add i64 %temp241, 1
 store i64 %tmp242, i64* %x236
 %tmp243 = load i64, i64* %x236
 %temp247 = load i64, i64* %x236
 %tmp248 = icmp sle i64 %temp247, 5
 br i1 %tmp248, label %then245, label %after246
then245:
 br label %for_update232
dead_code249:
 br label %after246
after246:
 %temp251 = load i64, i64* %a235
 %tmp252 = sub i64 %temp251, 1
 store i64 %tmp252, i64* %a235
 %tmp253 = load i64, i64* %a235
 br label %for_update232
for_update232:
 br label %for_cond231
for_after234:
 ret i64 0
}

