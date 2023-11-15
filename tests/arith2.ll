define i32 @main() {
    %a = add i32 1, 2   ; 3
    %b = add i32 %a, 3  ; 6
    %c = mul i32 %a, %b ; 18
    %d = mul i32 4, %c  ; 72
    %e = add i32 %d, %c ; 90
    %f = sdiv i32 %d, 3 ; 24
    %g = srem i32 %e, %f
    ret i32 %g
}
