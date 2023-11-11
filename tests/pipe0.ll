declare i32 @read(i32, i8*, i32)
declare i32 @write(i32, i8*, i32)

define i32 @main() {
  %buf = alloca [64 x i8]
  %read = call i32 @read(i32 0, i8* %buf, i32 64)
  call i32 @write(i32 1, i8* %buf, i32 %read)
  ret i32 %read
}
