declare void @abort()
declare void @exit(i32)

define i8 @ashift_qi_0 (i8 %0) {
 %2 = alloca i8
 store i8 %0, i8* %2
 %3 = load i8, i8* %2
 %4 = zext i8 %3 to i32
 %5 = shl i32 %4, 0
 %6 = trunc i32 %5 to i8
 ret i8 %6
}

define i8 @ashift_qi_1 (i8 %0) {
 %2 = alloca i8
 store i8 %0, i8* %2
 %3 = load i8, i8* %2
 %4 = zext i8 %3 to i32
 %5 = shl i32 %4, 1
 %6 = trunc i32 %5 to i8
 ret i8 %6
}

define i8 @ashift_qi_2 (i8 %0) {
 %2 = alloca i8
 store i8 %0, i8* %2
 %3 = load i8, i8* %2
 %4 = zext i8 %3 to i32
 %5 = shl i32 %4, 2
 %6 = trunc i32 %5 to i8
 ret i8 %6
}

define i8 @ashift_qi_3 (i8 %0) {
 %2 = alloca i8
 store i8 %0, i8* %2
 %3 = load i8, i8* %2
 %4 = zext i8 %3 to i32
 %5 = shl i32 %4, 3
 %6 = trunc i32 %5 to i8
 ret i8 %6
}

define i8 @ashift_qi_4 (i8 %0) {
 %2 = alloca i8
 store i8 %0, i8* %2
 %3 = load i8, i8* %2
 %4 = zext i8 %3 to i32
 %5 = shl i32 %4, 4
 %6 = trunc i32 %5 to i8
 ret i8 %6
}

define i8 @ashift_qi_5 (i8 %0) {
 %2 = alloca i8
 store i8 %0, i8* %2
 %3 = load i8, i8* %2
 %4 = zext i8 %3 to i32
 %5 = shl i32 %4, 5
 %6 = trunc i32 %5 to i8
 ret i8 %6
}

define i8 @ashift_qi_6 (i8 %0) {
 %2 = alloca i8
 store i8 %0, i8* %2
 %3 = load i8, i8* %2
 %4 = zext i8 %3 to i32
 %5 = shl i32 %4, 6
 %6 = trunc i32 %5 to i8
 ret i8 %6
}

define i8 @ashift_qi_7 (i8 %0) {
 %2 = alloca i8
 store i8 %0, i8* %2
 %3 = load i8, i8* %2
 %4 = zext i8 %3 to i32
 %5 = shl i32 %4, 7
 %6 = trunc i32 %5 to i8
 ret i8 %6
}

define i8 @lshiftrt_qi_0 (i8 %0) {
 %2 = alloca i8
 store i8 %0, i8* %2
 %3 = load i8, i8* %2
 %4 = zext i8 %3 to i32
 %5 = ashr i32 %4, 0
 %6 = trunc i32 %5 to i8
 ret i8 %6
}

define i8 @lshiftrt_qi_1 (i8 %0) {
 %2 = alloca i8
 store i8 %0, i8* %2
 %3 = load i8, i8* %2
 %4 = zext i8 %3 to i32
 %5 = ashr i32 %4, 1
 %6 = trunc i32 %5 to i8
 ret i8 %6
}

define i8 @lshiftrt_qi_2 (i8 %0) {
 %2 = alloca i8
 store i8 %0, i8* %2
 %3 = load i8, i8* %2
 %4 = zext i8 %3 to i32
 %5 = ashr i32 %4, 2
 %6 = trunc i32 %5 to i8
 ret i8 %6
}

define i8 @lshiftrt_qi_3 (i8 %0) {
 %2 = alloca i8
 store i8 %0, i8* %2
 %3 = load i8, i8* %2
 %4 = zext i8 %3 to i32
 %5 = ashr i32 %4, 3
 %6 = trunc i32 %5 to i8
 ret i8 %6
}

define i8 @lshiftrt_qi_4 (i8 %0) {
 %2 = alloca i8
 store i8 %0, i8* %2
 %3 = load i8, i8* %2
 %4 = zext i8 %3 to i32
 %5 = ashr i32 %4, 4
 %6 = trunc i32 %5 to i8
 ret i8 %6
}

define i8 @lshiftrt_qi_5 (i8 %0) {
 %2 = alloca i8
 store i8 %0, i8* %2
 %3 = load i8, i8* %2
 %4 = zext i8 %3 to i32
 %5 = ashr i32 %4, 5
 %6 = trunc i32 %5 to i8
 ret i8 %6
}

define i8 @lshiftrt_qi_6 (i8 %0) {
 %2 = alloca i8
 store i8 %0, i8* %2
 %3 = load i8, i8* %2
 %4 = zext i8 %3 to i32
 %5 = ashr i32 %4, 6
 %6 = trunc i32 %5 to i8
 ret i8 %6
}

define i8 @lshiftrt_qi_7 (i8 %0) {
 %2 = alloca i8
 store i8 %0, i8* %2
 %3 = load i8, i8* %2
 %4 = zext i8 %3 to i32
 %5 = ashr i32 %4, 7
 %6 = trunc i32 %5 to i8
 ret i8 %6
}

define i8 @ashiftrt_qi_0 (i8 %0) {
 %2 = alloca i8
 store i8 %0, i8* %2
 %3 = load i8, i8* %2
 %4 = sext i8 %3 to i32
 %5 = ashr i32 %4, 0
 %6 = trunc i32 %5 to i8
 ret i8 %6
}

define i8 @ashiftrt_qi_1 (i8 %0) {
 %2 = alloca i8
 store i8 %0, i8* %2
 %3 = load i8, i8* %2
 %4 = sext i8 %3 to i32
 %5 = ashr i32 %4, 1
 %6 = trunc i32 %5 to i8
 ret i8 %6
}

define i8 @ashiftrt_qi_2 (i8 %0) {
 %2 = alloca i8
 store i8 %0, i8* %2
 %3 = load i8, i8* %2
 %4 = sext i8 %3 to i32
 %5 = ashr i32 %4, 2
 %6 = trunc i32 %5 to i8
 ret i8 %6
}

define i8 @ashiftrt_qi_3 (i8 %0) {
 %2 = alloca i8
 store i8 %0, i8* %2
 %3 = load i8, i8* %2
 %4 = sext i8 %3 to i32
 %5 = ashr i32 %4, 3
 %6 = trunc i32 %5 to i8
 ret i8 %6
}

define i8 @ashiftrt_qi_4 (i8 %0) {
 %2 = alloca i8
 store i8 %0, i8* %2
 %3 = load i8, i8* %2
 %4 = sext i8 %3 to i32
 %5 = ashr i32 %4, 4
 %6 = trunc i32 %5 to i8
 ret i8 %6
}

define i8 @ashiftrt_qi_5 (i8 %0) {
 %2 = alloca i8
 store i8 %0, i8* %2
 %3 = load i8, i8* %2
 %4 = sext i8 %3 to i32
 %5 = ashr i32 %4, 5
 %6 = trunc i32 %5 to i8
 ret i8 %6
}

define i8 @ashiftrt_qi_6 (i8 %0) {
 %2 = alloca i8
 store i8 %0, i8* %2
 %3 = load i8, i8* %2
 %4 = sext i8 %3 to i32
 %5 = ashr i32 %4, 6
 %6 = trunc i32 %5 to i8
 ret i8 %6
}

define i8 @ashiftrt_qi_7 (i8 %0) {
 %2 = alloca i8
 store i8 %0, i8* %2
 %3 = load i8, i8* %2
 %4 = sext i8 %3 to i32
 %5 = ashr i32 %4, 7
 %6 = trunc i32 %5 to i8
 ret i8 %6
}

define i16 @ashift_hi_0 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = zext i16 %3 to i32
 %5 = shl i32 %4, 0
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @ashift_hi_1 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = zext i16 %3 to i32
 %5 = shl i32 %4, 1
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @ashift_hi_2 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = zext i16 %3 to i32
 %5 = shl i32 %4, 2
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @ashift_hi_3 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = zext i16 %3 to i32
 %5 = shl i32 %4, 3
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @ashift_hi_4 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = zext i16 %3 to i32
 %5 = shl i32 %4, 4
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @ashift_hi_5 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = zext i16 %3 to i32
 %5 = shl i32 %4, 5
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @ashift_hi_6 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = zext i16 %3 to i32
 %5 = shl i32 %4, 6
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @ashift_hi_7 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = zext i16 %3 to i32
 %5 = shl i32 %4, 7
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @ashift_hi_8 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = zext i16 %3 to i32
 %5 = shl i32 %4, 8
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @ashift_hi_9 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = zext i16 %3 to i32
 %5 = shl i32 %4, 9
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @ashift_hi_10 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = zext i16 %3 to i32
 %5 = shl i32 %4, 10
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @ashift_hi_11 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = zext i16 %3 to i32
 %5 = shl i32 %4, 11
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @ashift_hi_12 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = zext i16 %3 to i32
 %5 = shl i32 %4, 12
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @ashift_hi_13 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = zext i16 %3 to i32
 %5 = shl i32 %4, 13
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @ashift_hi_14 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = zext i16 %3 to i32
 %5 = shl i32 %4, 14
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @ashift_hi_15 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = zext i16 %3 to i32
 %5 = shl i32 %4, 15
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @lshiftrt_hi_0 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = zext i16 %3 to i32
 %5 = ashr i32 %4, 0
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @lshiftrt_hi_1 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = zext i16 %3 to i32
 %5 = ashr i32 %4, 1
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @lshiftrt_hi_2 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = zext i16 %3 to i32
 %5 = ashr i32 %4, 2
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @lshiftrt_hi_3 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = zext i16 %3 to i32
 %5 = ashr i32 %4, 3
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @lshiftrt_hi_4 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = zext i16 %3 to i32
 %5 = ashr i32 %4, 4
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @lshiftrt_hi_5 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = zext i16 %3 to i32
 %5 = ashr i32 %4, 5
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @lshiftrt_hi_6 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = zext i16 %3 to i32
 %5 = ashr i32 %4, 6
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @lshiftrt_hi_7 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = zext i16 %3 to i32
 %5 = ashr i32 %4, 7
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @lshiftrt_hi_8 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = zext i16 %3 to i32
 %5 = ashr i32 %4, 8
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @lshiftrt_hi_9 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = zext i16 %3 to i32
 %5 = ashr i32 %4, 9
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @lshiftrt_hi_10 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = zext i16 %3 to i32
 %5 = ashr i32 %4, 10
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @lshiftrt_hi_11 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = zext i16 %3 to i32
 %5 = ashr i32 %4, 11
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @lshiftrt_hi_12 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = zext i16 %3 to i32
 %5 = ashr i32 %4, 12
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @lshiftrt_hi_13 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = zext i16 %3 to i32
 %5 = ashr i32 %4, 13
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @lshiftrt_hi_14 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = zext i16 %3 to i32
 %5 = ashr i32 %4, 14
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @lshiftrt_hi_15 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = zext i16 %3 to i32
 %5 = ashr i32 %4, 15
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @ashiftrt_hi_0 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = sext i16 %3 to i32
 %5 = ashr i32 %4, 0
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @ashiftrt_hi_1 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = sext i16 %3 to i32
 %5 = ashr i32 %4, 1
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @ashiftrt_hi_2 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = sext i16 %3 to i32
 %5 = ashr i32 %4, 2
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @ashiftrt_hi_3 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = sext i16 %3 to i32
 %5 = ashr i32 %4, 3
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @ashiftrt_hi_4 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = sext i16 %3 to i32
 %5 = ashr i32 %4, 4
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @ashiftrt_hi_5 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = sext i16 %3 to i32
 %5 = ashr i32 %4, 5
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @ashiftrt_hi_6 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = sext i16 %3 to i32
 %5 = ashr i32 %4, 6
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @ashiftrt_hi_7 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = sext i16 %3 to i32
 %5 = ashr i32 %4, 7
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @ashiftrt_hi_8 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = sext i16 %3 to i32
 %5 = ashr i32 %4, 8
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @ashiftrt_hi_9 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = sext i16 %3 to i32
 %5 = ashr i32 %4, 9
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @ashiftrt_hi_10 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = sext i16 %3 to i32
 %5 = ashr i32 %4, 10
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @ashiftrt_hi_11 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = sext i16 %3 to i32
 %5 = ashr i32 %4, 11
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @ashiftrt_hi_12 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = sext i16 %3 to i32
 %5 = ashr i32 %4, 12
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @ashiftrt_hi_13 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = sext i16 %3 to i32
 %5 = ashr i32 %4, 13
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @ashiftrt_hi_14 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = sext i16 %3 to i32
 %5 = ashr i32 %4, 14
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i16 @ashiftrt_hi_15 (i16 %0) {
 %2 = alloca i16
 store i16 %0, i16* %2
 %3 = load i16, i16* %2
 %4 = sext i16 %3 to i32
 %5 = ashr i32 %4, 15
 %6 = trunc i32 %5 to i16
 ret i16 %6
}

define i32 @ashift_si_0 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = shl i32 %3, 0
 ret i32 %4
}

define i32 @ashift_si_1 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = shl i32 %3, 1
 ret i32 %4
}

define i32 @ashift_si_2 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = shl i32 %3, 2
 ret i32 %4
}

define i32 @ashift_si_3 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = shl i32 %3, 3
 ret i32 %4
}

define i32 @ashift_si_4 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = shl i32 %3, 4
 ret i32 %4
}

define i32 @ashift_si_5 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = shl i32 %3, 5
 ret i32 %4
}

define i32 @ashift_si_6 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = shl i32 %3, 6
 ret i32 %4
}

define i32 @ashift_si_7 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = shl i32 %3, 7
 ret i32 %4
}

define i32 @ashift_si_8 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = shl i32 %3, 8
 ret i32 %4
}

define i32 @ashift_si_9 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = shl i32 %3, 9
 ret i32 %4
}

define i32 @ashift_si_10 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = shl i32 %3, 10
 ret i32 %4
}

define i32 @ashift_si_11 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = shl i32 %3, 11
 ret i32 %4
}

define i32 @ashift_si_12 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = shl i32 %3, 12
 ret i32 %4
}

define i32 @ashift_si_13 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = shl i32 %3, 13
 ret i32 %4
}

define i32 @ashift_si_14 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = shl i32 %3, 14
 ret i32 %4
}

define i32 @ashift_si_15 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = shl i32 %3, 15
 ret i32 %4
}

define i32 @ashift_si_16 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = shl i32 %3, 16
 ret i32 %4
}

define i32 @ashift_si_17 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = shl i32 %3, 17
 ret i32 %4
}

define i32 @ashift_si_18 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = shl i32 %3, 18
 ret i32 %4
}

define i32 @ashift_si_19 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = shl i32 %3, 19
 ret i32 %4
}

define i32 @ashift_si_20 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = shl i32 %3, 20
 ret i32 %4
}

define i32 @ashift_si_21 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = shl i32 %3, 21
 ret i32 %4
}

define i32 @ashift_si_22 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = shl i32 %3, 22
 ret i32 %4
}

define i32 @ashift_si_23 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = shl i32 %3, 23
 ret i32 %4
}

define i32 @ashift_si_24 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = shl i32 %3, 24
 ret i32 %4
}

define i32 @ashift_si_25 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = shl i32 %3, 25
 ret i32 %4
}

define i32 @ashift_si_26 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = shl i32 %3, 26
 ret i32 %4
}

define i32 @ashift_si_27 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = shl i32 %3, 27
 ret i32 %4
}

define i32 @ashift_si_28 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = shl i32 %3, 28
 ret i32 %4
}

define i32 @ashift_si_29 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = shl i32 %3, 29
 ret i32 %4
}

define i32 @ashift_si_30 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = shl i32 %3, 30
 ret i32 %4
}

define i32 @ashift_si_31 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = shl i32 %3, 31
 ret i32 %4
}

define i32 @lshiftrt_si_0 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = lshr i32 %3, 0
 ret i32 %4
}

define i32 @lshiftrt_si_1 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = lshr i32 %3, 1
 ret i32 %4
}

define i32 @lshiftrt_si_2 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = lshr i32 %3, 2
 ret i32 %4
}

define i32 @lshiftrt_si_3 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = lshr i32 %3, 3
 ret i32 %4
}

define i32 @lshiftrt_si_4 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = lshr i32 %3, 4
 ret i32 %4
}

define i32 @lshiftrt_si_5 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = lshr i32 %3, 5
 ret i32 %4
}

define i32 @lshiftrt_si_6 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = lshr i32 %3, 6
 ret i32 %4
}

define i32 @lshiftrt_si_7 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = lshr i32 %3, 7
 ret i32 %4
}

define i32 @lshiftrt_si_8 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = lshr i32 %3, 8
 ret i32 %4
}

define i32 @lshiftrt_si_9 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = lshr i32 %3, 9
 ret i32 %4
}

define i32 @lshiftrt_si_10 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = lshr i32 %3, 10
 ret i32 %4
}

define i32 @lshiftrt_si_11 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = lshr i32 %3, 11
 ret i32 %4
}

define i32 @lshiftrt_si_12 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = lshr i32 %3, 12
 ret i32 %4
}

define i32 @lshiftrt_si_13 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = lshr i32 %3, 13
 ret i32 %4
}

define i32 @lshiftrt_si_14 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = lshr i32 %3, 14
 ret i32 %4
}

define i32 @lshiftrt_si_15 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = lshr i32 %3, 15
 ret i32 %4
}

define i32 @lshiftrt_si_16 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = lshr i32 %3, 16
 ret i32 %4
}

define i32 @lshiftrt_si_17 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = lshr i32 %3, 17
 ret i32 %4
}

define i32 @lshiftrt_si_18 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = lshr i32 %3, 18
 ret i32 %4
}

define i32 @lshiftrt_si_19 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = lshr i32 %3, 19
 ret i32 %4
}

define i32 @lshiftrt_si_20 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = lshr i32 %3, 20
 ret i32 %4
}

define i32 @lshiftrt_si_21 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = lshr i32 %3, 21
 ret i32 %4
}

define i32 @lshiftrt_si_22 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = lshr i32 %3, 22
 ret i32 %4
}

define i32 @lshiftrt_si_23 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = lshr i32 %3, 23
 ret i32 %4
}

define i32 @lshiftrt_si_24 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = lshr i32 %3, 24
 ret i32 %4
}

define i32 @lshiftrt_si_25 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = lshr i32 %3, 25
 ret i32 %4
}

define i32 @lshiftrt_si_26 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = lshr i32 %3, 26
 ret i32 %4
}

define i32 @lshiftrt_si_27 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = lshr i32 %3, 27
 ret i32 %4
}

define i32 @lshiftrt_si_28 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = lshr i32 %3, 28
 ret i32 %4
}

define i32 @lshiftrt_si_29 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = lshr i32 %3, 29
 ret i32 %4
}

define i32 @lshiftrt_si_30 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = lshr i32 %3, 30
 ret i32 %4
}

define i32 @lshiftrt_si_31 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = lshr i32 %3, 31
 ret i32 %4
}

define i32 @ashiftrt_si_0 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = ashr i32 %3, 0
 ret i32 %4
}

define i32 @ashiftrt_si_1 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = ashr i32 %3, 1
 ret i32 %4
}

define i32 @ashiftrt_si_2 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = ashr i32 %3, 2
 ret i32 %4
}

define i32 @ashiftrt_si_3 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = ashr i32 %3, 3
 ret i32 %4
}

define i32 @ashiftrt_si_4 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = ashr i32 %3, 4
 ret i32 %4
}

define i32 @ashiftrt_si_5 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = ashr i32 %3, 5
 ret i32 %4
}

define i32 @ashiftrt_si_6 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = ashr i32 %3, 6
 ret i32 %4
}

define i32 @ashiftrt_si_7 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = ashr i32 %3, 7
 ret i32 %4
}

define i32 @ashiftrt_si_8 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = ashr i32 %3, 8
 ret i32 %4
}

define i32 @ashiftrt_si_9 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = ashr i32 %3, 9
 ret i32 %4
}

define i32 @ashiftrt_si_10 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = ashr i32 %3, 10
 ret i32 %4
}

define i32 @ashiftrt_si_11 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = ashr i32 %3, 11
 ret i32 %4
}

define i32 @ashiftrt_si_12 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = ashr i32 %3, 12
 ret i32 %4
}

define i32 @ashiftrt_si_13 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = ashr i32 %3, 13
 ret i32 %4
}

define i32 @ashiftrt_si_14 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = ashr i32 %3, 14
 ret i32 %4
}

define i32 @ashiftrt_si_15 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = ashr i32 %3, 15
 ret i32 %4
}

define i32 @ashiftrt_si_16 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = ashr i32 %3, 16
 ret i32 %4
}

define i32 @ashiftrt_si_17 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = ashr i32 %3, 17
 ret i32 %4
}

define i32 @ashiftrt_si_18 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = ashr i32 %3, 18
 ret i32 %4
}

define i32 @ashiftrt_si_19 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = ashr i32 %3, 19
 ret i32 %4
}

define i32 @ashiftrt_si_20 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = ashr i32 %3, 20
 ret i32 %4
}

define i32 @ashiftrt_si_21 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = ashr i32 %3, 21
 ret i32 %4
}

define i32 @ashiftrt_si_22 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = ashr i32 %3, 22
 ret i32 %4
}

define i32 @ashiftrt_si_23 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = ashr i32 %3, 23
 ret i32 %4
}

define i32 @ashiftrt_si_24 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = ashr i32 %3, 24
 ret i32 %4
}

define i32 @ashiftrt_si_25 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = ashr i32 %3, 25
 ret i32 %4
}

define i32 @ashiftrt_si_26 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = ashr i32 %3, 26
 ret i32 %4
}

define i32 @ashiftrt_si_27 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = ashr i32 %3, 27
 ret i32 %4
}

define i32 @ashiftrt_si_28 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = ashr i32 %3, 28
 ret i32 %4
}

define i32 @ashiftrt_si_29 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = ashr i32 %3, 29
 ret i32 %4
}

define i32 @ashiftrt_si_30 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = ashr i32 %3, 30
 ret i32 %4
}

define i32 @ashiftrt_si_31 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = ashr i32 %3, 31
 ret i32 %4
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i8 @ashift_qi_0 (i8 -1)
 %3 = zext i8 %2 to i32
 %4 = icmp ne i32 %3, 255
 br i1 %4, label %5, label %6
5:
 call void @abort ()
 unreachable
6:
 %7 = call i8 @ashift_qi_1 (i8 -1)
 %8 = zext i8 %7 to i32
 %9 = icmp ne i32 %8, 254
 br i1 %9, label %10, label %11
10:
 call void @abort ()
 unreachable
11:
 %12 = call i8 @ashift_qi_2 (i8 -1)
 %13 = zext i8 %12 to i32
 %14 = icmp ne i32 %13, 252
 br i1 %14, label %15, label %16
15:
 call void @abort ()
 unreachable
16:
 %17 = call i8 @ashift_qi_3 (i8 -1)
 %18 = zext i8 %17 to i32
 %19 = icmp ne i32 %18, 248
 br i1 %19, label %20, label %21
20:
 call void @abort ()
 unreachable
21:
 %22 = call i8 @ashift_qi_4 (i8 -1)
 %23 = zext i8 %22 to i32
 %24 = icmp ne i32 %23, 240
 br i1 %24, label %25, label %26
25:
 call void @abort ()
 unreachable
26:
 %27 = call i8 @ashift_qi_5 (i8 -1)
 %28 = zext i8 %27 to i32
 %29 = icmp ne i32 %28, 224
 br i1 %29, label %30, label %31
30:
 call void @abort ()
 unreachable
31:
 %32 = call i8 @ashift_qi_6 (i8 -1)
 %33 = zext i8 %32 to i32
 %34 = icmp ne i32 %33, 192
 br i1 %34, label %35, label %36
35:
 call void @abort ()
 unreachable
36:
 %37 = call i8 @ashift_qi_7 (i8 -1)
 %38 = zext i8 %37 to i32
 %39 = icmp ne i32 %38, 128
 br i1 %39, label %40, label %41
40:
 call void @abort ()
 unreachable
41:
 %42 = call i8 @lshiftrt_qi_0 (i8 -1)
 %43 = zext i8 %42 to i32
 %44 = icmp ne i32 %43, 255
 br i1 %44, label %45, label %46
45:
 call void @abort ()
 unreachable
46:
 %47 = call i8 @lshiftrt_qi_1 (i8 -1)
 %48 = zext i8 %47 to i32
 %49 = icmp ne i32 %48, 127
 br i1 %49, label %50, label %51
50:
 call void @abort ()
 unreachable
51:
 %52 = call i8 @lshiftrt_qi_2 (i8 -1)
 %53 = zext i8 %52 to i32
 %54 = icmp ne i32 %53, 63
 br i1 %54, label %55, label %56
55:
 call void @abort ()
 unreachable
56:
 %57 = call i8 @lshiftrt_qi_3 (i8 -1)
 %58 = zext i8 %57 to i32
 %59 = icmp ne i32 %58, 31
 br i1 %59, label %60, label %61
60:
 call void @abort ()
 unreachable
61:
 %62 = call i8 @lshiftrt_qi_4 (i8 -1)
 %63 = zext i8 %62 to i32
 %64 = icmp ne i32 %63, 15
 br i1 %64, label %65, label %66
65:
 call void @abort ()
 unreachable
66:
 %67 = call i8 @lshiftrt_qi_5 (i8 -1)
 %68 = zext i8 %67 to i32
 %69 = icmp ne i32 %68, 7
 br i1 %69, label %70, label %71
70:
 call void @abort ()
 unreachable
71:
 %72 = call i8 @lshiftrt_qi_6 (i8 -1)
 %73 = zext i8 %72 to i32
 %74 = icmp ne i32 %73, 3
 br i1 %74, label %75, label %76
75:
 call void @abort ()
 unreachable
76:
 %77 = call i8 @lshiftrt_qi_7 (i8 -1)
 %78 = zext i8 %77 to i32
 %79 = icmp ne i32 %78, 1
 br i1 %79, label %80, label %81
80:
 call void @abort ()
 unreachable
81:
 %82 = call i8 @ashiftrt_qi_0 (i8 -1)
 %83 = sext i8 %82 to i32
 %84 = icmp ne i32 %83, -1
 br i1 %84, label %85, label %86
85:
 call void @abort ()
 unreachable
86:
 %87 = call i8 @ashiftrt_qi_1 (i8 -1)
 %88 = sext i8 %87 to i32
 %89 = icmp ne i32 %88, -1
 br i1 %89, label %90, label %91
90:
 call void @abort ()
 unreachable
91:
 %92 = call i8 @ashiftrt_qi_2 (i8 -1)
 %93 = sext i8 %92 to i32
 %94 = icmp ne i32 %93, -1
 br i1 %94, label %95, label %96
95:
 call void @abort ()
 unreachable
96:
 %97 = call i8 @ashiftrt_qi_3 (i8 -1)
 %98 = sext i8 %97 to i32
 %99 = icmp ne i32 %98, -1
 br i1 %99, label %100, label %101
100:
 call void @abort ()
 unreachable
101:
 %102 = call i8 @ashiftrt_qi_4 (i8 -1)
 %103 = sext i8 %102 to i32
 %104 = icmp ne i32 %103, -1
 br i1 %104, label %105, label %106
105:
 call void @abort ()
 unreachable
106:
 %107 = call i8 @ashiftrt_qi_5 (i8 -1)
 %108 = sext i8 %107 to i32
 %109 = icmp ne i32 %108, -1
 br i1 %109, label %110, label %111
110:
 call void @abort ()
 unreachable
111:
 %112 = call i8 @ashiftrt_qi_6 (i8 -1)
 %113 = sext i8 %112 to i32
 %114 = icmp ne i32 %113, -1
 br i1 %114, label %115, label %116
115:
 call void @abort ()
 unreachable
116:
 %117 = call i8 @ashiftrt_qi_7 (i8 -1)
 %118 = sext i8 %117 to i32
 %119 = icmp ne i32 %118, -1
 br i1 %119, label %120, label %121
120:
 call void @abort ()
 unreachable
121:
 %122 = call i8 @ashiftrt_qi_0 (i8 0)
 %123 = sext i8 %122 to i32
 %124 = icmp ne i32 %123, 0
 br i1 %124, label %125, label %126
125:
 call void @abort ()
 unreachable
126:
 %127 = call i8 @ashiftrt_qi_1 (i8 0)
 %128 = sext i8 %127 to i32
 %129 = icmp ne i32 %128, 0
 br i1 %129, label %130, label %131
130:
 call void @abort ()
 unreachable
131:
 %132 = call i8 @ashiftrt_qi_2 (i8 0)
 %133 = sext i8 %132 to i32
 %134 = icmp ne i32 %133, 0
 br i1 %134, label %135, label %136
135:
 call void @abort ()
 unreachable
136:
 %137 = call i8 @ashiftrt_qi_3 (i8 0)
 %138 = sext i8 %137 to i32
 %139 = icmp ne i32 %138, 0
 br i1 %139, label %140, label %141
140:
 call void @abort ()
 unreachable
141:
 %142 = call i8 @ashiftrt_qi_4 (i8 0)
 %143 = sext i8 %142 to i32
 %144 = icmp ne i32 %143, 0
 br i1 %144, label %145, label %146
145:
 call void @abort ()
 unreachable
146:
 %147 = call i8 @ashiftrt_qi_5 (i8 0)
 %148 = sext i8 %147 to i32
 %149 = icmp ne i32 %148, 0
 br i1 %149, label %150, label %151
150:
 call void @abort ()
 unreachable
151:
 %152 = call i8 @ashiftrt_qi_6 (i8 0)
 %153 = sext i8 %152 to i32
 %154 = icmp ne i32 %153, 0
 br i1 %154, label %155, label %156
155:
 call void @abort ()
 unreachable
156:
 %157 = call i8 @ashiftrt_qi_7 (i8 0)
 %158 = sext i8 %157 to i32
 %159 = icmp ne i32 %158, 0
 br i1 %159, label %160, label %161
160:
 call void @abort ()
 unreachable
161:
 %162 = call i16 @ashift_hi_0 (i16 -1)
 %163 = zext i16 %162 to i32
 %164 = icmp ne i32 %163, 65535
 br i1 %164, label %165, label %166
165:
 call void @abort ()
 unreachable
166:
 %167 = call i16 @ashift_hi_1 (i16 -1)
 %168 = zext i16 %167 to i32
 %169 = icmp ne i32 %168, 65534
 br i1 %169, label %170, label %171
170:
 call void @abort ()
 unreachable
171:
 %172 = call i16 @ashift_hi_2 (i16 -1)
 %173 = zext i16 %172 to i32
 %174 = icmp ne i32 %173, 65532
 br i1 %174, label %175, label %176
175:
 call void @abort ()
 unreachable
176:
 %177 = call i16 @ashift_hi_3 (i16 -1)
 %178 = zext i16 %177 to i32
 %179 = icmp ne i32 %178, 65528
 br i1 %179, label %180, label %181
180:
 call void @abort ()
 unreachable
181:
 %182 = call i16 @ashift_hi_4 (i16 -1)
 %183 = zext i16 %182 to i32
 %184 = icmp ne i32 %183, 65520
 br i1 %184, label %185, label %186
185:
 call void @abort ()
 unreachable
186:
 %187 = call i16 @ashift_hi_5 (i16 -1)
 %188 = zext i16 %187 to i32
 %189 = icmp ne i32 %188, 65504
 br i1 %189, label %190, label %191
190:
 call void @abort ()
 unreachable
191:
 %192 = call i16 @ashift_hi_6 (i16 -1)
 %193 = zext i16 %192 to i32
 %194 = icmp ne i32 %193, 65472
 br i1 %194, label %195, label %196
195:
 call void @abort ()
 unreachable
196:
 %197 = call i16 @ashift_hi_7 (i16 -1)
 %198 = zext i16 %197 to i32
 %199 = icmp ne i32 %198, 65408
 br i1 %199, label %200, label %201
200:
 call void @abort ()
 unreachable
201:
 %202 = call i16 @ashift_hi_8 (i16 -1)
 %203 = zext i16 %202 to i32
 %204 = icmp ne i32 %203, 65280
 br i1 %204, label %205, label %206
205:
 call void @abort ()
 unreachable
206:
 %207 = call i16 @ashift_hi_9 (i16 -1)
 %208 = zext i16 %207 to i32
 %209 = icmp ne i32 %208, 65024
 br i1 %209, label %210, label %211
210:
 call void @abort ()
 unreachable
211:
 %212 = call i16 @ashift_hi_10 (i16 -1)
 %213 = zext i16 %212 to i32
 %214 = icmp ne i32 %213, 64512
 br i1 %214, label %215, label %216
215:
 call void @abort ()
 unreachable
216:
 %217 = call i16 @ashift_hi_11 (i16 -1)
 %218 = zext i16 %217 to i32
 %219 = icmp ne i32 %218, 63488
 br i1 %219, label %220, label %221
220:
 call void @abort ()
 unreachable
221:
 %222 = call i16 @ashift_hi_12 (i16 -1)
 %223 = zext i16 %222 to i32
 %224 = icmp ne i32 %223, 61440
 br i1 %224, label %225, label %226
225:
 call void @abort ()
 unreachable
226:
 %227 = call i16 @ashift_hi_13 (i16 -1)
 %228 = zext i16 %227 to i32
 %229 = icmp ne i32 %228, 57344
 br i1 %229, label %230, label %231
230:
 call void @abort ()
 unreachable
231:
 %232 = call i16 @ashift_hi_14 (i16 -1)
 %233 = zext i16 %232 to i32
 %234 = icmp ne i32 %233, 49152
 br i1 %234, label %235, label %236
235:
 call void @abort ()
 unreachable
236:
 %237 = call i16 @ashift_hi_15 (i16 -1)
 %238 = zext i16 %237 to i32
 %239 = icmp ne i32 %238, 32768
 br i1 %239, label %240, label %241
240:
 call void @abort ()
 unreachable
241:
 %242 = call i16 @lshiftrt_hi_0 (i16 -1)
 %243 = zext i16 %242 to i32
 %244 = icmp ne i32 %243, 65535
 br i1 %244, label %245, label %246
245:
 call void @abort ()
 unreachable
246:
 %247 = call i16 @lshiftrt_hi_1 (i16 -1)
 %248 = zext i16 %247 to i32
 %249 = icmp ne i32 %248, 32767
 br i1 %249, label %250, label %251
250:
 call void @abort ()
 unreachable
251:
 %252 = call i16 @lshiftrt_hi_2 (i16 -1)
 %253 = zext i16 %252 to i32
 %254 = icmp ne i32 %253, 16383
 br i1 %254, label %255, label %256
255:
 call void @abort ()
 unreachable
256:
 %257 = call i16 @lshiftrt_hi_3 (i16 -1)
 %258 = zext i16 %257 to i32
 %259 = icmp ne i32 %258, 8191
 br i1 %259, label %260, label %261
260:
 call void @abort ()
 unreachable
261:
 %262 = call i16 @lshiftrt_hi_4 (i16 -1)
 %263 = zext i16 %262 to i32
 %264 = icmp ne i32 %263, 4095
 br i1 %264, label %265, label %266
265:
 call void @abort ()
 unreachable
266:
 %267 = call i16 @lshiftrt_hi_5 (i16 -1)
 %268 = zext i16 %267 to i32
 %269 = icmp ne i32 %268, 2047
 br i1 %269, label %270, label %271
270:
 call void @abort ()
 unreachable
271:
 %272 = call i16 @lshiftrt_hi_6 (i16 -1)
 %273 = zext i16 %272 to i32
 %274 = icmp ne i32 %273, 1023
 br i1 %274, label %275, label %276
275:
 call void @abort ()
 unreachable
276:
 %277 = call i16 @lshiftrt_hi_7 (i16 -1)
 %278 = zext i16 %277 to i32
 %279 = icmp ne i32 %278, 511
 br i1 %279, label %280, label %281
280:
 call void @abort ()
 unreachable
281:
 %282 = call i16 @lshiftrt_hi_8 (i16 -1)
 %283 = zext i16 %282 to i32
 %284 = icmp ne i32 %283, 255
 br i1 %284, label %285, label %286
285:
 call void @abort ()
 unreachable
286:
 %287 = call i16 @lshiftrt_hi_9 (i16 -1)
 %288 = zext i16 %287 to i32
 %289 = icmp ne i32 %288, 127
 br i1 %289, label %290, label %291
290:
 call void @abort ()
 unreachable
291:
 %292 = call i16 @lshiftrt_hi_10 (i16 -1)
 %293 = zext i16 %292 to i32
 %294 = icmp ne i32 %293, 63
 br i1 %294, label %295, label %296
295:
 call void @abort ()
 unreachable
296:
 %297 = call i16 @lshiftrt_hi_11 (i16 -1)
 %298 = zext i16 %297 to i32
 %299 = icmp ne i32 %298, 31
 br i1 %299, label %300, label %301
300:
 call void @abort ()
 unreachable
301:
 %302 = call i16 @lshiftrt_hi_12 (i16 -1)
 %303 = zext i16 %302 to i32
 %304 = icmp ne i32 %303, 15
 br i1 %304, label %305, label %306
305:
 call void @abort ()
 unreachable
306:
 %307 = call i16 @lshiftrt_hi_13 (i16 -1)
 %308 = zext i16 %307 to i32
 %309 = icmp ne i32 %308, 7
 br i1 %309, label %310, label %311
310:
 call void @abort ()
 unreachable
311:
 %312 = call i16 @lshiftrt_hi_14 (i16 -1)
 %313 = zext i16 %312 to i32
 %314 = icmp ne i32 %313, 3
 br i1 %314, label %315, label %316
315:
 call void @abort ()
 unreachable
316:
 %317 = call i16 @lshiftrt_hi_15 (i16 -1)
 %318 = zext i16 %317 to i32
 %319 = icmp ne i32 %318, 1
 br i1 %319, label %320, label %321
320:
 call void @abort ()
 unreachable
321:
 %322 = call i16 @ashiftrt_hi_0 (i16 -1)
 %323 = sext i16 %322 to i32
 %324 = icmp ne i32 %323, -1
 br i1 %324, label %325, label %326
325:
 call void @abort ()
 unreachable
326:
 %327 = call i16 @ashiftrt_hi_1 (i16 -1)
 %328 = sext i16 %327 to i32
 %329 = icmp ne i32 %328, -1
 br i1 %329, label %330, label %331
330:
 call void @abort ()
 unreachable
331:
 %332 = call i16 @ashiftrt_hi_2 (i16 -1)
 %333 = sext i16 %332 to i32
 %334 = icmp ne i32 %333, -1
 br i1 %334, label %335, label %336
335:
 call void @abort ()
 unreachable
336:
 %337 = call i16 @ashiftrt_hi_3 (i16 -1)
 %338 = sext i16 %337 to i32
 %339 = icmp ne i32 %338, -1
 br i1 %339, label %340, label %341
340:
 call void @abort ()
 unreachable
341:
 %342 = call i16 @ashiftrt_hi_4 (i16 -1)
 %343 = sext i16 %342 to i32
 %344 = icmp ne i32 %343, -1
 br i1 %344, label %345, label %346
345:
 call void @abort ()
 unreachable
346:
 %347 = call i16 @ashiftrt_hi_5 (i16 -1)
 %348 = sext i16 %347 to i32
 %349 = icmp ne i32 %348, -1
 br i1 %349, label %350, label %351
350:
 call void @abort ()
 unreachable
351:
 %352 = call i16 @ashiftrt_hi_6 (i16 -1)
 %353 = sext i16 %352 to i32
 %354 = icmp ne i32 %353, -1
 br i1 %354, label %355, label %356
355:
 call void @abort ()
 unreachable
356:
 %357 = call i16 @ashiftrt_hi_7 (i16 -1)
 %358 = sext i16 %357 to i32
 %359 = icmp ne i32 %358, -1
 br i1 %359, label %360, label %361
360:
 call void @abort ()
 unreachable
361:
 %362 = call i16 @ashiftrt_hi_8 (i16 -1)
 %363 = sext i16 %362 to i32
 %364 = icmp ne i32 %363, -1
 br i1 %364, label %365, label %366
365:
 call void @abort ()
 unreachable
366:
 %367 = call i16 @ashiftrt_hi_9 (i16 -1)
 %368 = sext i16 %367 to i32
 %369 = icmp ne i32 %368, -1
 br i1 %369, label %370, label %371
370:
 call void @abort ()
 unreachable
371:
 %372 = call i16 @ashiftrt_hi_10 (i16 -1)
 %373 = sext i16 %372 to i32
 %374 = icmp ne i32 %373, -1
 br i1 %374, label %375, label %376
375:
 call void @abort ()
 unreachable
376:
 %377 = call i16 @ashiftrt_hi_11 (i16 -1)
 %378 = sext i16 %377 to i32
 %379 = icmp ne i32 %378, -1
 br i1 %379, label %380, label %381
380:
 call void @abort ()
 unreachable
381:
 %382 = call i16 @ashiftrt_hi_12 (i16 -1)
 %383 = sext i16 %382 to i32
 %384 = icmp ne i32 %383, -1
 br i1 %384, label %385, label %386
385:
 call void @abort ()
 unreachable
386:
 %387 = call i16 @ashiftrt_hi_13 (i16 -1)
 %388 = sext i16 %387 to i32
 %389 = icmp ne i32 %388, -1
 br i1 %389, label %390, label %391
390:
 call void @abort ()
 unreachable
391:
 %392 = call i16 @ashiftrt_hi_14 (i16 -1)
 %393 = sext i16 %392 to i32
 %394 = icmp ne i32 %393, -1
 br i1 %394, label %395, label %396
395:
 call void @abort ()
 unreachable
396:
 %397 = call i16 @ashiftrt_hi_15 (i16 -1)
 %398 = sext i16 %397 to i32
 %399 = icmp ne i32 %398, -1
 br i1 %399, label %400, label %401
400:
 call void @abort ()
 unreachable
401:
 %402 = call i16 @ashiftrt_hi_0 (i16 0)
 %403 = sext i16 %402 to i32
 %404 = icmp ne i32 %403, 0
 br i1 %404, label %405, label %406
405:
 call void @abort ()
 unreachable
406:
 %407 = call i16 @ashiftrt_hi_1 (i16 0)
 %408 = sext i16 %407 to i32
 %409 = icmp ne i32 %408, 0
 br i1 %409, label %410, label %411
410:
 call void @abort ()
 unreachable
411:
 %412 = call i16 @ashiftrt_hi_2 (i16 0)
 %413 = sext i16 %412 to i32
 %414 = icmp ne i32 %413, 0
 br i1 %414, label %415, label %416
415:
 call void @abort ()
 unreachable
416:
 %417 = call i16 @ashiftrt_hi_3 (i16 0)
 %418 = sext i16 %417 to i32
 %419 = icmp ne i32 %418, 0
 br i1 %419, label %420, label %421
420:
 call void @abort ()
 unreachable
421:
 %422 = call i16 @ashiftrt_hi_4 (i16 0)
 %423 = sext i16 %422 to i32
 %424 = icmp ne i32 %423, 0
 br i1 %424, label %425, label %426
425:
 call void @abort ()
 unreachable
426:
 %427 = call i16 @ashiftrt_hi_5 (i16 0)
 %428 = sext i16 %427 to i32
 %429 = icmp ne i32 %428, 0
 br i1 %429, label %430, label %431
430:
 call void @abort ()
 unreachable
431:
 %432 = call i16 @ashiftrt_hi_6 (i16 0)
 %433 = sext i16 %432 to i32
 %434 = icmp ne i32 %433, 0
 br i1 %434, label %435, label %436
435:
 call void @abort ()
 unreachable
436:
 %437 = call i16 @ashiftrt_hi_7 (i16 0)
 %438 = sext i16 %437 to i32
 %439 = icmp ne i32 %438, 0
 br i1 %439, label %440, label %441
440:
 call void @abort ()
 unreachable
441:
 %442 = call i16 @ashiftrt_hi_8 (i16 0)
 %443 = sext i16 %442 to i32
 %444 = icmp ne i32 %443, 0
 br i1 %444, label %445, label %446
445:
 call void @abort ()
 unreachable
446:
 %447 = call i16 @ashiftrt_hi_9 (i16 0)
 %448 = sext i16 %447 to i32
 %449 = icmp ne i32 %448, 0
 br i1 %449, label %450, label %451
450:
 call void @abort ()
 unreachable
451:
 %452 = call i16 @ashiftrt_hi_10 (i16 0)
 %453 = sext i16 %452 to i32
 %454 = icmp ne i32 %453, 0
 br i1 %454, label %455, label %456
455:
 call void @abort ()
 unreachable
456:
 %457 = call i16 @ashiftrt_hi_11 (i16 0)
 %458 = sext i16 %457 to i32
 %459 = icmp ne i32 %458, 0
 br i1 %459, label %460, label %461
460:
 call void @abort ()
 unreachable
461:
 %462 = call i16 @ashiftrt_hi_12 (i16 0)
 %463 = sext i16 %462 to i32
 %464 = icmp ne i32 %463, 0
 br i1 %464, label %465, label %466
465:
 call void @abort ()
 unreachable
466:
 %467 = call i16 @ashiftrt_hi_13 (i16 0)
 %468 = sext i16 %467 to i32
 %469 = icmp ne i32 %468, 0
 br i1 %469, label %470, label %471
470:
 call void @abort ()
 unreachable
471:
 %472 = call i16 @ashiftrt_hi_14 (i16 0)
 %473 = sext i16 %472 to i32
 %474 = icmp ne i32 %473, 0
 br i1 %474, label %475, label %476
475:
 call void @abort ()
 unreachable
476:
 %477 = call i16 @ashiftrt_hi_15 (i16 0)
 %478 = sext i16 %477 to i32
 %479 = icmp ne i32 %478, 0
 br i1 %479, label %480, label %481
480:
 call void @abort ()
 unreachable
481:
 %482 = call i32 @ashift_si_0 (i32 -1)
 %483 = icmp ne i32 %482, -1
 br i1 %483, label %484, label %485
484:
 call void @abort ()
 unreachable
485:
 %486 = call i32 @ashift_si_1 (i32 -1)
 %487 = icmp ne i32 %486, -2
 br i1 %487, label %488, label %489
488:
 call void @abort ()
 unreachable
489:
 %490 = call i32 @ashift_si_2 (i32 -1)
 %491 = icmp ne i32 %490, -4
 br i1 %491, label %492, label %493
492:
 call void @abort ()
 unreachable
493:
 %494 = call i32 @ashift_si_3 (i32 -1)
 %495 = icmp ne i32 %494, -8
 br i1 %495, label %496, label %497
496:
 call void @abort ()
 unreachable
497:
 %498 = call i32 @ashift_si_4 (i32 -1)
 %499 = icmp ne i32 %498, -16
 br i1 %499, label %500, label %501
500:
 call void @abort ()
 unreachable
501:
 %502 = call i32 @ashift_si_5 (i32 -1)
 %503 = icmp ne i32 %502, -32
 br i1 %503, label %504, label %505
504:
 call void @abort ()
 unreachable
505:
 %506 = call i32 @ashift_si_6 (i32 -1)
 %507 = icmp ne i32 %506, -64
 br i1 %507, label %508, label %509
508:
 call void @abort ()
 unreachable
509:
 %510 = call i32 @ashift_si_7 (i32 -1)
 %511 = icmp ne i32 %510, -128
 br i1 %511, label %512, label %513
512:
 call void @abort ()
 unreachable
513:
 %514 = call i32 @ashift_si_8 (i32 -1)
 %515 = icmp ne i32 %514, -256
 br i1 %515, label %516, label %517
516:
 call void @abort ()
 unreachable
517:
 %518 = call i32 @ashift_si_9 (i32 -1)
 %519 = icmp ne i32 %518, -512
 br i1 %519, label %520, label %521
520:
 call void @abort ()
 unreachable
521:
 %522 = call i32 @ashift_si_10 (i32 -1)
 %523 = icmp ne i32 %522, -1024
 br i1 %523, label %524, label %525
524:
 call void @abort ()
 unreachable
525:
 %526 = call i32 @ashift_si_11 (i32 -1)
 %527 = icmp ne i32 %526, -2048
 br i1 %527, label %528, label %529
528:
 call void @abort ()
 unreachable
529:
 %530 = call i32 @ashift_si_12 (i32 -1)
 %531 = icmp ne i32 %530, -4096
 br i1 %531, label %532, label %533
532:
 call void @abort ()
 unreachable
533:
 %534 = call i32 @ashift_si_13 (i32 -1)
 %535 = icmp ne i32 %534, -8192
 br i1 %535, label %536, label %537
536:
 call void @abort ()
 unreachable
537:
 %538 = call i32 @ashift_si_14 (i32 -1)
 %539 = icmp ne i32 %538, -16384
 br i1 %539, label %540, label %541
540:
 call void @abort ()
 unreachable
541:
 %542 = call i32 @ashift_si_15 (i32 -1)
 %543 = icmp ne i32 %542, -32768
 br i1 %543, label %544, label %545
544:
 call void @abort ()
 unreachable
545:
 %546 = call i32 @ashift_si_16 (i32 -1)
 %547 = icmp ne i32 %546, -65536
 br i1 %547, label %548, label %549
548:
 call void @abort ()
 unreachable
549:
 %550 = call i32 @ashift_si_17 (i32 -1)
 %551 = icmp ne i32 %550, -131072
 br i1 %551, label %552, label %553
552:
 call void @abort ()
 unreachable
553:
 %554 = call i32 @ashift_si_18 (i32 -1)
 %555 = icmp ne i32 %554, -262144
 br i1 %555, label %556, label %557
556:
 call void @abort ()
 unreachable
557:
 %558 = call i32 @ashift_si_19 (i32 -1)
 %559 = icmp ne i32 %558, -524288
 br i1 %559, label %560, label %561
560:
 call void @abort ()
 unreachable
561:
 %562 = call i32 @ashift_si_20 (i32 -1)
 %563 = icmp ne i32 %562, -1048576
 br i1 %563, label %564, label %565
564:
 call void @abort ()
 unreachable
565:
 %566 = call i32 @ashift_si_21 (i32 -1)
 %567 = icmp ne i32 %566, -2097152
 br i1 %567, label %568, label %569
568:
 call void @abort ()
 unreachable
569:
 %570 = call i32 @ashift_si_22 (i32 -1)
 %571 = icmp ne i32 %570, -4194304
 br i1 %571, label %572, label %573
572:
 call void @abort ()
 unreachable
573:
 %574 = call i32 @ashift_si_23 (i32 -1)
 %575 = icmp ne i32 %574, -8388608
 br i1 %575, label %576, label %577
576:
 call void @abort ()
 unreachable
577:
 %578 = call i32 @ashift_si_24 (i32 -1)
 %579 = icmp ne i32 %578, -16777216
 br i1 %579, label %580, label %581
580:
 call void @abort ()
 unreachable
581:
 %582 = call i32 @ashift_si_25 (i32 -1)
 %583 = icmp ne i32 %582, -33554432
 br i1 %583, label %584, label %585
584:
 call void @abort ()
 unreachable
585:
 %586 = call i32 @ashift_si_26 (i32 -1)
 %587 = icmp ne i32 %586, -67108864
 br i1 %587, label %588, label %589
588:
 call void @abort ()
 unreachable
589:
 %590 = call i32 @ashift_si_27 (i32 -1)
 %591 = icmp ne i32 %590, -134217728
 br i1 %591, label %592, label %593
592:
 call void @abort ()
 unreachable
593:
 %594 = call i32 @ashift_si_28 (i32 -1)
 %595 = icmp ne i32 %594, -268435456
 br i1 %595, label %596, label %597
596:
 call void @abort ()
 unreachable
597:
 %598 = call i32 @ashift_si_29 (i32 -1)
 %599 = icmp ne i32 %598, -536870912
 br i1 %599, label %600, label %601
600:
 call void @abort ()
 unreachable
601:
 %602 = call i32 @ashift_si_30 (i32 -1)
 %603 = icmp ne i32 %602, -1073741824
 br i1 %603, label %604, label %605
604:
 call void @abort ()
 unreachable
605:
 %606 = call i32 @ashift_si_31 (i32 -1)
 %607 = icmp ne i32 %606, -2147483648
 br i1 %607, label %608, label %609
608:
 call void @abort ()
 unreachable
609:
 %610 = call i32 @lshiftrt_si_0 (i32 -1)
 %611 = icmp ne i32 %610, -1
 br i1 %611, label %612, label %613
612:
 call void @abort ()
 unreachable
613:
 %614 = call i32 @lshiftrt_si_1 (i32 -1)
 %615 = icmp ne i32 %614, 2147483647
 br i1 %615, label %616, label %617
616:
 call void @abort ()
 unreachable
617:
 %618 = call i32 @lshiftrt_si_2 (i32 -1)
 %619 = icmp ne i32 %618, 1073741823
 br i1 %619, label %620, label %621
620:
 call void @abort ()
 unreachable
621:
 %622 = call i32 @lshiftrt_si_3 (i32 -1)
 %623 = icmp ne i32 %622, 536870911
 br i1 %623, label %624, label %625
624:
 call void @abort ()
 unreachable
625:
 %626 = call i32 @lshiftrt_si_4 (i32 -1)
 %627 = icmp ne i32 %626, 268435455
 br i1 %627, label %628, label %629
628:
 call void @abort ()
 unreachable
629:
 %630 = call i32 @lshiftrt_si_5 (i32 -1)
 %631 = icmp ne i32 %630, 134217727
 br i1 %631, label %632, label %633
632:
 call void @abort ()
 unreachable
633:
 %634 = call i32 @lshiftrt_si_6 (i32 -1)
 %635 = icmp ne i32 %634, 67108863
 br i1 %635, label %636, label %637
636:
 call void @abort ()
 unreachable
637:
 %638 = call i32 @lshiftrt_si_7 (i32 -1)
 %639 = icmp ne i32 %638, 33554431
 br i1 %639, label %640, label %641
640:
 call void @abort ()
 unreachable
641:
 %642 = call i32 @lshiftrt_si_8 (i32 -1)
 %643 = icmp ne i32 %642, 16777215
 br i1 %643, label %644, label %645
644:
 call void @abort ()
 unreachable
645:
 %646 = call i32 @lshiftrt_si_9 (i32 -1)
 %647 = icmp ne i32 %646, 8388607
 br i1 %647, label %648, label %649
648:
 call void @abort ()
 unreachable
649:
 %650 = call i32 @lshiftrt_si_10 (i32 -1)
 %651 = icmp ne i32 %650, 4194303
 br i1 %651, label %652, label %653
652:
 call void @abort ()
 unreachable
653:
 %654 = call i32 @lshiftrt_si_11 (i32 -1)
 %655 = icmp ne i32 %654, 2097151
 br i1 %655, label %656, label %657
656:
 call void @abort ()
 unreachable
657:
 %658 = call i32 @lshiftrt_si_12 (i32 -1)
 %659 = icmp ne i32 %658, 1048575
 br i1 %659, label %660, label %661
660:
 call void @abort ()
 unreachable
661:
 %662 = call i32 @lshiftrt_si_13 (i32 -1)
 %663 = icmp ne i32 %662, 524287
 br i1 %663, label %664, label %665
664:
 call void @abort ()
 unreachable
665:
 %666 = call i32 @lshiftrt_si_14 (i32 -1)
 %667 = icmp ne i32 %666, 262143
 br i1 %667, label %668, label %669
668:
 call void @abort ()
 unreachable
669:
 %670 = call i32 @lshiftrt_si_15 (i32 -1)
 %671 = icmp ne i32 %670, 131071
 br i1 %671, label %672, label %673
672:
 call void @abort ()
 unreachable
673:
 %674 = call i32 @lshiftrt_si_16 (i32 -1)
 %675 = icmp ne i32 %674, 65535
 br i1 %675, label %676, label %677
676:
 call void @abort ()
 unreachable
677:
 %678 = call i32 @lshiftrt_si_17 (i32 -1)
 %679 = icmp ne i32 %678, 32767
 br i1 %679, label %680, label %681
680:
 call void @abort ()
 unreachable
681:
 %682 = call i32 @lshiftrt_si_18 (i32 -1)
 %683 = icmp ne i32 %682, 16383
 br i1 %683, label %684, label %685
684:
 call void @abort ()
 unreachable
685:
 %686 = call i32 @lshiftrt_si_19 (i32 -1)
 %687 = icmp ne i32 %686, 8191
 br i1 %687, label %688, label %689
688:
 call void @abort ()
 unreachable
689:
 %690 = call i32 @lshiftrt_si_20 (i32 -1)
 %691 = icmp ne i32 %690, 4095
 br i1 %691, label %692, label %693
692:
 call void @abort ()
 unreachable
693:
 %694 = call i32 @lshiftrt_si_21 (i32 -1)
 %695 = icmp ne i32 %694, 2047
 br i1 %695, label %696, label %697
696:
 call void @abort ()
 unreachable
697:
 %698 = call i32 @lshiftrt_si_22 (i32 -1)
 %699 = icmp ne i32 %698, 1023
 br i1 %699, label %700, label %701
700:
 call void @abort ()
 unreachable
701:
 %702 = call i32 @lshiftrt_si_23 (i32 -1)
 %703 = icmp ne i32 %702, 511
 br i1 %703, label %704, label %705
704:
 call void @abort ()
 unreachable
705:
 %706 = call i32 @lshiftrt_si_24 (i32 -1)
 %707 = icmp ne i32 %706, 255
 br i1 %707, label %708, label %709
708:
 call void @abort ()
 unreachable
709:
 %710 = call i32 @lshiftrt_si_25 (i32 -1)
 %711 = icmp ne i32 %710, 127
 br i1 %711, label %712, label %713
712:
 call void @abort ()
 unreachable
713:
 %714 = call i32 @lshiftrt_si_26 (i32 -1)
 %715 = icmp ne i32 %714, 63
 br i1 %715, label %716, label %717
716:
 call void @abort ()
 unreachable
717:
 %718 = call i32 @lshiftrt_si_27 (i32 -1)
 %719 = icmp ne i32 %718, 31
 br i1 %719, label %720, label %721
720:
 call void @abort ()
 unreachable
721:
 %722 = call i32 @lshiftrt_si_28 (i32 -1)
 %723 = icmp ne i32 %722, 15
 br i1 %723, label %724, label %725
724:
 call void @abort ()
 unreachable
725:
 %726 = call i32 @lshiftrt_si_29 (i32 -1)
 %727 = icmp ne i32 %726, 7
 br i1 %727, label %728, label %729
728:
 call void @abort ()
 unreachable
729:
 %730 = call i32 @lshiftrt_si_30 (i32 -1)
 %731 = icmp ne i32 %730, 3
 br i1 %731, label %732, label %733
732:
 call void @abort ()
 unreachable
733:
 %734 = call i32 @lshiftrt_si_31 (i32 -1)
 %735 = icmp ne i32 %734, 1
 br i1 %735, label %736, label %737
736:
 call void @abort ()
 unreachable
737:
 %738 = call i32 @ashiftrt_si_0 (i32 -1)
 %739 = icmp ne i32 %738, -1
 br i1 %739, label %740, label %741
740:
 call void @abort ()
 unreachable
741:
 %742 = call i32 @ashiftrt_si_1 (i32 -1)
 %743 = icmp ne i32 %742, -1
 br i1 %743, label %744, label %745
744:
 call void @abort ()
 unreachable
745:
 %746 = call i32 @ashiftrt_si_2 (i32 -1)
 %747 = icmp ne i32 %746, -1
 br i1 %747, label %748, label %749
748:
 call void @abort ()
 unreachable
749:
 %750 = call i32 @ashiftrt_si_3 (i32 -1)
 %751 = icmp ne i32 %750, -1
 br i1 %751, label %752, label %753
752:
 call void @abort ()
 unreachable
753:
 %754 = call i32 @ashiftrt_si_4 (i32 -1)
 %755 = icmp ne i32 %754, -1
 br i1 %755, label %756, label %757
756:
 call void @abort ()
 unreachable
757:
 %758 = call i32 @ashiftrt_si_5 (i32 -1)
 %759 = icmp ne i32 %758, -1
 br i1 %759, label %760, label %761
760:
 call void @abort ()
 unreachable
761:
 %762 = call i32 @ashiftrt_si_6 (i32 -1)
 %763 = icmp ne i32 %762, -1
 br i1 %763, label %764, label %765
764:
 call void @abort ()
 unreachable
765:
 %766 = call i32 @ashiftrt_si_7 (i32 -1)
 %767 = icmp ne i32 %766, -1
 br i1 %767, label %768, label %769
768:
 call void @abort ()
 unreachable
769:
 %770 = call i32 @ashiftrt_si_8 (i32 -1)
 %771 = icmp ne i32 %770, -1
 br i1 %771, label %772, label %773
772:
 call void @abort ()
 unreachable
773:
 %774 = call i32 @ashiftrt_si_9 (i32 -1)
 %775 = icmp ne i32 %774, -1
 br i1 %775, label %776, label %777
776:
 call void @abort ()
 unreachable
777:
 %778 = call i32 @ashiftrt_si_10 (i32 -1)
 %779 = icmp ne i32 %778, -1
 br i1 %779, label %780, label %781
780:
 call void @abort ()
 unreachable
781:
 %782 = call i32 @ashiftrt_si_11 (i32 -1)
 %783 = icmp ne i32 %782, -1
 br i1 %783, label %784, label %785
784:
 call void @abort ()
 unreachable
785:
 %786 = call i32 @ashiftrt_si_12 (i32 -1)
 %787 = icmp ne i32 %786, -1
 br i1 %787, label %788, label %789
788:
 call void @abort ()
 unreachable
789:
 %790 = call i32 @ashiftrt_si_13 (i32 -1)
 %791 = icmp ne i32 %790, -1
 br i1 %791, label %792, label %793
792:
 call void @abort ()
 unreachable
793:
 %794 = call i32 @ashiftrt_si_14 (i32 -1)
 %795 = icmp ne i32 %794, -1
 br i1 %795, label %796, label %797
796:
 call void @abort ()
 unreachable
797:
 %798 = call i32 @ashiftrt_si_15 (i32 -1)
 %799 = icmp ne i32 %798, -1
 br i1 %799, label %800, label %801
800:
 call void @abort ()
 unreachable
801:
 %802 = call i32 @ashiftrt_si_16 (i32 -1)
 %803 = icmp ne i32 %802, -1
 br i1 %803, label %804, label %805
804:
 call void @abort ()
 unreachable
805:
 %806 = call i32 @ashiftrt_si_17 (i32 -1)
 %807 = icmp ne i32 %806, -1
 br i1 %807, label %808, label %809
808:
 call void @abort ()
 unreachable
809:
 %810 = call i32 @ashiftrt_si_18 (i32 -1)
 %811 = icmp ne i32 %810, -1
 br i1 %811, label %812, label %813
812:
 call void @abort ()
 unreachable
813:
 %814 = call i32 @ashiftrt_si_19 (i32 -1)
 %815 = icmp ne i32 %814, -1
 br i1 %815, label %816, label %817
816:
 call void @abort ()
 unreachable
817:
 %818 = call i32 @ashiftrt_si_20 (i32 -1)
 %819 = icmp ne i32 %818, -1
 br i1 %819, label %820, label %821
820:
 call void @abort ()
 unreachable
821:
 %822 = call i32 @ashiftrt_si_21 (i32 -1)
 %823 = icmp ne i32 %822, -1
 br i1 %823, label %824, label %825
824:
 call void @abort ()
 unreachable
825:
 %826 = call i32 @ashiftrt_si_22 (i32 -1)
 %827 = icmp ne i32 %826, -1
 br i1 %827, label %828, label %829
828:
 call void @abort ()
 unreachable
829:
 %830 = call i32 @ashiftrt_si_23 (i32 -1)
 %831 = icmp ne i32 %830, -1
 br i1 %831, label %832, label %833
832:
 call void @abort ()
 unreachable
833:
 %834 = call i32 @ashiftrt_si_24 (i32 -1)
 %835 = icmp ne i32 %834, -1
 br i1 %835, label %836, label %837
836:
 call void @abort ()
 unreachable
837:
 %838 = call i32 @ashiftrt_si_25 (i32 -1)
 %839 = icmp ne i32 %838, -1
 br i1 %839, label %840, label %841
840:
 call void @abort ()
 unreachable
841:
 %842 = call i32 @ashiftrt_si_26 (i32 -1)
 %843 = icmp ne i32 %842, -1
 br i1 %843, label %844, label %845
844:
 call void @abort ()
 unreachable
845:
 %846 = call i32 @ashiftrt_si_27 (i32 -1)
 %847 = icmp ne i32 %846, -1
 br i1 %847, label %848, label %849
848:
 call void @abort ()
 unreachable
849:
 %850 = call i32 @ashiftrt_si_28 (i32 -1)
 %851 = icmp ne i32 %850, -1
 br i1 %851, label %852, label %853
852:
 call void @abort ()
 unreachable
853:
 %854 = call i32 @ashiftrt_si_29 (i32 -1)
 %855 = icmp ne i32 %854, -1
 br i1 %855, label %856, label %857
856:
 call void @abort ()
 unreachable
857:
 %858 = call i32 @ashiftrt_si_30 (i32 -1)
 %859 = icmp ne i32 %858, -1
 br i1 %859, label %860, label %861
860:
 call void @abort ()
 unreachable
861:
 %862 = call i32 @ashiftrt_si_31 (i32 -1)
 %863 = icmp ne i32 %862, -1
 br i1 %863, label %864, label %865
864:
 call void @abort ()
 unreachable
865:
 %866 = call i32 @ashiftrt_si_0 (i32 0)
 %867 = icmp ne i32 %866, 0
 br i1 %867, label %868, label %869
868:
 call void @abort ()
 unreachable
869:
 %870 = call i32 @ashiftrt_si_1 (i32 0)
 %871 = icmp ne i32 %870, 0
 br i1 %871, label %872, label %873
872:
 call void @abort ()
 unreachable
873:
 %874 = call i32 @ashiftrt_si_2 (i32 0)
 %875 = icmp ne i32 %874, 0
 br i1 %875, label %876, label %877
876:
 call void @abort ()
 unreachable
877:
 %878 = call i32 @ashiftrt_si_3 (i32 0)
 %879 = icmp ne i32 %878, 0
 br i1 %879, label %880, label %881
880:
 call void @abort ()
 unreachable
881:
 %882 = call i32 @ashiftrt_si_4 (i32 0)
 %883 = icmp ne i32 %882, 0
 br i1 %883, label %884, label %885
884:
 call void @abort ()
 unreachable
885:
 %886 = call i32 @ashiftrt_si_5 (i32 0)
 %887 = icmp ne i32 %886, 0
 br i1 %887, label %888, label %889
888:
 call void @abort ()
 unreachable
889:
 %890 = call i32 @ashiftrt_si_6 (i32 0)
 %891 = icmp ne i32 %890, 0
 br i1 %891, label %892, label %893
892:
 call void @abort ()
 unreachable
893:
 %894 = call i32 @ashiftrt_si_7 (i32 0)
 %895 = icmp ne i32 %894, 0
 br i1 %895, label %896, label %897
896:
 call void @abort ()
 unreachable
897:
 %898 = call i32 @ashiftrt_si_8 (i32 0)
 %899 = icmp ne i32 %898, 0
 br i1 %899, label %900, label %901
900:
 call void @abort ()
 unreachable
901:
 %902 = call i32 @ashiftrt_si_9 (i32 0)
 %903 = icmp ne i32 %902, 0
 br i1 %903, label %904, label %905
904:
 call void @abort ()
 unreachable
905:
 %906 = call i32 @ashiftrt_si_10 (i32 0)
 %907 = icmp ne i32 %906, 0
 br i1 %907, label %908, label %909
908:
 call void @abort ()
 unreachable
909:
 %910 = call i32 @ashiftrt_si_11 (i32 0)
 %911 = icmp ne i32 %910, 0
 br i1 %911, label %912, label %913
912:
 call void @abort ()
 unreachable
913:
 %914 = call i32 @ashiftrt_si_12 (i32 0)
 %915 = icmp ne i32 %914, 0
 br i1 %915, label %916, label %917
916:
 call void @abort ()
 unreachable
917:
 %918 = call i32 @ashiftrt_si_13 (i32 0)
 %919 = icmp ne i32 %918, 0
 br i1 %919, label %920, label %921
920:
 call void @abort ()
 unreachable
921:
 %922 = call i32 @ashiftrt_si_14 (i32 0)
 %923 = icmp ne i32 %922, 0
 br i1 %923, label %924, label %925
924:
 call void @abort ()
 unreachable
925:
 %926 = call i32 @ashiftrt_si_15 (i32 0)
 %927 = icmp ne i32 %926, 0
 br i1 %927, label %928, label %929
928:
 call void @abort ()
 unreachable
929:
 %930 = call i32 @ashiftrt_si_16 (i32 0)
 %931 = icmp ne i32 %930, 0
 br i1 %931, label %932, label %933
932:
 call void @abort ()
 unreachable
933:
 %934 = call i32 @ashiftrt_si_17 (i32 0)
 %935 = icmp ne i32 %934, 0
 br i1 %935, label %936, label %937
936:
 call void @abort ()
 unreachable
937:
 %938 = call i32 @ashiftrt_si_18 (i32 0)
 %939 = icmp ne i32 %938, 0
 br i1 %939, label %940, label %941
940:
 call void @abort ()
 unreachable
941:
 %942 = call i32 @ashiftrt_si_19 (i32 0)
 %943 = icmp ne i32 %942, 0
 br i1 %943, label %944, label %945
944:
 call void @abort ()
 unreachable
945:
 %946 = call i32 @ashiftrt_si_20 (i32 0)
 %947 = icmp ne i32 %946, 0
 br i1 %947, label %948, label %949
948:
 call void @abort ()
 unreachable
949:
 %950 = call i32 @ashiftrt_si_21 (i32 0)
 %951 = icmp ne i32 %950, 0
 br i1 %951, label %952, label %953
952:
 call void @abort ()
 unreachable
953:
 %954 = call i32 @ashiftrt_si_22 (i32 0)
 %955 = icmp ne i32 %954, 0
 br i1 %955, label %956, label %957
956:
 call void @abort ()
 unreachable
957:
 %958 = call i32 @ashiftrt_si_23 (i32 0)
 %959 = icmp ne i32 %958, 0
 br i1 %959, label %960, label %961
960:
 call void @abort ()
 unreachable
961:
 %962 = call i32 @ashiftrt_si_24 (i32 0)
 %963 = icmp ne i32 %962, 0
 br i1 %963, label %964, label %965
964:
 call void @abort ()
 unreachable
965:
 %966 = call i32 @ashiftrt_si_25 (i32 0)
 %967 = icmp ne i32 %966, 0
 br i1 %967, label %968, label %969
968:
 call void @abort ()
 unreachable
969:
 %970 = call i32 @ashiftrt_si_26 (i32 0)
 %971 = icmp ne i32 %970, 0
 br i1 %971, label %972, label %973
972:
 call void @abort ()
 unreachable
973:
 %974 = call i32 @ashiftrt_si_27 (i32 0)
 %975 = icmp ne i32 %974, 0
 br i1 %975, label %976, label %977
976:
 call void @abort ()
 unreachable
977:
 %978 = call i32 @ashiftrt_si_28 (i32 0)
 %979 = icmp ne i32 %978, 0
 br i1 %979, label %980, label %981
980:
 call void @abort ()
 unreachable
981:
 %982 = call i32 @ashiftrt_si_29 (i32 0)
 %983 = icmp ne i32 %982, 0
 br i1 %983, label %984, label %985
984:
 call void @abort ()
 unreachable
985:
 %986 = call i32 @ashiftrt_si_30 (i32 0)
 %987 = icmp ne i32 %986, 0
 br i1 %987, label %988, label %989
988:
 call void @abort ()
 unreachable
989:
 %990 = call i32 @ashiftrt_si_31 (i32 0)
 %991 = icmp ne i32 %990, 0
 br i1 %991, label %992, label %993
992:
 call void @abort ()
 unreachable
993:
 call void @exit (i32 0)
 unreachable
}
