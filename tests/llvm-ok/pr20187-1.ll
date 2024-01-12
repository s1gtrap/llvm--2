@a = global i32 257
@b = global i32 256

define i32 @test () {
 %1 = load i32, i32* @a
 %2 = icmp ne i32 %1, 0
 br i1 %2, label %3, label %5
3:
 %4 = load i32, i32* @a
 br label %6
5:
 br label %6
6:
 %7 = phi i32 [%4, %3], [1, %5]
 %8 = load i32, i32* @a
 %9 = load i32, i32* @b
 %10 = mul i32 %8, %9
 %11 = and i32 %7, %10
 %12 = sext i32 %11 to i64
 %13 = trunc i64 %12 to i8
 %14 = zext i8 %13 to i32
 %15 = icmp ne i32 %14, 0
 %16 = zext i1 %15 to i64
 %17 = select i1 %15, i32 0, i32 1
 ret i32 %17
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @test ()
 %3 = sub i32 1, %2
 ret i32 %3
}
