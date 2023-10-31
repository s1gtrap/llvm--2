define i32 @main() {
    %x = alloca i32
    store i32 42, i32* %x
    %y = load i32, i32* %x
    ret i32 %y
}
