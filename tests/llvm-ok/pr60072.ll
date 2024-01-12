@c = global i32 1

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i8* @foo (i8* @c)
 store i32 2, i32* %2
 %3 = load i32, i32* @c
 %4 = sub i32 %3, 2
 ret i32 %4
}

define i8* @foo (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 %3 = load i8*, i8** %2
 ret i8* %3
}
