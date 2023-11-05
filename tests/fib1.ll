declare i32 @atoi(i8*)
define i32 @fib(i32 %n0) {
  %cn =  icmp sle i32 %n0, 2
  br i1 %cn, label %base, label %rec
base:
  ret i32 1
rec:
  %n1 = sub i32 %n0, 1
  %v0 = call i32 @fib(i32 %n1)
  %n2 = sub i32 %n0, 2
  %v1 = call i32 @fib(i32 %n2)
  %v2 = add i32 %v1, %v2
  ret i32 %v2
}
define i32 @main(i32 %argc, i8** %argv) {
  %arg1ptr = getelementptr i8*, i8** %argv, i64 1
  %arg1 = load i8*, i8** %arg1ptr
  %n = call i32 @atoi(i8* %arg1)
  call i32 @fib(i32 %n)
  ret i32 0
}
