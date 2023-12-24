%intlist$0 = type { i64, i8* }
%tree$1 = type { i64, i8* }
%treelist$2 = type { i8*, i8* }
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

define i8* @tigermain (i8* %$sl) {
 %locals_$_0 = alloca %$locals_tigermain
 %arg_$_1 = getelementptr %$locals_tigermain, %$locals_tigermain* %locals_$_0, i32 0, i32 0
 store i8* %$sl, i8** %arg_$_1
 %size_ptr_$_2 = getelementptr %intlist$0, %intlist$0* null, i32 1
 %size_$_3 = ptrtoint %intlist$0* %size_ptr_$_2 to i64
 %record_ptr_$_4 = call i8* @allocRecord (i64 %size_$_3)
 %rec_$_5 = bitcast i8* %record_ptr_$_4 to %intlist$0*
 %field_ptr_$_6 = getelementptr %intlist$0, %intlist$0* %rec_$_5, i32 0, i32 0
 store i64 0, i64* %field_ptr_$_6
 %field_ptr_$_7 = getelementptr %intlist$0, %intlist$0* %rec_$_5, i32 0, i32 1
 store i8* null, i8** %field_ptr_$_7
 %temp_$_8 = getelementptr %$locals_tigermain, %$locals_tigermain* %locals_$_0, i32 0, i32 1
 store i8* %record_ptr_$_4, i8** %temp_$_8
 %var_ptr_$_9 = getelementptr %$locals_tigermain, %$locals_tigermain* %locals_$_0, i32 0, i32 1
 %res_$_10 = load i8*, i8** %var_ptr_$_9
 ret i8* %res_$_10
}
