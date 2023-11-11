; ModuleID = 'sha256-test.c'
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx14.0.0"

@.str = global [5 x i8] c"%08x\00"
@.str.1 = global [2 x i8] c"\0A\00"
@.str.2 = global [1 x i8] c"\00"
@.str.3 = global [2 x i8] c"a\00"
@.str.4 = global [12 x i8] c"Hello world\00"

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @print_hash(i8*  %var0)  {
  %var2 = alloca i8*
  %var3 = alloca i32
  store i8* %var0, i8* %var2
  store i32 0, i8* %var3
  br label %lbl4

lbl4:                                                ; preds = %var14, %var1
  %var5 = load i32, i8* %var3
  %var6 = icmp slt i32 %var5, 8
  br i1 %var6, label %lbl7, label %lbl17

lbl7:                                                ; preds = %var4
  %var8 = load i8*, i8* %var2
  %var9 = load i32, i8* %var3
  %var10 = zext i32 %var9 to i64
  %var11 = getelementptr  i32, i8* %var8, i64 %var10
  %var12 = load i32, i8* %var11
  %var13 = call i32 (i8*, i32) @printf(i8* @.str, i32 %var12)
  br label %lbl14

lbl14:                                               ; preds = %var7
  %var15 = load i32, i8* %var3
  %var16 = add  i32 %var15, 1
  store i32 %var16, i8* %var3
  br label %lbl4

lbl17:                                               ; preds = %var4
  %var18 = call i32 (i8*) @printf(i8* @.str.1)
  ret void
}

declare i32 @printf(i8* ) 

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @main()  {
  %var1 = alloca i32
  %var2 = alloca [8 x i32]
  store i32 0, i8* %var1
  %var3 = getelementptr  [8 x i32], i8* %var2, i64 0, i64 0
  ;call void @printf(i8* @.str.4)
  call void @sha256_hash(i8* @.str.2, i64 0, i8* %var3)
  %var4 = getelementptr  [8 x i32], i8* %var2, i64 0, i64 0
  call void @print_hash(i8* %var4)
  ;%var5 = getelementptr  [8 x i32], i8* %var2, i64 0, i64 0
  ;call void @sha256_hash(i8* @.str.3, i64 1, i8* %var5)
  ;%var6 = getelementptr  [8 x i32], i8* %var2, i64 0, i64 0
  ;call void @print_hash(i8* %var6)
  ;%var7 = getelementptr  [8 x i32], i8* %var2, i64 0, i64 0
  ;call void @sha256_hash(i8* @.str.4, i64 11, i8* %var7)
  ;%var8 = getelementptr  [8 x i32], i8* %var2, i64 0, i64 0
  ;call void @print_hash(i8* %var8)
  ret i32 7
}

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define void @sha256_hash(i8* %var0, i64 %var1, i8*  %var2)  {
  %var4 = alloca i8*
  %var5 = alloca i64
  %var6 = alloca i8*
  %var7 = alloca i64
  %var8 = alloca [64 x i8]
  %var9 = alloca i64
  %var10 = alloca i32
  store i8* %var0, i8* %var4
  store i64 %var1, i8* %var5
  store i8* %var2, i8* %var6
  %var11 = load i8*, i8* %var6
  %var12 = getelementptr  i32, i8* %var11, i64 0
  store i32 1779033703, i8* %var12
  %var13 = load i8*, i8* %var6
  %var14 = getelementptr  i32, i8* %var13, i64 1
  store i32 -1150833019, i8* %var14
  %var15 = load i8*, i8* %var6
  %var16 = getelementptr  i32, i8* %var15, i64 2
  store i32 1013904242, i8* %var16
  %var17 = load i8*, i8* %var6
  %var18 = getelementptr  i32, i8* %var17, i64 3
  store i32 -1521486534, i8* %var18
  %var19 = load i8*, i8* %var6
  %var20 = getelementptr  i32, i8* %var19, i64 4
  store i32 1359893119, i8* %var20
  %var21 = load i8*, i8* %var6
  %var22 = getelementptr  i32, i8* %var21, i64 5
  store i32 -1694144372, i8* %var22
  %var23 = load i8*, i8* %var6
  %var24 = getelementptr  i32, i8* %var23, i64 6
  store i32 528734635, i8* %var24
  %var25 = load i8*, i8* %var6
  %var26 = getelementptr  i32, i8* %var25, i64 7
  store i32 1541459225, i8* %var26
  store i64 0, i8* %var7
  br label %lbl27

lbl27:                                               ; preds = %var37, %var3
  %var28 = load i64, i8* %var5
  %var29 = load i64, i8* %var7
  %var30 = sub i64 %var28, %var29
  %var31 = icmp sge i64 %var30, 64
  br i1 %var31, label %lbl32, label %lbl40

lbl32:                                               ; preds = %var27
  %var33 = load i8*, i8* %var4
  %var34 = load i64, i8* %var7
  %var35 = getelementptr  i8, i8* %var33, i64 %var34
  %var36 = load i8*, i8* %var6
  call void @sha256_compress(i8* %var35, i8* %var36)
  ;call void @exit(i8 68)
  br label %lbl37

lbl37:                                               ; preds = %var32
  %var38 = load i64, i8* %var7
  %var39 = add i64 %var38, 64
  store i64 %var39, i8* %var7
  br label %lbl27

lbl40:                                               ; preds = %var27
  call void @memset(i8* %var8, i8 0, i64 64, i1 0)
  %var41 = load i64, i8* %var5
  %var42 = load i64, i8* %var7
  %var43 = sub i64 %var41, %var42
  store i64 %var43, i8* %var9
  %var44 = load i64, i8* %var9
  %var45 = icmp sgt i64 %var44, 0
  br i1 %var45, label %lbl46, label %lbl53

lbl46:                                               ; preds = %var40
  %var47 = getelementptr  [64 x i8], i8* %var8, i64 0, i64 0
  %var48 = load i8*, i8* %var4
  %var49 = load i64, i8* %var7
  %var50 = getelementptr  i8, i8* %var48, i64 %var49
  %var51 = load i64, i8* %var9
  %var52 = call i8* @__memcpy_chk(i8* %var47, i8* %var50, i64 %var51, i64 64) 
  br label %lbl53

lbl53:                                               ; preds = %var46, %var40
  %var54 = load i64, i8* %var9
  %var55 = getelementptr  [64 x i8], i8* %var8, i64 0, i64 %var54
  store i8 -128, i8* %var55
  %var56 = load i64, i8* %var9
  %var57 = add i64 %var56, 1
  store i64 %var57, i8* %var9
  %var58 = load i64, i8* %var9
  %var59 = sub i64 64, %var58
  %var60 = icmp slt i64 %var59, 8
  br i1 %var60, label %lbl61, label %lbl65

lbl61:                                               ; preds = %var53
  %var62 = getelementptr  [64 x i8], i8* %var8, i64 0, i64 0
  %var63 = load i8*, i8* %var6
  call void @sha256_compress(i8* %var62, i8* %var63)
  ;call void @exit(i8 69)
  %var64 = getelementptr  [64 x i8], i8* %var8, i64 0, i64 0
  call void @memset(i8* %var64, i8 0, i64 64, i1 0)
  br label %lbl65

lbl65:                                               ; preds = %var61, %var53
  %var66 = load i64, i8* %var5
  %var67 = and i64 %var66, 31
  %var68 = shl i64 %var67, 3
  %var69 = trunc i64 %var68 to i8
  %var70 = getelementptr  [64 x i8], i8* %var8, i64 0, i64 63
  store i8 %var69, i8* %var70
  %var71 = load i64, i8* %var5
  %var72 = lshr i64 %var71, 5
  store i64 %var72, i8* %var5
  store i32 1, i8* %var10
  br label %lbl73

lbl73:                                               ; preds = %var84, %var65
  %var74 = load i32, i8* %var10
  %var75 = icmp slt i32 %var74, 8
  br i1 %var75, label %lbl76, label %lbl89

lbl76:                                               ; preds = %var73
  %var77 = load i64, i8* %var5
  %var78 = and i64 %var77, 255
  %var79 = trunc i64 %var78 to i8
  %var80 = load i32, i8* %var10
  %var81 = sub  i32 63, %var80
  %var82 = zext i32 %var81 to i64
  %var83 = getelementptr  [64 x i8], i8* %var8, i64 0, i64 %var82
  store i8 %var79, i8* %var83
  br label %lbl84

lbl84:                                               ; preds = %var76
  %var85 = load i32, i8* %var10
  %var86 = add  i32 %var85, 1
  store i32 %var86, i8* %var10
  %var87 = load i64, i8* %var5
  %var88 = lshr i64 %var87, 8
  store i64 %var88, i8* %var5
  br label %lbl73

lbl89:                                               ; preds = %var73
  %var90 = getelementptr  [64 x i8], i8* %var8, i64 0, i64 0
  %var91 = load i8*, i8* %var6
  call void @sha256_compress(i8* %var90, i8* %var91)
  ;call void @printf(i8* @.str.4)
  ret void
}

declare void @sha256_compress(i8* , i8* ) 
declare void @exit(i8 ) 

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @memset(i8*, i8, i64, i1 ) 

; Function Attrs: nounwind
declare i8* @__memcpy_chk(i8* , i8* , i64 , i64 ) 

