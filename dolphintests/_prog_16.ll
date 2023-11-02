declare void @print_integer(i64)
declare i64 @read_integer()

define i64 @dolphin_main () {
 %a80 = alloca i1
 %cmp74 = icmp eq i1 0, 1
 br i1 %cmp74, label %leftTrue75, label %leftFalse76
leftTrue75:
 br label %merge77
leftFalse76:
 %tmp78 = icmp eq i64 1, 1
 br label %merge77
merge77:
 %tmp79 = phi i1 [1, %leftTrue75], [%tmp78, %leftFalse76]
 store i1 %tmp79, i1* %a80
 ret i64 0
}

