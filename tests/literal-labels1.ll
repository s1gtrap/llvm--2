define i8 @other () {
 br label %1
1:
 ret i8 1
}

define i8 @main () {
 br label %1
1:
 ret i8 0
}
