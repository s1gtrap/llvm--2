declare void @print_integer(i64)
declare i64 @read_integer()

define i64 @dolphin_main () {
 %a170 = alloca i64
 %tmp169 = add i64 5, 10
 store i64 %tmp169, i64* %a170
 %tmp172 = add i64 5, 10
 store i64 %tmp172, i64* %a170
 %tmp173 = load i64, i64* %a170
 ret i64 0
}
