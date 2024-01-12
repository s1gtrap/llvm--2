declare void @abort()

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 br label %2
2:
 br i1 0, label %3, label %5
3:
 call void @abort ()
 unreachable
4:
 ret i32 0
5:
 br label %4
}
