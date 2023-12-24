declare void @print_integer(i64)
declare i64 @read_integer()

define i64 @dolphin_main () {
 %a109 = alloca i64
 %a106 = alloca i64
 %tmp105 = add i64 100, 100
 store i64 %tmp105, i64* %a106
 %tmp108 = add i64 100, 100
 store i64 %tmp108, i64* %a109
 ret i64 0
}

