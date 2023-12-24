@even = global [5 x i8] c"even\00"
@odd = global [4 x i8] c"odd\00"

declare i32 @printf(i8*, ...)

define i32 @main (i32 %argc, i8** %argv) {
 %a = and i32 %argc, 1
 %b = trunc i32 %a to i1
 %c = select i1 %b, i8* @odd, i8* @even
 call i32 @printf (i8* %c)
 ret i32 %a
}
