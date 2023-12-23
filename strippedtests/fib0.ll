define i32 @fib (i32 %n0) {
 %cn = icmp sle i32 %n0, 2
 br i1 %cn, label %base, label %rec
base:
 ret i32 1
rec:
 %n1 = sub i32 %n0, 1
 %v0 = call i32 @fib (i32 %n1)
 %n2 = sub i32 %n0, 2
 %v1 = call i32 @fib (i32 %n2)
 %v2 = add i32 %v1, %v2
 ret i32 %v2
}

define i32 @main () {
 call i32 @fib (i32 12)
 ret i32 0
}
