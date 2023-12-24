define i32 @main () {
 %a = add i32 7, 2
 %b = sub i32 %a, 3
 %c = mul i32 4, %b
 %d = add i32 %c, -1
 %e = sdiv i32 %c, 8
 %f = mul i32 %d, %e
 ret i32 %f
}
