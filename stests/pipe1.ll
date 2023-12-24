declare i32 @read(i32, i8*, i32)
declare i32 @write(i32, i8*, i32)

define i32 @main () {
 %buf = alloca [64 x i8]
 br label %loop
loop:
 %read = call i32 @read (i32 0, i8* %buf, i32 64)
 call i32 @write (i32 1, i8* %buf, i32 %read)
 %cnd = icmp eq i32 %read, 64
 br i1 %cnd, label %loop, label %exit
exit:
 ret i32 %read
}
