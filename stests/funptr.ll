@hi = global [9 x i8] c"say hi!\0A\00"
@bye = global [10 x i8] c"goodbye!\0A\00"

declare i32 @printf(i8*, i32)

define void @say_hi () {
 call i32 @printf (i8* @hi)
 ret void
}

define void @say_bye () {
 call i32 @printf (i8* @bye)
 ret void
}

define i8* @fun (i32 %num) {
 switch i32 %num, label %error [
    i32 1, label %one
  ]
one:
 ret i8* @say_hi
error:
 ret i8* @say_bye
}

define i32 @main (i32 %argc, i8** %argv) {
 %fun = call i8* @fun (i32 %argc)
 call void(  ) %fun ()
 ret i32 0
}
