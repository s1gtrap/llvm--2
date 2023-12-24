define i8 @main (i8 %argc, i8** %argv) {
 %a = add i8 255, 0
 %b = lshr i8 %a, %argc
 ret i8 %b
}
