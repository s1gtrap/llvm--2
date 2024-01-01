define i32 @add (i32 %0, i32 %1) {
 %3 = add i32 %1, %0
 ret i32 %3
}

define i32 @main() {
  %1 = call i32 @add(i32 1, i32 2)
  ret i32 %1
}
