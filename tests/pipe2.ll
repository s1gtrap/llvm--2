declare i32 @read(i32, i8*, i32)
declare i32 @write(i32, i8*, i32)

define i32 @main() {
entry:
  %buf = alloca [64 x i8]
  br label %loop
loop:
  %read0 = phi i32 [0, %entry], [%read2, %loop]
  %read1 = call i32 @read(i32 0, i8* %buf, i32 64)
  %read2 = add i32 %read0, %read1
  call i32 @write(i32 1, i8* %buf, i32 %read1)
  %cnd = icmp eq i32 %read1, 64
  br i1 %cnd, label %loop, label %exit
exit:
  ret i32 %read2
}
