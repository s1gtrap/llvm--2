@.str = global [34 x i8] c"y = %d, (y == 2 || y == 0) == %d\0A\00"
@.str.1 = global [32 x i8] c"y = %d, (y > 2 || y < 5) == %d\0A\00"
@.str.2 = global [28 x i8] c"y = %d, (y ^ 2 ^ ~y) == %d\0A\00"
@.str.3 = global [4 x i8] c"%d\0A\00"
@.str.4 = global [4 x i8] c"%d \00"
@.str.5 = global [6 x i8] c"%lld \00"

declare i32 @printf(i8*, ...)

define void @testCastOps (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = load i32, i32* %2
 %5 = icmp eq i32 %4, 2
 br i1 %5, label %9, label %6
6:
 %7 = load i32, i32* %2
 %8 = icmp eq i32 %7, 0
 br label %9
9:
 %10 = phi i1 [1, %1], [%8, %6]
 %11 = zext i1 %10 to i32
 %12 = call i32 (i8*, ...) @printf (i8* @.str, i32 %3, i32 %11)
 %13 = load i32, i32* %2
 %14 = load i32, i32* %2
 %15 = icmp slt i32 %14, 2
 br i1 %15, label %16, label %19
16:
 %17 = load i32, i32* %2
 %18 = icmp sgt i32 %17, -10
 br label %19
19:
 %20 = phi i1 [0, %9], [%18, %16]
 %21 = zext i1 %20 to i32
 %22 = call i32 (i8*, ...) @printf (i8* @.str.1, i32 %13, i32 %21)
 %23 = load i32, i32* %2
 %24 = load i32, i32* %2
 %25 = xor i32 %24, 2
 %26 = xor i32 %25, -6
 %27 = icmp ne i32 %26, 0
 %28 = zext i1 %27 to i32
 %29 = call i32 (i8*, ...) @printf (i8* @.str.2, i32 %23, i32 %28)
 ret void
}

define void @testBool (i1 %0) {
 %2 = alloca i8
 %3 = zext i1 %0 to i8
 store i8 %3, i8* %2
 %4 = load i8, i8* %2
 %5 = trunc i8 %4 to i1
 %6 = zext i1 %5 to i32
 %7 = call i32 (i8*, ...) @printf (i8* @.str.3, i32 %6)
 ret void
}

define void @testByte (i8 %0) {
 %2 = alloca i8
 store i8 %0, i8* %2
 %3 = load i8, i8* %2
 %4 = sext i8 %3 to i32
 %5 = call i32 (i8*, ...) @printf (i8* @.str.4, i32 %4)
 %6 = load i8, i8* %2
 %7 = sext i8 %6 to i32
 %8 = icmp ne i32 %7, 0
 call void @testBool (i1 %8)
 ret void
}

define void @testShort (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = sext i16 %3 to i32
 %5 = call i32 (i8*, ...) @printf (i8* @.str.4, i32 %4)
 %6 = load i16, i16* %2
 %7 = sext i16 %6 to i32
 %8 = icmp ne i32 %7, 0
 call void @testBool (i1 %8)
 ret void
}

define void @testInt (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = call i32 (i8*, ...) @printf (i8* @.str.4, i32 %3)
 %5 = load i32, i32* %2
 %6 = icmp ne i32 %5, 0
 call void @testBool (i1 %6)
 ret void
}

define void @testLong (i64 %0) {
 %2 = alloca i64
 store i64 %0, i64* %2
 %3 = load i64, i64* %2
 %4 = call i32 (i8*, ...) @printf (i8* @.str.5, i64 %3)
 %5 = load i64, i64* %2
 %6 = icmp ne i64 %5, 0
 call void @testBool (i1 %6)
 ret void
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 call void @testByte (i8 0)
 call void @testByte (i8 123)
 call void @testShort (i16 0)
 call void @testShort (i16 1234)
 call void @testInt (i32 0)
 call void @testInt (i32 1234)
 call void @testLong (i64 0)
 call void @testLong (i64 123121231231231)
 call void @testLong (i64 1230098424783699968)
 call void @testLong (i64 69920)
 call void @testCastOps (i32 2)
 ret i32 0
}
