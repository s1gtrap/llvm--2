declare i32 @puts(i8*)

define i8 @main () {
 %1 = alloca [16 x i8]
 %2 = getelementptr i8, i8* %1, i64 0
 store i8 72, i8* %2
 %3 = getelementptr i8, i8* %1, i64 1
 store i8 101, i8* %3
 %4 = getelementptr i8, i8* %1, i64 2
 store i8 108, i8* %4
 %5 = getelementptr i8, i8* %1, i64 3
 store i8 108, i8* %5
 %6 = getelementptr i8, i8* %1, i64 4
 store i8 111, i8* %6
 %7 = getelementptr i8, i8* %1, i64 5
 store i8 44, i8* %7
 %8 = getelementptr i8, i8* %1, i64 6
 store i8 32, i8* %8
 %9 = getelementptr i8, i8* %1, i64 7
 store i8 119, i8* %9
 %10 = getelementptr i8, i8* %1, i64 8
 store i8 111, i8* %10
 %11 = getelementptr i8, i8* %1, i64 9
 store i8 114, i8* %11
 %12 = getelementptr i8, i8* %1, i64 10
 store i8 108, i8* %12
 %13 = getelementptr i8, i8* %1, i64 11
 store i8 100, i8* %13
 %14 = getelementptr i8, i8* %1, i64 12
 store i8 33, i8* %14
 %15 = getelementptr i8, i8* %1, i64 13
 store i8 0, i8* %15
 call i32 @puts (i8* %1)
 %17 = alloca [4 x i32]
 %18 = getelementptr i32, i32* %17, i64 0
 store i32 1819043144, i32* %18
 %19 = getelementptr i32, i32* %17, i64 1
 store i32 1998597231, i32* %19
 %20 = getelementptr i32, i32* %17, i64 2
 store i32 1684828783, i32* %20
 %21 = getelementptr i32, i32* %17, i64 3
 store i32 33, i32* %21
 call i32 @puts (i8* %17)
 %23 = alloca [2 x i64]
 %24 = getelementptr i64, i64* %23, i64 0
 store i64 8583909746840200520, i64* %24
 %25 = getelementptr i64, i64* %23, i64 1
 store i64 143418749551, i64* %25
 call i32 @puts (i8* %23)
 ret i8 0
}
