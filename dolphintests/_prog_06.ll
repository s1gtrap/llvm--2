declare void @print_integer(i64)
declare i64 @read_integer()

define i64 @dolphin_main () {
 %x43 = alloca i64
 %tmp42 = call i64 @read_integer ()
 store i64 %tmp42, i64* %x43
 %temp47 = load i64, i64* %x43
 %tmp48 = icmp sle i64 %temp47, 100
 br i1 %tmp48, label %then45, label %else49
then45:
 %temp51 = load i64, i64* %x43
 %tmp52 = add i64 1, %temp51
 call void @print_integer (i64 %tmp52)
 br label %after46
else49:
 call void @print_integer (i64 -1)
 br label %after46
after46:
 ret i64 0
}

