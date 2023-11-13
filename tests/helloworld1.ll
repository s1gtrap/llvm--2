@msg = global [14 x i8] c"Hello world!\0A\00"

declare i32 @printf(i8*, ...)

define i8 @main() {
  call i32 (i8*) @printf(i8* @msg)
  ret i8 0
}
