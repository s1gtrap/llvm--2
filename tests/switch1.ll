define i32 @main (i32 %argc, i8** %argv) {
 switch i32 %argc, label %else [
    i32 1, label %one
    i32 2, label %two
  ]
one:
 ret i32 42
two:
 ret i32 69
else:
 ret i32 %argc
}
