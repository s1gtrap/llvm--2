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
 call void @assert (i8 0, i8 1, i8 1)
 call void @assert (i8 1, i8 0, i8 1)
 call void @assert (i8 1, i8 1, i8 2)
 call void @assert (i8 1, i8 2, i8 3)
 call void @assert (i8 4, i8 2, i8 6)
 call void @assert (i8 4, i8 8, i8 12)
 call void @assert (i8 16, i8 8, i8 24)
 call void @assert (i8 16, i8 32, i8 48)
 call void @assert (i8 64, i8 32, i8 96)
 call void @assert (i8 0, i8 127, i8 127)
 call void @assert (i8 1, i8 126, i8 127)
 ret i32 0
}
