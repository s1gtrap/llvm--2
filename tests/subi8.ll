@.str = global [21 x i8] c"%hhd - %hhd != %hhd\0A\00"
@.str.1 = global [21 x i8] c"%hhd - %hhd == %hhd\0A\00"

declare i32 @printf(i8*, ...)

define void @assert (i8 %0, i8 %1, i8 %2) {
 %4 = sub i8 %0, %1
 %5 = icmp eq i8 %2, %4
 %6 = select i1 %5, i8* @.str.1, i8* @.str
 call i32 (i8*, ...) @printf (i8* %6, i8 %0, i8 %1, i8 %2)
 ret void
}

define i32 @main (i32 %0, i8* %1) {
 call void @assert (i8 0, i8 0, i8 0)
 call void @assert (i8 1, i8 0, i8 1)
 call void @assert (i8 0, i8 1, i8 255)
 call void @assert (i8 1, i8 1, i8 0)
 call void @assert (i8 1, i8 2, i8 255)
 call void @assert (i8 1, i8 2, i8 255)
 call void @assert (i8 1, i8 1, i8 0)
 call void @assert (i8 1, i8 3, i8 254)
 call void @assert (i8 1, i8 7, i8 250)
 call void @assert (i8 1, i8 15, i8 242)
 call void @assert (i8 1, i8 31, i8 226)
 call void @assert (i8 1, i8 63, i8 194)
 call void @assert (i8 1, i8 127, i8 130)
 call void @assert (i8 3, i8 3, i8 0)
 call void @assert (i8 3, i8 7, i8 252)
 call void @assert (i8 3, i8 15, i8 244)
 call void @assert (i8 3, i8 31, i8 228)
 call void @assert (i8 3, i8 63, i8 196)
 call void @assert (i8 3, i8 127, i8 132)
 call void @assert (i8 7, i8 7, i8 0)
 call void @assert (i8 7, i8 15, i8 248)
 call void @assert (i8 7, i8 31, i8 232)
 call void @assert (i8 7, i8 63, i8 200)
 call void @assert (i8 7, i8 127, i8 136)
 call void @assert (i8 15, i8 15, i8 0)
 call void @assert (i8 15, i8 31, i8 240)
 call void @assert (i8 15, i8 63, i8 208)
 call void @assert (i8 15, i8 127, i8 144)
 call void @assert (i8 31, i8 31, i8 0)
 call void @assert (i8 31, i8 63, i8 224)
 call void @assert (i8 31, i8 127, i8 160)
 call void @assert (i8 63, i8 63, i8 0)
 call void @assert (i8 63, i8 127, i8 192)
 call void @assert (i8 127, i8 127, i8 0)
 ret i32 0
}
