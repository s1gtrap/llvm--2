@fmt = global [6 x i8] c"%llx\0A\00"

declare i32 @printf(i8*, ...)

define i32 @main() {
  call i32 @printf(i8* @fmt, i8 -1)
  call i32 @printf(i8* @fmt, i16 -1)
  call i32 @printf(i8* @fmt, i32 -1)
  call i32 @printf(i8* @fmt, i64 -1)
  ret i32 0
}
