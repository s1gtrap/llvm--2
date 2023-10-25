@msg = global [13 x i8] c"Hello error!\0A\00"

declare i32 @fprintf(i8*, ...)

define void @main() {
  %f = load i8, i8* @stderr
  call i32 (i8*) @fprintf(i8 %f, i8* @msg)
  ret void
}
