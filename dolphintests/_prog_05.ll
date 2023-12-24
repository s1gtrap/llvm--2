declare void @print_integer(i64)
declare i64 @read_integer()

define i64 @dolphin_main () {
 %x29 = alloca i64
 %tmp28 = call i64 @read_integer ()
 store i64 %tmp28, i64* %x29
 %temp33 = load i64, i64* %x29
 %tmp34 = icmp sle i64 %temp33, 100
 br i1 %tmp34, label %then31, label %after32
then31:
 %temp36 = load i64, i64* %x29
 %tmp37 = add i64 1, %temp36
 call void @print_integer (i64 %tmp37)
 br label %after32
after32:
 ret i64 0
}
