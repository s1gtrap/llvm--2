declare void @print_integer(i64)
declare i64 @read_integer()

define i64 @dolphin_main () {
 %a194 = alloca i64
 store i64 5, i64* %a194
 br label %while_cond196
while_cond196:
 %temp199 = load i64, i64* %a194
 %tmp200 = icmp sgt i64 %temp199, 0
 br i1 %tmp200, label %while_body197, label %while_after198
while_body197:
 br label %while_after198
dead_code201:
 br label %while_cond196
while_after198:
 ret i64 0
}
