define i32 @main () {
 %a = add i32 1, 2
 %b = add i32 %a, 3
 %c = mul i32 %a, %b
 %d = mul i32 4, %c
 %e = add i32 %d, %c
 %f = sdiv i32 %d, 3
 %g = srem i32 %e, %f
 ret i32 %g
}
