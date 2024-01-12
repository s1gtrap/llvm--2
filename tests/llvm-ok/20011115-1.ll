declare void @exit(i32)

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @exit (i32 0)
 unreachable
}
