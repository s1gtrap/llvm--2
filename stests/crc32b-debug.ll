@minput = global [11 x i8] c"crc32b %s\0A\00"
@mvar = global [14 x i8] c"var%u = %08X\0A\00"
@.str = global [25 x i8] c"result of crc32b = %08X\0A\00"
@msg1 = global [10 x i8] c"2nd %08X\0A\00"
@.str.1 = global [1 x i8] c"\00"
@.str.2 = global [2 x i8] c"a\00"
@.str.3 = global [10 x i8] c"123456789\00"

declare i32 @printf(i8*)

define i32 @crc32b (i8* %var0) {
 call i32 @printf (i8* @minput, i8* %var0)
 %var2 = alloca i8*
 %var3 = alloca i32
 %var4 = alloca i32
 %var5 = alloca i32
 %var6 = alloca i32
 %var7 = alloca i32
 store i8* %var0, i8** %var2
 store i32 0, i32* %var3
 store i32 -1, i32* %var6
 br label %lbl8
lbl8:
 %var9 = load i8*, i8** %var2
 %var10 = load i32, i32* %var3
 call i32 @printf (i8* @mvar, i32 10, i32 %var10)
 call i32 @printf (i8* @minput, i8* %var0)
 %var11 = zext i32 %var10 to i64
 call i32 @printf (i8* @mvar, i32 11, i64 %var11)
 %var12 = getelementptr i8, i8* %var9, i64 %var11
 %var13 = load i8, i8* %var12
 call i32 @printf (i8* @mvar, i32 13, i8 %var13)
 %var14 = zext i8 %var13 to i32
 call i32 @printf (i8* @mvar, i32 14, i32 %var14)
 %var15 = icmp ne i32 %var14, 0
 br i1 %var15, label %lbl16, label %lbl44
lbl16:
 %var17 = load i8*, i8** %var2
 %var18 = load i32, i32* %var3
 %var19 = zext i32 %var18 to i64
 call i32 @printf (i8* @mvar, i32 19, i64 %var19)
 %var20 = getelementptr i8, i8* %var17, i64 %var19
 %var21 = load i8, i8* %var20
 %var22 = zext i8 %var21 to i32
 call i32 @printf (i8* @mvar, i32 22, i32 %var22)
 store i32 %var22, i32* %var5
 %var23 = load i32, i32* %var6
 %var24 = load i32, i32* %var5
 %var25 = xor i32 %var23, %var24
 call i32 @printf (i8* @mvar, i32 25, i32 %var25)
 store i32 %var25, i32* %var6
 store i32 7, i32* %var4
 br label %lbl26
lbl26:
 %var27 = load i32, i32* %var4
 call i32 @printf (i8* @mvar, i32 27, i32 %var27)
 %var28 = icmp sge i32 %var27, 0
 call i32 @printf (i8* @mvar, i32 28, i1 %var28)
 br i1 %var28, label %lbl29, label %lbl41
lbl29:
 %var30 = load i32, i32* %var6
 %var31 = and i32 %var30, 1
 call i32 @printf (i8* @mvar, i32 31, i32 %var31)
 %var32 = sub i32 0, %var31
 call i32 @printf (i8* @mvar, i32 32, i32 %var32)
 store i32 %var32, i32* %var7
 %var33 = load i32, i32* %var6
 %var34 = lshr i32 %var33, 1
 %var35 = load i32, i32* %var7
 %var36 = and i32 -306674912, %var35
 call i32 @printf (i8* @mvar, i32 36, i32 %var36)
 %var37 = xor i32 %var34, %var36
 call i32 @printf (i8* @mvar, i32 37, i32 %var37)
 store i32 %var37, i32* %var6
 br label %lbl38
lbl38:
 %var39 = load i32, i32* %var4
 %var40 = add i32 %var39, -1
 call i32 @printf (i8* @mvar, i32 40, i32 %var40)
 store i32 %var40, i32* %var4
 br label %lbl26
lbl41:
 %var42 = load i32, i32* %var3
 %var43 = add i32 %var42, 1
 call i32 @printf (i8* @mvar, i32 43, i32 %var43)
 store i32 %var43, i32* %var3
 br label %lbl8
lbl44:
 %var45 = load i32, i32* %var6
 %var46 = xor i32 %var45, -1
 call i32 @printf (i8* @mvar, i32 46, i32 %var46)
 ret i32 %var46
}

define i32 @main () {
 %var1 = alloca i32
 store i32 0, i32* %var1
 %var2 = call i32 @crc32b (i8* @.str.1)
 %var3 = call i32 (i8*, i32) @printf (i8* @.str, i32 %var2)
 %var4 = call i32 @crc32b (i8* @.str.2)
 %var5 = call i32 (i8*, i32) @printf (i8* @.str, i32 %var4)
 %var6 = call i32 @crc32b (i8* @.str.3)
 ret i32 0
}
