%$locals_tigermain = type { i8* }

@str_$_8 = global { i64, [5 x i8] } {i64 5, [5 x i8] c"right"}
@str_$_5 = global { i64, [4 x i8] } {i64 4, [4 x i8] c"left"}

declare i8* @allocRecord(i64)
declare i8* @initArray(i64, i64, i8*)
declare i64 @arrInxError(i64)
declare i64 @recFieldError()
declare i64 @divisionByZero()
declare i64 @stringEqual(i8*, i8*)
declare i64 @stringNotEq(i8*, i8*)
declare i64 @stringLess(i8*, i8*)
declare i64 @stringLessEq(i8*, i8*)
declare i64 @stringGreater(i8*, i8*)
declare i64 @stringGreaterEq(i8*, i8*)
declare i64 @exponent(i64, i64)
declare void @print(i8*, i8*)
declare void @flush(i8*)
declare i8* @getChar(i8*)
declare i64 @ord(i8*, i8*)
declare i8* @chr(i8*, i64)
declare i64 @size(i8*, i8*)
declare i8* @substring(i8*, i8*, i64, i64)
declare i8* @concat(i8*, i8*, i8*)
declare i64 @not(i8*, i64)
declare void @tigerexit(i8*, i64)

define i64 @tigermain (i8* %$sl) {
 %locals_$_0 = alloca %$locals_tigermain
 %arg_$_1 = getelementptr %$locals_tigermain, %$locals_tigermain* %locals_$_0, i32 0, i32 0
 store i8* %$sl, i8** %arg_$_1
 %temp_$_6 = bitcast { i64, [4 x i8] }* @str_$_5 to i8*
 call void @print (i8* null, i8* %temp_$_6)
 %temp_$_9 = bitcast { i64, [5 x i8] }* @str_$_8 to i8*
 call void @print (i8* null, i8* %temp_$_9)
 %cnd_$_10 = icmp eq i64 17159, 0
 br i1 %cnd_$_10, label %thn_$_2, label %mrg_$_3
thn_$_2:
 call i64 @divisionByZero ()
 br label %mrg_$_3
mrg_$_3:
 %temp_$_11 = sdiv i64 85795, 17159
 ret i64 %temp_$_11
}
