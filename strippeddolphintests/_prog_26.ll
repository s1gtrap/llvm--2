declare void @print_integer(i64)
declare i64 @read_integer()

define i64 @dolphin_main () {
 %x206 = alloca i64
 %a205 = alloca i64
 store i64 5, i64* %a205
 store i64 0, i64* %x206
 br label %while_cond208
while_cond208:
 %temp211 = load i64, i64* %a205
 %tmp212 = icmp sgt i64 %temp211, 0
 br i1 %tmp212, label %while_body209, label %while_after210
while_body209:
 %temp215 = load i64, i64* %x206
 %tmp216 = add i64 %temp215, 1
 store i64 %tmp216, i64* %x206
 %tmp217 = load i64, i64* %x206
 %temp221 = load i64, i64* %x206
 %tmp222 = icmp sle i64 %temp221, 5
 br i1 %tmp222, label %then219, label %after220
then219:
 br label %while_cond208
dead_code223:
 br label %after220
after220:
 %temp225 = load i64, i64* %a205
 %tmp226 = sub i64 %temp225, 1
 store i64 %tmp226, i64* %a205
 %tmp227 = load i64, i64* %a205
 br label %while_cond208
while_after210:
 ret i64 0
}
