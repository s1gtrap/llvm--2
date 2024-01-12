declare void @abort()

define i32 @foo (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 store i32 %0, i32* %2
 %4 = load i32, i32* %2
 %5 = mul i32 4, %4
 %6 = sub i32 80, %5
 %7 = sdiv i32 %6, 20
 store i32 %7, i32* %3
 %8 = load i32, i32* %3
 ret i32 %8
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @foo (i32 1)
 %3 = icmp ne i32 %2, 3
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 ret i32 0
}
