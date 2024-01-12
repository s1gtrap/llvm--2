define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @temp ()
 ret i32 0
}

define void @temp () {
 ret void
}
