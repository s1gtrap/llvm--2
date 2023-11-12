define i32 @main(i32 %argc, i8** %argv) {
  %a = add i32 4294967295, 0
  %b = lshr i32 %a, %argc
  ret i32 %b
}
