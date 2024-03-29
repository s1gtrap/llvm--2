%rectype$0 = type { i8*, i64 }
%$locals_tigermain = type { i8*, i8* }

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
 %temp_$_2 = getelementptr %$locals_tigermain, %$locals_tigermain* %locals_$_0, i32 0, i32 1
 store i8* null, i8** %temp_$_2
 %var_ptr_$_3 = getelementptr %$locals_tigermain, %$locals_tigermain* %locals_$_0, i32 0, i32 1
 %res_$_4 = load i8*, i8** %var_ptr_$_3
 %left_int_$_5 = ptrtoint i8** %res_$_4 to i64
 %right_int_$_6 = ptrtoint i8** null to i64
 %cnd_$_7 = icmp eq i64 %left_int_$_5, %right_int_$_6
 %zext_$_8 = zext i1 %cnd_$_7 to i64
 %var_ptr_$_9 = getelementptr %$locals_tigermain, %$locals_tigermain* %locals_$_0, i32 0, i32 1
 %res_$_10 = load i8*, i8** %var_ptr_$_9
 %left_int_$_11 = ptrtoint i8** %res_$_10 to i64
 %right_int_$_12 = ptrtoint i8** null to i64
 %cnd_$_13 = icmp ne i64 %left_int_$_11, %right_int_$_12
 %zext_$_14 = zext i1 %cnd_$_13 to i64
 ret i64 %zext_$_14
}
