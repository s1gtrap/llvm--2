@test = global i32 0

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 ret i32 0
}
