@a = global i32 274686410

declare void @abort()

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 store i32 0, i32* %1
 store i32 53671368, i32* %2
 %3 = load i32, i32* %2
 %4 = trunc i32 %3 to i8
 %5 = load i32, i32* @a
 %6 = trunc i32 %5 to i8
 %7 = call i8 @foo (i8 %4, i8 %6)
 %8 = sext i8 %7 to i32
 %9 = icmp sgt i32 %8, 0
 br i1 %9, label %10, label %11
10:
 call void @abort ()
 unreachable
11:
 ret i32 0
}

define i8 @foo (i8 %0, i8 %1) {
 %3 = alloca i8
 %4 = alloca i8
 store i8 %0, i8* %3
 store i8 %1, i8* %4
 %5 = load i8, i8* %3
 %6 = sext i8 %5 to i32
 %7 = load i8, i8* %4
 %8 = sext i8 %7 to i32
 %9 = mul i32 %6, %8
 %10 = trunc i32 %9 to i8
 ret i8 %10
}
