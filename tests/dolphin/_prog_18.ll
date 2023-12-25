declare void @print_integer(i64)
declare i64 @read_integer()

define i64 @dolphin_main () {
 %a100 = alloca i1
 %cmp94 = icmp eq i1 0, 0
 br i1 %cmp94, label %leftFalse95, label %leftTrue96
leftFalse95:
 br label %merge97
leftTrue96:
 %tmp98 = icmp eq i64 1, 1
 br label %merge97
merge97:
 %tmp99 = phi i1 [0, %leftFalse95], [%tmp98, %leftTrue96]
 store i1 %tmp99, i1* %a100
 ret i64 0
}
