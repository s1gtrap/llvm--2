@.str = global [21 x i8] c"%hhd + %hhd != %hhd\0A\00"
@.str.1 = global [21 x i8] c"%hhd + %hhd == %hhd\0A\00"

declare i32 @printf(i8*, ...)

define void @assert (i8 %0, i8 %1, i8 %2) {
 %4 = add i8 %0, %1
 %5 = icmp eq i8 %2, %4
 %6 = select i1 %5, i8* @.str.1, i8* @.str
 call i32 (i8*, ...) @printf (i8* %6, i8 %0, i8 %1, i8 %2)
 ret void
}

define i32 @main (i32 %0, i8* %1) {
 call void @assert (i8 0, i8 0, i8 0)
 call void @assert (i8 1, i8 0, i8 1)
 call void @assert (i8 0, i8 1, i8 1)
 call void @assert (i8 1, i8 1, i8 2)
 call void @assert (i8 1, i8 2, i8 3)
 call void @assert (i8 1, i8 2, i8 3)
 call void @assert (i8 1, i8 1, i8 2)
 call void @assert (i8 1, i8 3, i8 4)
 call void @assert (i8 1, i8 7, i8 8)
 call void @assert (i8 1, i8 15, i8 16)
 call void @assert (i8 1, i8 31, i8 32)
 call void @assert (i8 1, i8 63, i8 64)
 call void @assert (i8 1, i8 127, i8 128)
 call void @assert (i8 3, i8 3, i8 6)
 call void @assert (i8 3, i8 7, i8 10)
 call void @assert (i8 3, i8 15, i8 18)
 call void @assert (i8 3, i8 31, i8 34)
 call void @assert (i8 3, i8 63, i8 66)
 call void @assert (i8 3, i8 127, i8 130)
 call void @assert (i8 7, i8 7, i8 14)
 call void @assert (i8 7, i8 15, i8 22)
 call void @assert (i8 7, i8 31, i8 38)
 call void @assert (i8 7, i8 63, i8 70)
 call void @assert (i8 7, i8 127, i8 134)
 call void @assert (i8 15, i8 15, i8 30)
 call void @assert (i8 15, i8 31, i8 46)
 call void @assert (i8 15, i8 63, i8 78)
 call void @assert (i8 15, i8 127, i8 142)
 call void @assert (i8 31, i8 31, i8 62)
 call void @assert (i8 31, i8 63, i8 94)
 call void @assert (i8 31, i8 127, i8 158)
 call void @assert (i8 63, i8 63, i8 126)
 call void @assert (i8 63, i8 127, i8 190)
 call void @assert (i8 127, i8 127, i8 254)
 ret i32 0
}
