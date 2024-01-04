@.str = global [18 x i8] c"%hd - %hd != %hd\0A\00"
@.str.1 = global [18 x i8] c"%hd - %hd == %hd\0A\00"

declare i32 @printf(i8*, ...)

define void @assert (i16 %0, i16 %1, i16 %2) {
 %4 = sub i16 %0, %1
 %5 = icmp eq i16 %2, %4
 %6 = select i1 %5, i8* @.str.1, i8* @.str
 call i32 (i8*, ...) @printf (i8* %6, i16 %0, i16 %1, i16 %2)
 ret void
}

define i32 @main (i32 %0, i8* %1) {
 call void @assert (i16 0, i16 0, i16 0)
 call void @assert (i16 1, i16 0, i16 1)
 call void @assert (i16 0, i16 1, i16 65535)
 call void @assert (i16 1, i16 1, i16 0)
 call void @assert (i16 1, i16 2, i16 65535)
 call void @assert (i16 1, i16 2, i16 65535)
 call void @assert (i16 1, i16 1, i16 0)
 call void @assert (i16 1, i16 3, i16 65534)
 call void @assert (i16 1, i16 7, i16 65530)
 call void @assert (i16 1, i16 15, i16 65522)
 call void @assert (i16 1, i16 31, i16 65506)
 call void @assert (i16 1, i16 63, i16 65474)
 call void @assert (i16 1, i16 127, i16 65410)
 call void @assert (i16 1, i16 255, i16 65282)
 call void @assert (i16 1, i16 511, i16 65026)
 call void @assert (i16 1, i16 1023, i16 64514)
 call void @assert (i16 1, i16 2047, i16 63490)
 call void @assert (i16 1, i16 4095, i16 61442)
 call void @assert (i16 1, i16 8191, i16 57346)
 call void @assert (i16 1, i16 16383, i16 49154)
 call void @assert (i16 1, i16 32767, i16 32770)
 call void @assert (i16 3, i16 3, i16 0)
 call void @assert (i16 3, i16 7, i16 65532)
 call void @assert (i16 3, i16 15, i16 65524)
 call void @assert (i16 3, i16 31, i16 65508)
 call void @assert (i16 3, i16 63, i16 65476)
 call void @assert (i16 3, i16 127, i16 65412)
 call void @assert (i16 3, i16 255, i16 65284)
 call void @assert (i16 3, i16 511, i16 65028)
 call void @assert (i16 3, i16 1023, i16 64516)
 call void @assert (i16 3, i16 2047, i16 63492)
 call void @assert (i16 3, i16 4095, i16 61444)
 call void @assert (i16 3, i16 8191, i16 57348)
 call void @assert (i16 3, i16 16383, i16 49156)
 call void @assert (i16 3, i16 32767, i16 32772)
 call void @assert (i16 7, i16 7, i16 0)
 call void @assert (i16 7, i16 15, i16 65528)
 call void @assert (i16 7, i16 31, i16 65512)
 call void @assert (i16 7, i16 63, i16 65480)
 call void @assert (i16 7, i16 127, i16 65416)
 call void @assert (i16 7, i16 255, i16 65288)
 call void @assert (i16 7, i16 511, i16 65032)
 call void @assert (i16 7, i16 1023, i16 64520)
 call void @assert (i16 7, i16 2047, i16 63496)
 call void @assert (i16 7, i16 4095, i16 61448)
 call void @assert (i16 7, i16 8191, i16 57352)
 call void @assert (i16 7, i16 16383, i16 49160)
 call void @assert (i16 7, i16 32767, i16 32776)
 call void @assert (i16 15, i16 15, i16 0)
 call void @assert (i16 15, i16 31, i16 65520)
 call void @assert (i16 15, i16 63, i16 65488)
 call void @assert (i16 15, i16 127, i16 65424)
 call void @assert (i16 15, i16 255, i16 65296)
 call void @assert (i16 15, i16 511, i16 65040)
 call void @assert (i16 15, i16 1023, i16 64528)
 call void @assert (i16 15, i16 2047, i16 63504)
 call void @assert (i16 15, i16 4095, i16 61456)
 call void @assert (i16 15, i16 8191, i16 57360)
 call void @assert (i16 15, i16 16383, i16 49168)
 call void @assert (i16 15, i16 32767, i16 32784)
 call void @assert (i16 31, i16 31, i16 0)
 call void @assert (i16 31, i16 63, i16 65504)
 call void @assert (i16 31, i16 127, i16 65440)
 call void @assert (i16 31, i16 255, i16 65312)
 call void @assert (i16 31, i16 511, i16 65056)
 call void @assert (i16 31, i16 1023, i16 64544)
 call void @assert (i16 31, i16 2047, i16 63520)
 call void @assert (i16 31, i16 4095, i16 61472)
 call void @assert (i16 31, i16 8191, i16 57376)
 call void @assert (i16 31, i16 16383, i16 49184)
 call void @assert (i16 31, i16 32767, i16 32800)
 call void @assert (i16 63, i16 63, i16 0)
 call void @assert (i16 63, i16 127, i16 65472)
 call void @assert (i16 63, i16 255, i16 65344)
 call void @assert (i16 63, i16 511, i16 65088)
 call void @assert (i16 63, i16 1023, i16 64576)
 call void @assert (i16 63, i16 2047, i16 63552)
 call void @assert (i16 63, i16 4095, i16 61504)
 call void @assert (i16 63, i16 8191, i16 57408)
 call void @assert (i16 63, i16 16383, i16 49216)
 call void @assert (i16 63, i16 32767, i16 32832)
 call void @assert (i16 127, i16 127, i16 0)
 call void @assert (i16 127, i16 255, i16 65408)
 call void @assert (i16 127, i16 511, i16 65152)
 call void @assert (i16 127, i16 1023, i16 64640)
 call void @assert (i16 127, i16 2047, i16 63616)
 call void @assert (i16 127, i16 4095, i16 61568)
 call void @assert (i16 127, i16 8191, i16 57472)
 call void @assert (i16 127, i16 16383, i16 49280)
 call void @assert (i16 127, i16 32767, i16 32896)
 call void @assert (i16 255, i16 255, i16 0)
 call void @assert (i16 255, i16 511, i16 65280)
 call void @assert (i16 255, i16 1023, i16 64768)
 call void @assert (i16 255, i16 2047, i16 63744)
 call void @assert (i16 255, i16 4095, i16 61696)
 call void @assert (i16 255, i16 8191, i16 57600)
 call void @assert (i16 255, i16 16383, i16 49408)
 call void @assert (i16 255, i16 32767, i16 33024)
 call void @assert (i16 511, i16 511, i16 0)
 call void @assert (i16 511, i16 1023, i16 65024)
 call void @assert (i16 511, i16 2047, i16 64000)
 call void @assert (i16 511, i16 4095, i16 61952)
 call void @assert (i16 511, i16 8191, i16 57856)
 call void @assert (i16 511, i16 16383, i16 49664)
 call void @assert (i16 511, i16 32767, i16 33280)
 call void @assert (i16 1023, i16 1023, i16 0)
 call void @assert (i16 1023, i16 2047, i16 64512)
 call void @assert (i16 1023, i16 4095, i16 62464)
 call void @assert (i16 1023, i16 8191, i16 58368)
 call void @assert (i16 1023, i16 16383, i16 50176)
 call void @assert (i16 1023, i16 32767, i16 33792)
 call void @assert (i16 2047, i16 2047, i16 0)
 call void @assert (i16 2047, i16 4095, i16 63488)
 call void @assert (i16 2047, i16 8191, i16 59392)
 call void @assert (i16 2047, i16 16383, i16 51200)
 call void @assert (i16 2047, i16 32767, i16 34816)
 call void @assert (i16 4095, i16 4095, i16 0)
 call void @assert (i16 4095, i16 8191, i16 61440)
 call void @assert (i16 4095, i16 16383, i16 53248)
 call void @assert (i16 4095, i16 32767, i16 36864)
 call void @assert (i16 8191, i16 8191, i16 0)
 call void @assert (i16 8191, i16 16383, i16 57344)
 call void @assert (i16 8191, i16 32767, i16 40960)
 call void @assert (i16 16383, i16 16383, i16 0)
 call void @assert (i16 16383, i16 32767, i16 49152)
 call void @assert (i16 32767, i16 32767, i16 0)
 ret i32 0
}
