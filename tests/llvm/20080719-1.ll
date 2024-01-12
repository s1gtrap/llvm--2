@cfb_tab8_be = global [16 x i32] [i32 0, i32 255, i32 65280, i32 65535, i32 16711680, i32 16711935, i32 16776960, i32 16777215, i32 -16777216, i32 -16776961, i32 -16711936, i32 -16711681, i32 -65536, i32 -65281, i32 -256, i32 -1]
@cfb_tab16_be = global [4 x i32] [i32 0, i32 65535, i32 -65536, i32 -1]
@cfb_tab32 = global [2 x i32] [i32 0, i32 -1]

declare void @abort()

define i8* @xxx (i32 %0) {
 %2 = alloca i32
 %3 = alloca i8*
 store i32 %0, i32* %2
 %4 = load i32, i32* %2
 switch i32 %4, label %8 [
    i32 8, label %5
    i32 16, label %6
    i32 32, label %7
  ]
5:
 store i8* @cfb_tab8_be, i8** %3
 br label %9
6:
 store i8* @cfb_tab16_be, i8** %3
 br label %9
7:
 br label %8
8:
 store i8* @cfb_tab32, i8** %3
 br label %9
9:
 %10 = load i8*, i8** %3
 ret i8* %10
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i8*
 %3 = alloca i32
 store i32 0, i32* %1
 %4 = call i8* @xxx (i32 8)
 store i8* %4, i8** %2
 %5 = load i8*, i8** %2
 %6 = getelementptr i32, i8* %5, i64 0
 %7 = load i32, i32* %6
 store i32 %7, i32* %3
 %8 = load i32, i32* %3
 %9 = load i32, i32* @cfb_tab8_be
 %10 = icmp ne i32 %8, %9
 br i1 %10, label %11, label %12
11:
 call void @abort ()
 unreachable
12:
 ret i32 0
}
