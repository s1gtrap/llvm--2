define i8 @main () {
 %v0 = icmp sge i32 4294967295, 0
 br i1 %v0, label %True, label %False
True:
 ret i8 1
False:
 ret i8 0
}
