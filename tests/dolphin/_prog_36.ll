declare void @print_integer(i64)
declare i64 @read_integer()

define i64 @dolphin_main () {
 %b292 = alloca i64
 %a289 = alloca i64
 store i64 1, i64* %a289
 %temp290 = load i64, i64* %a289
 %tmp291 = mul i64 %temp290, 10
 store i64 %tmp291, i64* %b292
 ret i64 0
}
