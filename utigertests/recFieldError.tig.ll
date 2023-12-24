target triple = "x86_64-pc-linux-gnu"

declare i8* @allocRecord(i64)
declare i8* @initArray (i64, i64, i8*)
declare i64 @arrInxError (i64)
declare i64 @recFieldError()
declare i64 @divisionByZero()
declare i64 @stringEqual (i8*, i8*)
declare i64 @stringNotEq (i8*, i8*)
declare i64 @stringLess (i8*, i8*)
declare i64 @stringLessEq (i8*, i8*)
declare i64 @stringGreater (i8*, i8*)
declare i64 @stringGreaterEq (i8*, i8*)
declare i64 @exponent(i64, i64)
declare void @print      (i8*, i8*)
declare void @flush      (i8*)
declare i8*  @getChar    (i8*)
declare i64  @ord        (i8*, i8*)
declare i8*  @chr        (i8*, i64)
declare i64  @size       (i8*, i8*)
declare i8*  @substring  (i8*, i8*, i64, i64)
declare i8*  @concat     (i8*, i8*, i8*)
declare i64  @not        (i8*, i64)
declare void @tigerexit  (i8*, i64)

%Loc$0 = type { i64, i64 }
%$locals_tigermain = type { i8*, i8* }

define i64 @tigermain (i8* %$sl) {
 %locals_$_0 = alloca %$locals_tigermain
 %arg_$_1 = getelementptr %$locals_tigermain, %$locals_tigermain* %locals_$_0, i32 0, i32 0
 store i8* %$sl, i8** %arg_$_1
 %temp_$_2 = getelementptr %$locals_tigermain, %$locals_tigermain* %locals_$_0, i32 0, i32 1
 store i8* null, i8** %temp_$_2
 %var_ptr_$_3 = getelementptr %$locals_tigermain, %$locals_tigermain* %locals_$_0, i32 0, i32 1
 %load_$_4 = load i8*, i8** %var_ptr_$_3
 %record_ptr_$_5 = bitcast i8* %load_$_4 to %Loc$0*
 %int_of_ptr_$_8 = ptrtoint i8* %load_$_4 to i64
 %cnd_$_9 = icmp eq i64 %int_of_ptr_$_8, 0
 br i1 %cnd_$_9, label %thn_$_6, label %mrg_$_7
thn_$_6:
 call i64 @recFieldError ()
 br label %mrg_$_7
mrg_$_7:
 %field_ptr_$_10 = getelementptr %Loc$0, %Loc$0* %record_ptr_$_5, i32 0, i32 0
 %res_$_11 = load i64, i64* %field_ptr_$_10
 ret i64 %res_$_11
}
