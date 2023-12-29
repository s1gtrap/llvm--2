define i32 @main (i32 %argc, i8** %argv) {
 switch i32 %argc, label %else [
    i32 1, label %one
    i32 2, label %two
    i32 3, label %three
  ]
one:
 ret i32 42
two:
 ret i32 69
three:
 ret i32 255
else:
 ret i32 %argc
}
