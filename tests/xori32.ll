@.str = global [18 x i8] c"%ld ^ %ld != %ld\0A\00"
@.str.1 = global [18 x i8] c"%ld ^ %ld == %ld\0A\00"

declare i32 @printf(i8*, ...)

define void @assert (i32 %0, i32 %1, i32 %2) {
 %4 = xor i32 %0, %1
 %5 = icmp eq i32 %2, %4
 %6 = select i1 %5, i8* @.str.1, i8* @.str
 call i32 (i8*, ...) @printf (i8* %6, i32 %0, i32 %1, i32 %2)
 ret void
}

define i32 @main (i32 %0, i8* %1) {
 call void @assert (i32 0, i32 0, i32 0)
 call void @assert (i32 1, i32 0, i32 1)
 call void @assert (i32 0, i32 1, i32 1)
 call void @assert (i32 1, i32 1, i32 0)
 call void @assert (i32 1, i32 2, i32 3)
 call void @assert (i32 1, i32 2, i32 3)
 ret i32 0
}
