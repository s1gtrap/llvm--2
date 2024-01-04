@.str = global [21 x i8] c"%hhd * %hhd != %hhd\0A\00"
@.str.1 = global [21 x i8] c"%hhd * %hhd == %hhd\0A\00"

declare i32 @printf(i8*, ...)

define void @assert (i8 %0, i8 %1, i8 %2) {
 %4 = mul i8 %0, %1
 %5 = icmp eq i8 %2, %4
 %6 = select i1 %5, i8* @.str.1, i8* @.str
 call i32 (i8*, ...) @printf (i8* %6, i8 %0, i8 %1, i8 %2)
 ret void
}

define i32 @main (i32 %0, i8* %1) {
 call void @assert (i8 0, i8 0, i8 0)
 call void @assert (i8 1, i8 0, i8 0)
 call void @assert (i8 0, i8 1, i8 0)
 call void @assert (i8 1, i8 1, i8 1)
 call void @assert (i8 1, i8 2, i8 2)
 call void @assert (i8 1, i8 2, i8 2)
 call void @assert (i8 1, i8 1, i8 1)
 call void @assert (i8 1, i8 3, i8 3)
 call void @assert (i8 1, i8 7, i8 7)
 call void @assert (i8 1, i8 15, i8 15)
 call void @assert (i8 1, i8 31, i8 31)
 call void @assert (i8 1, i8 63, i8 63)
 call void @assert (i8 1, i8 127, i8 127)
 call void @assert (i8 3, i8 3, i8 9)
 call void @assert (i8 3, i8 7, i8 21)
 call void @assert (i8 3, i8 15, i8 45)
 call void @assert (i8 3, i8 31, i8 93)
 call void @assert (i8 3, i8 63, i8 189)
 call void @assert (i8 3, i8 127, i8 125)
 call void @assert (i8 7, i8 7, i8 49)
 call void @assert (i8 7, i8 15, i8 105)
 call void @assert (i8 7, i8 31, i8 217)
 call void @assert (i8 7, i8 63, i8 185)
 call void @assert (i8 7, i8 127, i8 121)
 call void @assert (i8 15, i8 15, i8 225)
 call void @assert (i8 15, i8 31, i8 209)
 call void @assert (i8 15, i8 63, i8 177)
 call void @assert (i8 15, i8 127, i8 113)
 call void @assert (i8 31, i8 31, i8 193)
 call void @assert (i8 31, i8 63, i8 161)
 call void @assert (i8 31, i8 127, i8 97)
 call void @assert (i8 63, i8 63, i8 129)
 call void @assert (i8 63, i8 127, i8 65)
 call void @assert (i8 127, i8 127, i8 1)
 ret i32 0
}
