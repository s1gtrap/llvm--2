@.str = global [21 x i8] c"%ld urem %ld != %ld\0A\00"
@.str.1 = global [21 x i8] c"%ld urem %ld == %ld\0A\00"

declare i32 @printf(i8*, ...)

define void @assert (i32 %0, i32 %1, i32 %2) {
 %4 = urem i32 %0, %1
 %5 = icmp eq i32 %2, %4
 %6 = select i1 %5, i8* @.str.1, i8* @.str
 call i32 (i8*, ...) @printf (i8* %6, i32 %0, i32 %1, i32 %2)
 ret void
}

define i32 @main (i32 %0, i8* %1) {
 call void @assert (i32 0, i32 1, i32 0)
 call void @assert (i32 1, i32 1, i32 0)
 call void @assert (i32 1, i32 2, i32 1)
 call void @assert (i32 1, i32 2, i32 1)
 call void @assert (i32 1, i32 1, i32 0)
 call void @assert (i32 1, i32 3, i32 1)
 call void @assert (i32 1, i32 7, i32 1)
 call void @assert (i32 1, i32 15, i32 1)
 call void @assert (i32 1, i32 31, i32 1)
 call void @assert (i32 1, i32 63, i32 1)
 call void @assert (i32 1, i32 127, i32 1)
 call void @assert (i32 1, i32 255, i32 1)
 call void @assert (i32 1, i32 511, i32 1)
 call void @assert (i32 1, i32 1023, i32 1)
 call void @assert (i32 1, i32 2047, i32 1)
 call void @assert (i32 1, i32 4095, i32 1)
 call void @assert (i32 1, i32 8191, i32 1)
 call void @assert (i32 1, i32 16383, i32 1)
 call void @assert (i32 1, i32 32767, i32 1)
 call void @assert (i32 1, i32 65535, i32 1)
 call void @assert (i32 1, i32 131071, i32 1)
 call void @assert (i32 1, i32 262143, i32 1)
 call void @assert (i32 1, i32 524287, i32 1)
 call void @assert (i32 1, i32 1048575, i32 1)
 call void @assert (i32 1, i32 2097151, i32 1)
 call void @assert (i32 1, i32 4194303, i32 1)
 call void @assert (i32 1, i32 8388607, i32 1)
 call void @assert (i32 1, i32 16777215, i32 1)
 call void @assert (i32 1, i32 33554431, i32 1)
 call void @assert (i32 1, i32 67108863, i32 1)
 call void @assert (i32 1, i32 134217727, i32 1)
 call void @assert (i32 1, i32 268435455, i32 1)
 call void @assert (i32 1, i32 536870911, i32 1)
 call void @assert (i32 1, i32 1073741823, i32 1)
 call void @assert (i32 1, i32 2147483647, i32 1)
 call void @assert (i32 3, i32 3, i32 0)
 call void @assert (i32 3, i32 7, i32 3)
 call void @assert (i32 3, i32 15, i32 3)
 call void @assert (i32 3, i32 31, i32 3)
 call void @assert (i32 3, i32 63, i32 3)
 call void @assert (i32 3, i32 127, i32 3)
 call void @assert (i32 3, i32 255, i32 3)
 call void @assert (i32 3, i32 511, i32 3)
 call void @assert (i32 3, i32 1023, i32 3)
 call void @assert (i32 3, i32 2047, i32 3)
 call void @assert (i32 3, i32 4095, i32 3)
 call void @assert (i32 3, i32 8191, i32 3)
 call void @assert (i32 3, i32 16383, i32 3)
 call void @assert (i32 3, i32 32767, i32 3)
 call void @assert (i32 3, i32 65535, i32 3)
 call void @assert (i32 3, i32 131071, i32 3)
 call void @assert (i32 3, i32 262143, i32 3)
 call void @assert (i32 3, i32 524287, i32 3)
 call void @assert (i32 3, i32 1048575, i32 3)
 call void @assert (i32 3, i32 2097151, i32 3)
 call void @assert (i32 3, i32 4194303, i32 3)
 call void @assert (i32 3, i32 8388607, i32 3)
 call void @assert (i32 3, i32 16777215, i32 3)
 call void @assert (i32 3, i32 33554431, i32 3)
 call void @assert (i32 3, i32 67108863, i32 3)
 call void @assert (i32 3, i32 134217727, i32 3)
 call void @assert (i32 3, i32 268435455, i32 3)
 call void @assert (i32 3, i32 536870911, i32 3)
 call void @assert (i32 3, i32 1073741823, i32 3)
 call void @assert (i32 3, i32 2147483647, i32 3)
 call void @assert (i32 7, i32 7, i32 0)
 call void @assert (i32 7, i32 15, i32 7)
 call void @assert (i32 7, i32 31, i32 7)
 call void @assert (i32 7, i32 63, i32 7)
 call void @assert (i32 7, i32 127, i32 7)
 call void @assert (i32 7, i32 255, i32 7)
 call void @assert (i32 7, i32 511, i32 7)
 call void @assert (i32 7, i32 1023, i32 7)
 call void @assert (i32 7, i32 2047, i32 7)
 call void @assert (i32 7, i32 4095, i32 7)
 call void @assert (i32 7, i32 8191, i32 7)
 call void @assert (i32 7, i32 16383, i32 7)
 call void @assert (i32 7, i32 32767, i32 7)
 call void @assert (i32 7, i32 65535, i32 7)
 call void @assert (i32 7, i32 131071, i32 7)
 call void @assert (i32 7, i32 262143, i32 7)
 call void @assert (i32 7, i32 524287, i32 7)
 call void @assert (i32 7, i32 1048575, i32 7)
 call void @assert (i32 7, i32 2097151, i32 7)
 call void @assert (i32 7, i32 4194303, i32 7)
 call void @assert (i32 7, i32 8388607, i32 7)
 call void @assert (i32 7, i32 16777215, i32 7)
 call void @assert (i32 7, i32 33554431, i32 7)
 call void @assert (i32 7, i32 67108863, i32 7)
 call void @assert (i32 7, i32 134217727, i32 7)
 call void @assert (i32 7, i32 268435455, i32 7)
 call void @assert (i32 7, i32 536870911, i32 7)
 call void @assert (i32 7, i32 1073741823, i32 7)
 call void @assert (i32 7, i32 2147483647, i32 7)
 call void @assert (i32 15, i32 15, i32 0)
 call void @assert (i32 15, i32 31, i32 15)
 call void @assert (i32 15, i32 63, i32 15)
 call void @assert (i32 15, i32 127, i32 15)
 call void @assert (i32 15, i32 255, i32 15)
 call void @assert (i32 15, i32 511, i32 15)
 call void @assert (i32 15, i32 1023, i32 15)
 call void @assert (i32 15, i32 2047, i32 15)
 call void @assert (i32 15, i32 4095, i32 15)
 call void @assert (i32 15, i32 8191, i32 15)
 call void @assert (i32 15, i32 16383, i32 15)
 call void @assert (i32 15, i32 32767, i32 15)
 call void @assert (i32 15, i32 65535, i32 15)
 call void @assert (i32 15, i32 131071, i32 15)
 call void @assert (i32 15, i32 262143, i32 15)
 call void @assert (i32 15, i32 524287, i32 15)
 call void @assert (i32 15, i32 1048575, i32 15)
 call void @assert (i32 15, i32 2097151, i32 15)
 call void @assert (i32 15, i32 4194303, i32 15)
 call void @assert (i32 15, i32 8388607, i32 15)
 call void @assert (i32 15, i32 16777215, i32 15)
 call void @assert (i32 15, i32 33554431, i32 15)
 call void @assert (i32 15, i32 67108863, i32 15)
 call void @assert (i32 15, i32 134217727, i32 15)
 call void @assert (i32 15, i32 268435455, i32 15)
 call void @assert (i32 15, i32 536870911, i32 15)
 call void @assert (i32 15, i32 1073741823, i32 15)
 call void @assert (i32 15, i32 2147483647, i32 15)
 call void @assert (i32 31, i32 31, i32 0)
 call void @assert (i32 31, i32 63, i32 31)
 call void @assert (i32 31, i32 127, i32 31)
 call void @assert (i32 31, i32 255, i32 31)
 call void @assert (i32 31, i32 511, i32 31)
 call void @assert (i32 31, i32 1023, i32 31)
 call void @assert (i32 31, i32 2047, i32 31)
 call void @assert (i32 31, i32 4095, i32 31)
 call void @assert (i32 31, i32 8191, i32 31)
 call void @assert (i32 31, i32 16383, i32 31)
 call void @assert (i32 31, i32 32767, i32 31)
 call void @assert (i32 31, i32 65535, i32 31)
 call void @assert (i32 31, i32 131071, i32 31)
 call void @assert (i32 31, i32 262143, i32 31)
 call void @assert (i32 31, i32 524287, i32 31)
 call void @assert (i32 31, i32 1048575, i32 31)
 call void @assert (i32 31, i32 2097151, i32 31)
 call void @assert (i32 31, i32 4194303, i32 31)
 call void @assert (i32 31, i32 8388607, i32 31)
 call void @assert (i32 31, i32 16777215, i32 31)
 call void @assert (i32 31, i32 33554431, i32 31)
 call void @assert (i32 31, i32 67108863, i32 31)
 call void @assert (i32 31, i32 134217727, i32 31)
 call void @assert (i32 31, i32 268435455, i32 31)
 call void @assert (i32 31, i32 536870911, i32 31)
 call void @assert (i32 31, i32 1073741823, i32 31)
 call void @assert (i32 31, i32 2147483647, i32 31)
 call void @assert (i32 63, i32 63, i32 0)
 call void @assert (i32 63, i32 127, i32 63)
 call void @assert (i32 63, i32 255, i32 63)
 call void @assert (i32 63, i32 511, i32 63)
 call void @assert (i32 63, i32 1023, i32 63)
 call void @assert (i32 63, i32 2047, i32 63)
 call void @assert (i32 63, i32 4095, i32 63)
 call void @assert (i32 63, i32 8191, i32 63)
 call void @assert (i32 63, i32 16383, i32 63)
 call void @assert (i32 63, i32 32767, i32 63)
 call void @assert (i32 63, i32 65535, i32 63)
 call void @assert (i32 63, i32 131071, i32 63)
 call void @assert (i32 63, i32 262143, i32 63)
 call void @assert (i32 63, i32 524287, i32 63)
 call void @assert (i32 63, i32 1048575, i32 63)
 call void @assert (i32 63, i32 2097151, i32 63)
 call void @assert (i32 63, i32 4194303, i32 63)
 call void @assert (i32 63, i32 8388607, i32 63)
 call void @assert (i32 63, i32 16777215, i32 63)
 call void @assert (i32 63, i32 33554431, i32 63)
 call void @assert (i32 63, i32 67108863, i32 63)
 call void @assert (i32 63, i32 134217727, i32 63)
 call void @assert (i32 63, i32 268435455, i32 63)
 call void @assert (i32 63, i32 536870911, i32 63)
 call void @assert (i32 63, i32 1073741823, i32 63)
 call void @assert (i32 63, i32 2147483647, i32 63)
 call void @assert (i32 127, i32 127, i32 0)
 call void @assert (i32 127, i32 255, i32 127)
 call void @assert (i32 127, i32 511, i32 127)
 call void @assert (i32 127, i32 1023, i32 127)
 call void @assert (i32 127, i32 2047, i32 127)
 call void @assert (i32 127, i32 4095, i32 127)
 call void @assert (i32 127, i32 8191, i32 127)
 call void @assert (i32 127, i32 16383, i32 127)
 call void @assert (i32 127, i32 32767, i32 127)
 call void @assert (i32 127, i32 65535, i32 127)
 call void @assert (i32 127, i32 131071, i32 127)
 call void @assert (i32 127, i32 262143, i32 127)
 call void @assert (i32 127, i32 524287, i32 127)
 call void @assert (i32 127, i32 1048575, i32 127)
 call void @assert (i32 127, i32 2097151, i32 127)
 call void @assert (i32 127, i32 4194303, i32 127)
 call void @assert (i32 127, i32 8388607, i32 127)
 call void @assert (i32 127, i32 16777215, i32 127)
 call void @assert (i32 127, i32 33554431, i32 127)
 call void @assert (i32 127, i32 67108863, i32 127)
 call void @assert (i32 127, i32 134217727, i32 127)
 call void @assert (i32 127, i32 268435455, i32 127)
 call void @assert (i32 127, i32 536870911, i32 127)
 call void @assert (i32 127, i32 1073741823, i32 127)
 call void @assert (i32 127, i32 2147483647, i32 127)
 call void @assert (i32 255, i32 255, i32 0)
 call void @assert (i32 255, i32 511, i32 255)
 call void @assert (i32 255, i32 1023, i32 255)
 call void @assert (i32 255, i32 2047, i32 255)
 call void @assert (i32 255, i32 4095, i32 255)
 call void @assert (i32 255, i32 8191, i32 255)
 call void @assert (i32 255, i32 16383, i32 255)
 call void @assert (i32 255, i32 32767, i32 255)
 call void @assert (i32 255, i32 65535, i32 255)
 call void @assert (i32 255, i32 131071, i32 255)
 call void @assert (i32 255, i32 262143, i32 255)
 call void @assert (i32 255, i32 524287, i32 255)
 call void @assert (i32 255, i32 1048575, i32 255)
 call void @assert (i32 255, i32 2097151, i32 255)
 call void @assert (i32 255, i32 4194303, i32 255)
 call void @assert (i32 255, i32 8388607, i32 255)
 call void @assert (i32 255, i32 16777215, i32 255)
 call void @assert (i32 255, i32 33554431, i32 255)
 call void @assert (i32 255, i32 67108863, i32 255)
 call void @assert (i32 255, i32 134217727, i32 255)
 call void @assert (i32 255, i32 268435455, i32 255)
 call void @assert (i32 255, i32 536870911, i32 255)
 call void @assert (i32 255, i32 1073741823, i32 255)
 call void @assert (i32 255, i32 2147483647, i32 255)
 call void @assert (i32 511, i32 511, i32 0)
 call void @assert (i32 511, i32 1023, i32 511)
 call void @assert (i32 511, i32 2047, i32 511)
 call void @assert (i32 511, i32 4095, i32 511)
 call void @assert (i32 511, i32 8191, i32 511)
 call void @assert (i32 511, i32 16383, i32 511)
 call void @assert (i32 511, i32 32767, i32 511)
 call void @assert (i32 511, i32 65535, i32 511)
 call void @assert (i32 511, i32 131071, i32 511)
 call void @assert (i32 511, i32 262143, i32 511)
 call void @assert (i32 511, i32 524287, i32 511)
 call void @assert (i32 511, i32 1048575, i32 511)
 call void @assert (i32 511, i32 2097151, i32 511)
 call void @assert (i32 511, i32 4194303, i32 511)
 call void @assert (i32 511, i32 8388607, i32 511)
 call void @assert (i32 511, i32 16777215, i32 511)
 call void @assert (i32 511, i32 33554431, i32 511)
 call void @assert (i32 511, i32 67108863, i32 511)
 call void @assert (i32 511, i32 134217727, i32 511)
 call void @assert (i32 511, i32 268435455, i32 511)
 call void @assert (i32 511, i32 536870911, i32 511)
 call void @assert (i32 511, i32 1073741823, i32 511)
 call void @assert (i32 511, i32 2147483647, i32 511)
 call void @assert (i32 1023, i32 1023, i32 0)
 call void @assert (i32 1023, i32 2047, i32 1023)
 call void @assert (i32 1023, i32 4095, i32 1023)
 call void @assert (i32 1023, i32 8191, i32 1023)
 call void @assert (i32 1023, i32 16383, i32 1023)
 call void @assert (i32 1023, i32 32767, i32 1023)
 call void @assert (i32 1023, i32 65535, i32 1023)
 call void @assert (i32 1023, i32 131071, i32 1023)
 call void @assert (i32 1023, i32 262143, i32 1023)
 call void @assert (i32 1023, i32 524287, i32 1023)
 call void @assert (i32 1023, i32 1048575, i32 1023)
 call void @assert (i32 1023, i32 2097151, i32 1023)
 call void @assert (i32 1023, i32 4194303, i32 1023)
 call void @assert (i32 1023, i32 8388607, i32 1023)
 call void @assert (i32 1023, i32 16777215, i32 1023)
 call void @assert (i32 1023, i32 33554431, i32 1023)
 call void @assert (i32 1023, i32 67108863, i32 1023)
 call void @assert (i32 1023, i32 134217727, i32 1023)
 call void @assert (i32 1023, i32 268435455, i32 1023)
 call void @assert (i32 1023, i32 536870911, i32 1023)
 call void @assert (i32 1023, i32 1073741823, i32 1023)
 call void @assert (i32 1023, i32 2147483647, i32 1023)
 call void @assert (i32 2047, i32 2047, i32 0)
 call void @assert (i32 2047, i32 4095, i32 2047)
 call void @assert (i32 2047, i32 8191, i32 2047)
 call void @assert (i32 2047, i32 16383, i32 2047)
 call void @assert (i32 2047, i32 32767, i32 2047)
 call void @assert (i32 2047, i32 65535, i32 2047)
 call void @assert (i32 2047, i32 131071, i32 2047)
 call void @assert (i32 2047, i32 262143, i32 2047)
 call void @assert (i32 2047, i32 524287, i32 2047)
 call void @assert (i32 2047, i32 1048575, i32 2047)
 call void @assert (i32 2047, i32 2097151, i32 2047)
 call void @assert (i32 2047, i32 4194303, i32 2047)
 call void @assert (i32 2047, i32 8388607, i32 2047)
 call void @assert (i32 2047, i32 16777215, i32 2047)
 call void @assert (i32 2047, i32 33554431, i32 2047)
 call void @assert (i32 2047, i32 67108863, i32 2047)
 call void @assert (i32 2047, i32 134217727, i32 2047)
 call void @assert (i32 2047, i32 268435455, i32 2047)
 call void @assert (i32 2047, i32 536870911, i32 2047)
 call void @assert (i32 2047, i32 1073741823, i32 2047)
 call void @assert (i32 2047, i32 2147483647, i32 2047)
 call void @assert (i32 4095, i32 4095, i32 0)
 call void @assert (i32 4095, i32 8191, i32 4095)
 call void @assert (i32 4095, i32 16383, i32 4095)
 call void @assert (i32 4095, i32 32767, i32 4095)
 call void @assert (i32 4095, i32 65535, i32 4095)
 call void @assert (i32 4095, i32 131071, i32 4095)
 call void @assert (i32 4095, i32 262143, i32 4095)
 call void @assert (i32 4095, i32 524287, i32 4095)
 call void @assert (i32 4095, i32 1048575, i32 4095)
 call void @assert (i32 4095, i32 2097151, i32 4095)
 call void @assert (i32 4095, i32 4194303, i32 4095)
 call void @assert (i32 4095, i32 8388607, i32 4095)
 call void @assert (i32 4095, i32 16777215, i32 4095)
 call void @assert (i32 4095, i32 33554431, i32 4095)
 call void @assert (i32 4095, i32 67108863, i32 4095)
 call void @assert (i32 4095, i32 134217727, i32 4095)
 call void @assert (i32 4095, i32 268435455, i32 4095)
 call void @assert (i32 4095, i32 536870911, i32 4095)
 call void @assert (i32 4095, i32 1073741823, i32 4095)
 call void @assert (i32 4095, i32 2147483647, i32 4095)
 call void @assert (i32 8191, i32 8191, i32 0)
 call void @assert (i32 8191, i32 16383, i32 8191)
 call void @assert (i32 8191, i32 32767, i32 8191)
 call void @assert (i32 8191, i32 65535, i32 8191)
 call void @assert (i32 8191, i32 131071, i32 8191)
 call void @assert (i32 8191, i32 262143, i32 8191)
 call void @assert (i32 8191, i32 524287, i32 8191)
 call void @assert (i32 8191, i32 1048575, i32 8191)
 call void @assert (i32 8191, i32 2097151, i32 8191)
 call void @assert (i32 8191, i32 4194303, i32 8191)
 call void @assert (i32 8191, i32 8388607, i32 8191)
 call void @assert (i32 8191, i32 16777215, i32 8191)
 call void @assert (i32 8191, i32 33554431, i32 8191)
 call void @assert (i32 8191, i32 67108863, i32 8191)
 call void @assert (i32 8191, i32 134217727, i32 8191)
 call void @assert (i32 8191, i32 268435455, i32 8191)
 call void @assert (i32 8191, i32 536870911, i32 8191)
 call void @assert (i32 8191, i32 1073741823, i32 8191)
 call void @assert (i32 8191, i32 2147483647, i32 8191)
 call void @assert (i32 16383, i32 16383, i32 0)
 call void @assert (i32 16383, i32 32767, i32 16383)
 call void @assert (i32 16383, i32 65535, i32 16383)
 call void @assert (i32 16383, i32 131071, i32 16383)
 call void @assert (i32 16383, i32 262143, i32 16383)
 call void @assert (i32 16383, i32 524287, i32 16383)
 call void @assert (i32 16383, i32 1048575, i32 16383)
 call void @assert (i32 16383, i32 2097151, i32 16383)
 call void @assert (i32 16383, i32 4194303, i32 16383)
 call void @assert (i32 16383, i32 8388607, i32 16383)
 call void @assert (i32 16383, i32 16777215, i32 16383)
 call void @assert (i32 16383, i32 33554431, i32 16383)
 call void @assert (i32 16383, i32 67108863, i32 16383)
 call void @assert (i32 16383, i32 134217727, i32 16383)
 call void @assert (i32 16383, i32 268435455, i32 16383)
 call void @assert (i32 16383, i32 536870911, i32 16383)
 call void @assert (i32 16383, i32 1073741823, i32 16383)
 call void @assert (i32 16383, i32 2147483647, i32 16383)
 call void @assert (i32 32767, i32 32767, i32 0)
 call void @assert (i32 32767, i32 65535, i32 32767)
 call void @assert (i32 32767, i32 131071, i32 32767)
 call void @assert (i32 32767, i32 262143, i32 32767)
 call void @assert (i32 32767, i32 524287, i32 32767)
 call void @assert (i32 32767, i32 1048575, i32 32767)
 call void @assert (i32 32767, i32 2097151, i32 32767)
 call void @assert (i32 32767, i32 4194303, i32 32767)
 call void @assert (i32 32767, i32 8388607, i32 32767)
 call void @assert (i32 32767, i32 16777215, i32 32767)
 call void @assert (i32 32767, i32 33554431, i32 32767)
 call void @assert (i32 32767, i32 67108863, i32 32767)
 call void @assert (i32 32767, i32 134217727, i32 32767)
 call void @assert (i32 32767, i32 268435455, i32 32767)
 call void @assert (i32 32767, i32 536870911, i32 32767)
 call void @assert (i32 32767, i32 1073741823, i32 32767)
 call void @assert (i32 32767, i32 2147483647, i32 32767)
 call void @assert (i32 65535, i32 65535, i32 0)
 call void @assert (i32 65535, i32 131071, i32 65535)
 call void @assert (i32 65535, i32 262143, i32 65535)
 call void @assert (i32 65535, i32 524287, i32 65535)
 call void @assert (i32 65535, i32 1048575, i32 65535)
 call void @assert (i32 65535, i32 2097151, i32 65535)
 call void @assert (i32 65535, i32 4194303, i32 65535)
 call void @assert (i32 65535, i32 8388607, i32 65535)
 call void @assert (i32 65535, i32 16777215, i32 65535)
 call void @assert (i32 65535, i32 33554431, i32 65535)
 call void @assert (i32 65535, i32 67108863, i32 65535)
 call void @assert (i32 65535, i32 134217727, i32 65535)
 call void @assert (i32 65535, i32 268435455, i32 65535)
 call void @assert (i32 65535, i32 536870911, i32 65535)
 call void @assert (i32 65535, i32 1073741823, i32 65535)
 call void @assert (i32 65535, i32 2147483647, i32 65535)
 call void @assert (i32 131071, i32 131071, i32 0)
 call void @assert (i32 131071, i32 262143, i32 131071)
 call void @assert (i32 131071, i32 524287, i32 131071)
 call void @assert (i32 131071, i32 1048575, i32 131071)
 call void @assert (i32 131071, i32 2097151, i32 131071)
 call void @assert (i32 131071, i32 4194303, i32 131071)
 call void @assert (i32 131071, i32 8388607, i32 131071)
 call void @assert (i32 131071, i32 16777215, i32 131071)
 call void @assert (i32 131071, i32 33554431, i32 131071)
 call void @assert (i32 131071, i32 67108863, i32 131071)
 call void @assert (i32 131071, i32 134217727, i32 131071)
 call void @assert (i32 131071, i32 268435455, i32 131071)
 call void @assert (i32 131071, i32 536870911, i32 131071)
 call void @assert (i32 131071, i32 1073741823, i32 131071)
 call void @assert (i32 131071, i32 2147483647, i32 131071)
 call void @assert (i32 262143, i32 262143, i32 0)
 call void @assert (i32 262143, i32 524287, i32 262143)
 call void @assert (i32 262143, i32 1048575, i32 262143)
 call void @assert (i32 262143, i32 2097151, i32 262143)
 call void @assert (i32 262143, i32 4194303, i32 262143)
 call void @assert (i32 262143, i32 8388607, i32 262143)
 call void @assert (i32 262143, i32 16777215, i32 262143)
 call void @assert (i32 262143, i32 33554431, i32 262143)
 call void @assert (i32 262143, i32 67108863, i32 262143)
 call void @assert (i32 262143, i32 134217727, i32 262143)
 call void @assert (i32 262143, i32 268435455, i32 262143)
 call void @assert (i32 262143, i32 536870911, i32 262143)
 call void @assert (i32 262143, i32 1073741823, i32 262143)
 call void @assert (i32 262143, i32 2147483647, i32 262143)
 call void @assert (i32 524287, i32 524287, i32 0)
 call void @assert (i32 524287, i32 1048575, i32 524287)
 call void @assert (i32 524287, i32 2097151, i32 524287)
 call void @assert (i32 524287, i32 4194303, i32 524287)
 call void @assert (i32 524287, i32 8388607, i32 524287)
 call void @assert (i32 524287, i32 16777215, i32 524287)
 call void @assert (i32 524287, i32 33554431, i32 524287)
 call void @assert (i32 524287, i32 67108863, i32 524287)
 call void @assert (i32 524287, i32 134217727, i32 524287)
 call void @assert (i32 524287, i32 268435455, i32 524287)
 call void @assert (i32 524287, i32 536870911, i32 524287)
 call void @assert (i32 524287, i32 1073741823, i32 524287)
 call void @assert (i32 524287, i32 2147483647, i32 524287)
 call void @assert (i32 1048575, i32 1048575, i32 0)
 call void @assert (i32 1048575, i32 2097151, i32 1048575)
 call void @assert (i32 1048575, i32 4194303, i32 1048575)
 call void @assert (i32 1048575, i32 8388607, i32 1048575)
 call void @assert (i32 1048575, i32 16777215, i32 1048575)
 call void @assert (i32 1048575, i32 33554431, i32 1048575)
 call void @assert (i32 1048575, i32 67108863, i32 1048575)
 call void @assert (i32 1048575, i32 134217727, i32 1048575)
 call void @assert (i32 1048575, i32 268435455, i32 1048575)
 call void @assert (i32 1048575, i32 536870911, i32 1048575)
 call void @assert (i32 1048575, i32 1073741823, i32 1048575)
 call void @assert (i32 1048575, i32 2147483647, i32 1048575)
 call void @assert (i32 2097151, i32 2097151, i32 0)
 call void @assert (i32 2097151, i32 4194303, i32 2097151)
 call void @assert (i32 2097151, i32 8388607, i32 2097151)
 call void @assert (i32 2097151, i32 16777215, i32 2097151)
 call void @assert (i32 2097151, i32 33554431, i32 2097151)
 call void @assert (i32 2097151, i32 67108863, i32 2097151)
 call void @assert (i32 2097151, i32 134217727, i32 2097151)
 call void @assert (i32 2097151, i32 268435455, i32 2097151)
 call void @assert (i32 2097151, i32 536870911, i32 2097151)
 call void @assert (i32 2097151, i32 1073741823, i32 2097151)
 call void @assert (i32 2097151, i32 2147483647, i32 2097151)
 call void @assert (i32 4194303, i32 4194303, i32 0)
 call void @assert (i32 4194303, i32 8388607, i32 4194303)
 call void @assert (i32 4194303, i32 16777215, i32 4194303)
 call void @assert (i32 4194303, i32 33554431, i32 4194303)
 call void @assert (i32 4194303, i32 67108863, i32 4194303)
 call void @assert (i32 4194303, i32 134217727, i32 4194303)
 call void @assert (i32 4194303, i32 268435455, i32 4194303)
 call void @assert (i32 4194303, i32 536870911, i32 4194303)
 call void @assert (i32 4194303, i32 1073741823, i32 4194303)
 call void @assert (i32 4194303, i32 2147483647, i32 4194303)
 call void @assert (i32 8388607, i32 8388607, i32 0)
 call void @assert (i32 8388607, i32 16777215, i32 8388607)
 call void @assert (i32 8388607, i32 33554431, i32 8388607)
 call void @assert (i32 8388607, i32 67108863, i32 8388607)
 call void @assert (i32 8388607, i32 134217727, i32 8388607)
 call void @assert (i32 8388607, i32 268435455, i32 8388607)
 call void @assert (i32 8388607, i32 536870911, i32 8388607)
 call void @assert (i32 8388607, i32 1073741823, i32 8388607)
 call void @assert (i32 8388607, i32 2147483647, i32 8388607)
 call void @assert (i32 16777215, i32 16777215, i32 0)
 call void @assert (i32 16777215, i32 33554431, i32 16777215)
 call void @assert (i32 16777215, i32 67108863, i32 16777215)
 call void @assert (i32 16777215, i32 134217727, i32 16777215)
 call void @assert (i32 16777215, i32 268435455, i32 16777215)
 call void @assert (i32 16777215, i32 536870911, i32 16777215)
 call void @assert (i32 16777215, i32 1073741823, i32 16777215)
 call void @assert (i32 16777215, i32 2147483647, i32 16777215)
 call void @assert (i32 33554431, i32 33554431, i32 0)
 call void @assert (i32 33554431, i32 67108863, i32 33554431)
 call void @assert (i32 33554431, i32 134217727, i32 33554431)
 call void @assert (i32 33554431, i32 268435455, i32 33554431)
 call void @assert (i32 33554431, i32 536870911, i32 33554431)
 call void @assert (i32 33554431, i32 1073741823, i32 33554431)
 call void @assert (i32 33554431, i32 2147483647, i32 33554431)
 call void @assert (i32 67108863, i32 67108863, i32 0)
 call void @assert (i32 67108863, i32 134217727, i32 67108863)
 call void @assert (i32 67108863, i32 268435455, i32 67108863)
 call void @assert (i32 67108863, i32 536870911, i32 67108863)
 call void @assert (i32 67108863, i32 1073741823, i32 67108863)
 call void @assert (i32 67108863, i32 2147483647, i32 67108863)
 call void @assert (i32 134217727, i32 134217727, i32 0)
 call void @assert (i32 134217727, i32 268435455, i32 134217727)
 call void @assert (i32 134217727, i32 536870911, i32 134217727)
 call void @assert (i32 134217727, i32 1073741823, i32 134217727)
 call void @assert (i32 134217727, i32 2147483647, i32 134217727)
 call void @assert (i32 268435455, i32 268435455, i32 0)
 call void @assert (i32 268435455, i32 536870911, i32 268435455)
 call void @assert (i32 268435455, i32 1073741823, i32 268435455)
 call void @assert (i32 268435455, i32 2147483647, i32 268435455)
 call void @assert (i32 536870911, i32 536870911, i32 0)
 call void @assert (i32 536870911, i32 1073741823, i32 536870911)
 call void @assert (i32 536870911, i32 2147483647, i32 536870911)
 call void @assert (i32 1073741823, i32 1073741823, i32 0)
 call void @assert (i32 1073741823, i32 2147483647, i32 1073741823)
 call void @assert (i32 2147483647, i32 2147483647, i32 0)
 ret i32 0
}
