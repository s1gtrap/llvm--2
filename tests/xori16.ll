@.str = global [18 x i8] c"%hd ^ %hd != %hd\0A\00"
@.str.1 = global [18 x i8] c"%hd ^ %hd == %hd\0A\00"

declare i32 @printf(i8*, ...)

define void @assert (i16 %0, i16 %1, i16 %2) {
 %4 = xor i16 %0, %1
 %5 = icmp eq i16 %2, %4
 %6 = select i1 %5, i8* @.str.1, i8* @.str
 call i32 (i8*, ...) @printf (i8* %6, i16 %0, i16 %1, i16 %2)
 ret void
}

define i32 @main (i32 %0, i8* %1) {
 call void @assert (i16 0, i16 0, i16 0)
 call void @assert (i16 1, i16 0, i16 1)
 call void @assert (i16 0, i16 1, i16 1)
 call void @assert (i16 1, i16 1, i16 0)
 call void @assert (i16 1, i16 2, i16 3)
 call void @assert (i16 1, i16 2, i16 3)
 call void @assert (i16 1, i16 1, i16 0)
 call void @assert (i16 1, i16 3, i16 2)
 call void @assert (i16 1, i16 7, i16 6)
 call void @assert (i16 1, i16 15, i16 14)
 call void @assert (i16 1, i16 31, i16 30)
 call void @assert (i16 1, i16 63, i16 62)
 call void @assert (i16 1, i16 127, i16 126)
 call void @assert (i16 1, i16 255, i16 254)
 call void @assert (i16 1, i16 511, i16 510)
 call void @assert (i16 1, i16 1023, i16 1022)
 call void @assert (i16 1, i16 2047, i16 2046)
 call void @assert (i16 1, i16 4095, i16 4094)
 call void @assert (i16 1, i16 8191, i16 8190)
 call void @assert (i16 1, i16 16383, i16 16382)
 call void @assert (i16 1, i16 32767, i16 32766)
 call void @assert (i16 3, i16 3, i16 0)
 call void @assert (i16 3, i16 7, i16 4)
 call void @assert (i16 3, i16 15, i16 12)
 call void @assert (i16 3, i16 31, i16 28)
 call void @assert (i16 3, i16 63, i16 60)
 call void @assert (i16 3, i16 127, i16 124)
 call void @assert (i16 3, i16 255, i16 252)
 call void @assert (i16 3, i16 511, i16 508)
 call void @assert (i16 3, i16 1023, i16 1020)
 call void @assert (i16 3, i16 2047, i16 2044)
 call void @assert (i16 3, i16 4095, i16 4092)
 call void @assert (i16 3, i16 8191, i16 8188)
 call void @assert (i16 3, i16 16383, i16 16380)
 call void @assert (i16 3, i16 32767, i16 32764)
 call void @assert (i16 7, i16 7, i16 0)
 call void @assert (i16 7, i16 15, i16 8)
 call void @assert (i16 7, i16 31, i16 24)
 call void @assert (i16 7, i16 63, i16 56)
 call void @assert (i16 7, i16 127, i16 120)
 call void @assert (i16 7, i16 255, i16 248)
 call void @assert (i16 7, i16 511, i16 504)
 call void @assert (i16 7, i16 1023, i16 1016)
 call void @assert (i16 7, i16 2047, i16 2040)
 call void @assert (i16 7, i16 4095, i16 4088)
 call void @assert (i16 7, i16 8191, i16 8184)
 call void @assert (i16 7, i16 16383, i16 16376)
 call void @assert (i16 7, i16 32767, i16 32760)
 call void @assert (i16 15, i16 15, i16 0)
 call void @assert (i16 15, i16 31, i16 16)
 call void @assert (i16 15, i16 63, i16 48)
 call void @assert (i16 15, i16 127, i16 112)
 call void @assert (i16 15, i16 255, i16 240)
 call void @assert (i16 15, i16 511, i16 496)
 call void @assert (i16 15, i16 1023, i16 1008)
 call void @assert (i16 15, i16 2047, i16 2032)
 call void @assert (i16 15, i16 4095, i16 4080)
 call void @assert (i16 15, i16 8191, i16 8176)
 call void @assert (i16 15, i16 16383, i16 16368)
 call void @assert (i16 15, i16 32767, i16 32752)
 call void @assert (i16 31, i16 31, i16 0)
 call void @assert (i16 31, i16 63, i16 32)
 call void @assert (i16 31, i16 127, i16 96)
 call void @assert (i16 31, i16 255, i16 224)
 call void @assert (i16 31, i16 511, i16 480)
 call void @assert (i16 31, i16 1023, i16 992)
 call void @assert (i16 31, i16 2047, i16 2016)
 call void @assert (i16 31, i16 4095, i16 4064)
 call void @assert (i16 31, i16 8191, i16 8160)
 call void @assert (i16 31, i16 16383, i16 16352)
 call void @assert (i16 31, i16 32767, i16 32736)
 call void @assert (i16 63, i16 63, i16 0)
 call void @assert (i16 63, i16 127, i16 64)
 call void @assert (i16 63, i16 255, i16 192)
 call void @assert (i16 63, i16 511, i16 448)
 call void @assert (i16 63, i16 1023, i16 960)
 call void @assert (i16 63, i16 2047, i16 1984)
 call void @assert (i16 63, i16 4095, i16 4032)
 call void @assert (i16 63, i16 8191, i16 8128)
 call void @assert (i16 63, i16 16383, i16 16320)
 call void @assert (i16 63, i16 32767, i16 32704)
 call void @assert (i16 127, i16 127, i16 0)
 call void @assert (i16 127, i16 255, i16 128)
 call void @assert (i16 127, i16 511, i16 384)
 call void @assert (i16 127, i16 1023, i16 896)
 call void @assert (i16 127, i16 2047, i16 1920)
 call void @assert (i16 127, i16 4095, i16 3968)
 call void @assert (i16 127, i16 8191, i16 8064)
 call void @assert (i16 127, i16 16383, i16 16256)
 call void @assert (i16 127, i16 32767, i16 32640)
 call void @assert (i16 255, i16 255, i16 0)
 call void @assert (i16 255, i16 511, i16 256)
 call void @assert (i16 255, i16 1023, i16 768)
 call void @assert (i16 255, i16 2047, i16 1792)
 call void @assert (i16 255, i16 4095, i16 3840)
 call void @assert (i16 255, i16 8191, i16 7936)
 call void @assert (i16 255, i16 16383, i16 16128)
 call void @assert (i16 255, i16 32767, i16 32512)
 call void @assert (i16 511, i16 511, i16 0)
 call void @assert (i16 511, i16 1023, i16 512)
 call void @assert (i16 511, i16 2047, i16 1536)
 call void @assert (i16 511, i16 4095, i16 3584)
 call void @assert (i16 511, i16 8191, i16 7680)
 call void @assert (i16 511, i16 16383, i16 15872)
 call void @assert (i16 511, i16 32767, i16 32256)
 call void @assert (i16 1023, i16 1023, i16 0)
 call void @assert (i16 1023, i16 2047, i16 1024)
 call void @assert (i16 1023, i16 4095, i16 3072)
 call void @assert (i16 1023, i16 8191, i16 7168)
 call void @assert (i16 1023, i16 16383, i16 15360)
 call void @assert (i16 1023, i16 32767, i16 31744)
 call void @assert (i16 2047, i16 2047, i16 0)
 call void @assert (i16 2047, i16 4095, i16 2048)
 call void @assert (i16 2047, i16 8191, i16 6144)
 call void @assert (i16 2047, i16 16383, i16 14336)
 call void @assert (i16 2047, i16 32767, i16 30720)
 call void @assert (i16 4095, i16 4095, i16 0)
 call void @assert (i16 4095, i16 8191, i16 4096)
 call void @assert (i16 4095, i16 16383, i16 12288)
 call void @assert (i16 4095, i16 32767, i16 28672)
 call void @assert (i16 8191, i16 8191, i16 0)
 call void @assert (i16 8191, i16 16383, i16 8192)
 call void @assert (i16 8191, i16 32767, i16 24576)
 call void @assert (i16 16383, i16 16383, i16 0)
 call void @assert (i16 16383, i16 32767, i16 16384)
 call void @assert (i16 32767, i16 32767, i16 0)
 ret i32 0
}
