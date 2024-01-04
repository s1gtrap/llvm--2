@.str = global [18 x i8] c"%ld + %ld != %ld\0A\00"
@.str.1 = global [18 x i8] c"%ld + %ld == %ld\0A\00"

declare i32 @printf(i8*, ...)

define void @assert (i32 %0, i32 %1, i32 %2) {
 %4 = add i32 %0, %1
 %5 = icmp eq i32 %2, %4
 %6 = select i1 %5, i8* @.str.1, i8* @.str
 call i32 (i8*, ...) @printf (i8* %6, i32 %0, i32 %1, i32 %2)
 ret void
}

define i32 @main (i32 %0, i8* %1) {
 call void @assert (i32 0, i32 0, i32 0)
 call void @assert (i32 1, i32 0, i32 1)
 call void @assert (i32 0, i32 1, i32 1)
 call void @assert (i32 1, i32 1, i32 2)
 call void @assert (i32 1, i32 2, i32 3)
 call void @assert (i32 1, i32 2, i32 3)
 call void @assert (i32 1, i32 1, i32 2)
 call void @assert (i32 1, i32 3, i32 4)
 call void @assert (i32 1, i32 7, i32 8)
 call void @assert (i32 1, i32 15, i32 16)
 call void @assert (i32 1, i32 31, i32 32)
 call void @assert (i32 1, i32 63, i32 64)
 call void @assert (i32 1, i32 127, i32 128)
 call void @assert (i32 1, i32 255, i32 256)
 call void @assert (i32 1, i32 511, i32 512)
 call void @assert (i32 1, i32 1023, i32 1024)
 call void @assert (i32 1, i32 2047, i32 2048)
 call void @assert (i32 1, i32 4095, i32 4096)
 call void @assert (i32 1, i32 8191, i32 8192)
 call void @assert (i32 1, i32 16383, i32 16384)
 call void @assert (i32 1, i32 32767, i32 32768)
 call void @assert (i32 1, i32 65535, i32 65536)
 call void @assert (i32 1, i32 131071, i32 131072)
 call void @assert (i32 1, i32 262143, i32 262144)
 call void @assert (i32 1, i32 524287, i32 524288)
 call void @assert (i32 1, i32 1048575, i32 1048576)
 call void @assert (i32 1, i32 2097151, i32 2097152)
 call void @assert (i32 1, i32 4194303, i32 4194304)
 call void @assert (i32 1, i32 8388607, i32 8388608)
 call void @assert (i32 1, i32 16777215, i32 16777216)
 call void @assert (i32 1, i32 33554431, i32 33554432)
 call void @assert (i32 1, i32 67108863, i32 67108864)
 call void @assert (i32 1, i32 134217727, i32 134217728)
 call void @assert (i32 1, i32 268435455, i32 268435456)
 call void @assert (i32 1, i32 536870911, i32 536870912)
 call void @assert (i32 1, i32 1073741823, i32 1073741824)
 call void @assert (i32 1, i32 2147483647, i32 2147483648)
 call void @assert (i32 3, i32 3, i32 6)
 call void @assert (i32 3, i32 7, i32 10)
 call void @assert (i32 3, i32 15, i32 18)
 call void @assert (i32 3, i32 31, i32 34)
 call void @assert (i32 3, i32 63, i32 66)
 call void @assert (i32 3, i32 127, i32 130)
 call void @assert (i32 3, i32 255, i32 258)
 call void @assert (i32 3, i32 511, i32 514)
 call void @assert (i32 3, i32 1023, i32 1026)
 call void @assert (i32 3, i32 2047, i32 2050)
 call void @assert (i32 3, i32 4095, i32 4098)
 call void @assert (i32 3, i32 8191, i32 8194)
 call void @assert (i32 3, i32 16383, i32 16386)
 call void @assert (i32 3, i32 32767, i32 32770)
 call void @assert (i32 3, i32 65535, i32 65538)
 call void @assert (i32 3, i32 131071, i32 131074)
 call void @assert (i32 3, i32 262143, i32 262146)
 call void @assert (i32 3, i32 524287, i32 524290)
 call void @assert (i32 3, i32 1048575, i32 1048578)
 call void @assert (i32 3, i32 2097151, i32 2097154)
 call void @assert (i32 3, i32 4194303, i32 4194306)
 call void @assert (i32 3, i32 8388607, i32 8388610)
 call void @assert (i32 3, i32 16777215, i32 16777218)
 call void @assert (i32 3, i32 33554431, i32 33554434)
 call void @assert (i32 3, i32 67108863, i32 67108866)
 call void @assert (i32 3, i32 134217727, i32 134217730)
 call void @assert (i32 3, i32 268435455, i32 268435458)
 call void @assert (i32 3, i32 536870911, i32 536870914)
 call void @assert (i32 3, i32 1073741823, i32 1073741826)
 call void @assert (i32 3, i32 2147483647, i32 2147483650)
 call void @assert (i32 7, i32 7, i32 14)
 call void @assert (i32 7, i32 15, i32 22)
 call void @assert (i32 7, i32 31, i32 38)
 call void @assert (i32 7, i32 63, i32 70)
 call void @assert (i32 7, i32 127, i32 134)
 call void @assert (i32 7, i32 255, i32 262)
 call void @assert (i32 7, i32 511, i32 518)
 call void @assert (i32 7, i32 1023, i32 1030)
 call void @assert (i32 7, i32 2047, i32 2054)
 call void @assert (i32 7, i32 4095, i32 4102)
 call void @assert (i32 7, i32 8191, i32 8198)
 call void @assert (i32 7, i32 16383, i32 16390)
 call void @assert (i32 7, i32 32767, i32 32774)
 call void @assert (i32 7, i32 65535, i32 65542)
 call void @assert (i32 7, i32 131071, i32 131078)
 call void @assert (i32 7, i32 262143, i32 262150)
 call void @assert (i32 7, i32 524287, i32 524294)
 call void @assert (i32 7, i32 1048575, i32 1048582)
 call void @assert (i32 7, i32 2097151, i32 2097158)
 call void @assert (i32 7, i32 4194303, i32 4194310)
 call void @assert (i32 7, i32 8388607, i32 8388614)
 call void @assert (i32 7, i32 16777215, i32 16777222)
 call void @assert (i32 7, i32 33554431, i32 33554438)
 call void @assert (i32 7, i32 67108863, i32 67108870)
 call void @assert (i32 7, i32 134217727, i32 134217734)
 call void @assert (i32 7, i32 268435455, i32 268435462)
 call void @assert (i32 7, i32 536870911, i32 536870918)
 call void @assert (i32 7, i32 1073741823, i32 1073741830)
 call void @assert (i32 7, i32 2147483647, i32 2147483654)
 call void @assert (i32 15, i32 15, i32 30)
 call void @assert (i32 15, i32 31, i32 46)
 call void @assert (i32 15, i32 63, i32 78)
 call void @assert (i32 15, i32 127, i32 142)
 call void @assert (i32 15, i32 255, i32 270)
 call void @assert (i32 15, i32 511, i32 526)
 call void @assert (i32 15, i32 1023, i32 1038)
 call void @assert (i32 15, i32 2047, i32 2062)
 call void @assert (i32 15, i32 4095, i32 4110)
 call void @assert (i32 15, i32 8191, i32 8206)
 call void @assert (i32 15, i32 16383, i32 16398)
 call void @assert (i32 15, i32 32767, i32 32782)
 call void @assert (i32 15, i32 65535, i32 65550)
 call void @assert (i32 15, i32 131071, i32 131086)
 call void @assert (i32 15, i32 262143, i32 262158)
 call void @assert (i32 15, i32 524287, i32 524302)
 call void @assert (i32 15, i32 1048575, i32 1048590)
 call void @assert (i32 15, i32 2097151, i32 2097166)
 call void @assert (i32 15, i32 4194303, i32 4194318)
 call void @assert (i32 15, i32 8388607, i32 8388622)
 call void @assert (i32 15, i32 16777215, i32 16777230)
 call void @assert (i32 15, i32 33554431, i32 33554446)
 call void @assert (i32 15, i32 67108863, i32 67108878)
 call void @assert (i32 15, i32 134217727, i32 134217742)
 call void @assert (i32 15, i32 268435455, i32 268435470)
 call void @assert (i32 15, i32 536870911, i32 536870926)
 call void @assert (i32 15, i32 1073741823, i32 1073741838)
 call void @assert (i32 15, i32 2147483647, i32 2147483662)
 call void @assert (i32 31, i32 31, i32 62)
 call void @assert (i32 31, i32 63, i32 94)
 call void @assert (i32 31, i32 127, i32 158)
 call void @assert (i32 31, i32 255, i32 286)
 call void @assert (i32 31, i32 511, i32 542)
 call void @assert (i32 31, i32 1023, i32 1054)
 call void @assert (i32 31, i32 2047, i32 2078)
 call void @assert (i32 31, i32 4095, i32 4126)
 call void @assert (i32 31, i32 8191, i32 8222)
 call void @assert (i32 31, i32 16383, i32 16414)
 call void @assert (i32 31, i32 32767, i32 32798)
 call void @assert (i32 31, i32 65535, i32 65566)
 call void @assert (i32 31, i32 131071, i32 131102)
 call void @assert (i32 31, i32 262143, i32 262174)
 call void @assert (i32 31, i32 524287, i32 524318)
 call void @assert (i32 31, i32 1048575, i32 1048606)
 call void @assert (i32 31, i32 2097151, i32 2097182)
 call void @assert (i32 31, i32 4194303, i32 4194334)
 call void @assert (i32 31, i32 8388607, i32 8388638)
 call void @assert (i32 31, i32 16777215, i32 16777246)
 call void @assert (i32 31, i32 33554431, i32 33554462)
 call void @assert (i32 31, i32 67108863, i32 67108894)
 call void @assert (i32 31, i32 134217727, i32 134217758)
 call void @assert (i32 31, i32 268435455, i32 268435486)
 call void @assert (i32 31, i32 536870911, i32 536870942)
 call void @assert (i32 31, i32 1073741823, i32 1073741854)
 call void @assert (i32 31, i32 2147483647, i32 2147483678)
 call void @assert (i32 63, i32 63, i32 126)
 call void @assert (i32 63, i32 127, i32 190)
 call void @assert (i32 63, i32 255, i32 318)
 call void @assert (i32 63, i32 511, i32 574)
 call void @assert (i32 63, i32 1023, i32 1086)
 call void @assert (i32 63, i32 2047, i32 2110)
 call void @assert (i32 63, i32 4095, i32 4158)
 call void @assert (i32 63, i32 8191, i32 8254)
 call void @assert (i32 63, i32 16383, i32 16446)
 call void @assert (i32 63, i32 32767, i32 32830)
 call void @assert (i32 63, i32 65535, i32 65598)
 call void @assert (i32 63, i32 131071, i32 131134)
 call void @assert (i32 63, i32 262143, i32 262206)
 call void @assert (i32 63, i32 524287, i32 524350)
 call void @assert (i32 63, i32 1048575, i32 1048638)
 call void @assert (i32 63, i32 2097151, i32 2097214)
 call void @assert (i32 63, i32 4194303, i32 4194366)
 call void @assert (i32 63, i32 8388607, i32 8388670)
 call void @assert (i32 63, i32 16777215, i32 16777278)
 call void @assert (i32 63, i32 33554431, i32 33554494)
 call void @assert (i32 63, i32 67108863, i32 67108926)
 call void @assert (i32 63, i32 134217727, i32 134217790)
 call void @assert (i32 63, i32 268435455, i32 268435518)
 call void @assert (i32 63, i32 536870911, i32 536870974)
 call void @assert (i32 63, i32 1073741823, i32 1073741886)
 call void @assert (i32 63, i32 2147483647, i32 2147483710)
 call void @assert (i32 127, i32 127, i32 254)
 call void @assert (i32 127, i32 255, i32 382)
 call void @assert (i32 127, i32 511, i32 638)
 call void @assert (i32 127, i32 1023, i32 1150)
 call void @assert (i32 127, i32 2047, i32 2174)
 call void @assert (i32 127, i32 4095, i32 4222)
 call void @assert (i32 127, i32 8191, i32 8318)
 call void @assert (i32 127, i32 16383, i32 16510)
 call void @assert (i32 127, i32 32767, i32 32894)
 call void @assert (i32 127, i32 65535, i32 65662)
 call void @assert (i32 127, i32 131071, i32 131198)
 call void @assert (i32 127, i32 262143, i32 262270)
 call void @assert (i32 127, i32 524287, i32 524414)
 call void @assert (i32 127, i32 1048575, i32 1048702)
 call void @assert (i32 127, i32 2097151, i32 2097278)
 call void @assert (i32 127, i32 4194303, i32 4194430)
 call void @assert (i32 127, i32 8388607, i32 8388734)
 call void @assert (i32 127, i32 16777215, i32 16777342)
 call void @assert (i32 127, i32 33554431, i32 33554558)
 call void @assert (i32 127, i32 67108863, i32 67108990)
 call void @assert (i32 127, i32 134217727, i32 134217854)
 call void @assert (i32 127, i32 268435455, i32 268435582)
 call void @assert (i32 127, i32 536870911, i32 536871038)
 call void @assert (i32 127, i32 1073741823, i32 1073741950)
 call void @assert (i32 127, i32 2147483647, i32 2147483774)
 call void @assert (i32 255, i32 255, i32 510)
 call void @assert (i32 255, i32 511, i32 766)
 call void @assert (i32 255, i32 1023, i32 1278)
 call void @assert (i32 255, i32 2047, i32 2302)
 call void @assert (i32 255, i32 4095, i32 4350)
 call void @assert (i32 255, i32 8191, i32 8446)
 call void @assert (i32 255, i32 16383, i32 16638)
 call void @assert (i32 255, i32 32767, i32 33022)
 call void @assert (i32 255, i32 65535, i32 65790)
 call void @assert (i32 255, i32 131071, i32 131326)
 call void @assert (i32 255, i32 262143, i32 262398)
 call void @assert (i32 255, i32 524287, i32 524542)
 call void @assert (i32 255, i32 1048575, i32 1048830)
 call void @assert (i32 255, i32 2097151, i32 2097406)
 call void @assert (i32 255, i32 4194303, i32 4194558)
 call void @assert (i32 255, i32 8388607, i32 8388862)
 call void @assert (i32 255, i32 16777215, i32 16777470)
 call void @assert (i32 255, i32 33554431, i32 33554686)
 call void @assert (i32 255, i32 67108863, i32 67109118)
 call void @assert (i32 255, i32 134217727, i32 134217982)
 call void @assert (i32 255, i32 268435455, i32 268435710)
 call void @assert (i32 255, i32 536870911, i32 536871166)
 call void @assert (i32 255, i32 1073741823, i32 1073742078)
 call void @assert (i32 255, i32 2147483647, i32 2147483902)
 call void @assert (i32 511, i32 511, i32 1022)
 call void @assert (i32 511, i32 1023, i32 1534)
 call void @assert (i32 511, i32 2047, i32 2558)
 call void @assert (i32 511, i32 4095, i32 4606)
 call void @assert (i32 511, i32 8191, i32 8702)
 call void @assert (i32 511, i32 16383, i32 16894)
 call void @assert (i32 511, i32 32767, i32 33278)
 call void @assert (i32 511, i32 65535, i32 66046)
 call void @assert (i32 511, i32 131071, i32 131582)
 call void @assert (i32 511, i32 262143, i32 262654)
 call void @assert (i32 511, i32 524287, i32 524798)
 call void @assert (i32 511, i32 1048575, i32 1049086)
 call void @assert (i32 511, i32 2097151, i32 2097662)
 call void @assert (i32 511, i32 4194303, i32 4194814)
 call void @assert (i32 511, i32 8388607, i32 8389118)
 call void @assert (i32 511, i32 16777215, i32 16777726)
 call void @assert (i32 511, i32 33554431, i32 33554942)
 call void @assert (i32 511, i32 67108863, i32 67109374)
 call void @assert (i32 511, i32 134217727, i32 134218238)
 call void @assert (i32 511, i32 268435455, i32 268435966)
 call void @assert (i32 511, i32 536870911, i32 536871422)
 call void @assert (i32 511, i32 1073741823, i32 1073742334)
 call void @assert (i32 511, i32 2147483647, i32 2147484158)
 call void @assert (i32 1023, i32 1023, i32 2046)
 call void @assert (i32 1023, i32 2047, i32 3070)
 call void @assert (i32 1023, i32 4095, i32 5118)
 call void @assert (i32 1023, i32 8191, i32 9214)
 call void @assert (i32 1023, i32 16383, i32 17406)
 call void @assert (i32 1023, i32 32767, i32 33790)
 call void @assert (i32 1023, i32 65535, i32 66558)
 call void @assert (i32 1023, i32 131071, i32 132094)
 call void @assert (i32 1023, i32 262143, i32 263166)
 call void @assert (i32 1023, i32 524287, i32 525310)
 call void @assert (i32 1023, i32 1048575, i32 1049598)
 call void @assert (i32 1023, i32 2097151, i32 2098174)
 call void @assert (i32 1023, i32 4194303, i32 4195326)
 call void @assert (i32 1023, i32 8388607, i32 8389630)
 call void @assert (i32 1023, i32 16777215, i32 16778238)
 call void @assert (i32 1023, i32 33554431, i32 33555454)
 call void @assert (i32 1023, i32 67108863, i32 67109886)
 call void @assert (i32 1023, i32 134217727, i32 134218750)
 call void @assert (i32 1023, i32 268435455, i32 268436478)
 call void @assert (i32 1023, i32 536870911, i32 536871934)
 call void @assert (i32 1023, i32 1073741823, i32 1073742846)
 call void @assert (i32 1023, i32 2147483647, i32 2147484670)
 call void @assert (i32 2047, i32 2047, i32 4094)
 call void @assert (i32 2047, i32 4095, i32 6142)
 call void @assert (i32 2047, i32 8191, i32 10238)
 call void @assert (i32 2047, i32 16383, i32 18430)
 call void @assert (i32 2047, i32 32767, i32 34814)
 call void @assert (i32 2047, i32 65535, i32 67582)
 call void @assert (i32 2047, i32 131071, i32 133118)
 call void @assert (i32 2047, i32 262143, i32 264190)
 call void @assert (i32 2047, i32 524287, i32 526334)
 call void @assert (i32 2047, i32 1048575, i32 1050622)
 call void @assert (i32 2047, i32 2097151, i32 2099198)
 call void @assert (i32 2047, i32 4194303, i32 4196350)
 call void @assert (i32 2047, i32 8388607, i32 8390654)
 call void @assert (i32 2047, i32 16777215, i32 16779262)
 call void @assert (i32 2047, i32 33554431, i32 33556478)
 call void @assert (i32 2047, i32 67108863, i32 67110910)
 call void @assert (i32 2047, i32 134217727, i32 134219774)
 call void @assert (i32 2047, i32 268435455, i32 268437502)
 call void @assert (i32 2047, i32 536870911, i32 536872958)
 call void @assert (i32 2047, i32 1073741823, i32 1073743870)
 call void @assert (i32 2047, i32 2147483647, i32 2147485694)
 call void @assert (i32 4095, i32 4095, i32 8190)
 call void @assert (i32 4095, i32 8191, i32 12286)
 call void @assert (i32 4095, i32 16383, i32 20478)
 call void @assert (i32 4095, i32 32767, i32 36862)
 call void @assert (i32 4095, i32 65535, i32 69630)
 call void @assert (i32 4095, i32 131071, i32 135166)
 call void @assert (i32 4095, i32 262143, i32 266238)
 call void @assert (i32 4095, i32 524287, i32 528382)
 call void @assert (i32 4095, i32 1048575, i32 1052670)
 call void @assert (i32 4095, i32 2097151, i32 2101246)
 call void @assert (i32 4095, i32 4194303, i32 4198398)
 call void @assert (i32 4095, i32 8388607, i32 8392702)
 call void @assert (i32 4095, i32 16777215, i32 16781310)
 call void @assert (i32 4095, i32 33554431, i32 33558526)
 call void @assert (i32 4095, i32 67108863, i32 67112958)
 call void @assert (i32 4095, i32 134217727, i32 134221822)
 call void @assert (i32 4095, i32 268435455, i32 268439550)
 call void @assert (i32 4095, i32 536870911, i32 536875006)
 call void @assert (i32 4095, i32 1073741823, i32 1073745918)
 call void @assert (i32 4095, i32 2147483647, i32 2147487742)
 call void @assert (i32 8191, i32 8191, i32 16382)
 call void @assert (i32 8191, i32 16383, i32 24574)
 call void @assert (i32 8191, i32 32767, i32 40958)
 call void @assert (i32 8191, i32 65535, i32 73726)
 call void @assert (i32 8191, i32 131071, i32 139262)
 call void @assert (i32 8191, i32 262143, i32 270334)
 call void @assert (i32 8191, i32 524287, i32 532478)
 call void @assert (i32 8191, i32 1048575, i32 1056766)
 call void @assert (i32 8191, i32 2097151, i32 2105342)
 call void @assert (i32 8191, i32 4194303, i32 4202494)
 call void @assert (i32 8191, i32 8388607, i32 8396798)
 call void @assert (i32 8191, i32 16777215, i32 16785406)
 call void @assert (i32 8191, i32 33554431, i32 33562622)
 call void @assert (i32 8191, i32 67108863, i32 67117054)
 call void @assert (i32 8191, i32 134217727, i32 134225918)
 call void @assert (i32 8191, i32 268435455, i32 268443646)
 call void @assert (i32 8191, i32 536870911, i32 536879102)
 call void @assert (i32 8191, i32 1073741823, i32 1073750014)
 call void @assert (i32 8191, i32 2147483647, i32 2147491838)
 call void @assert (i32 16383, i32 16383, i32 32766)
 call void @assert (i32 16383, i32 32767, i32 49150)
 call void @assert (i32 16383, i32 65535, i32 81918)
 call void @assert (i32 16383, i32 131071, i32 147454)
 call void @assert (i32 16383, i32 262143, i32 278526)
 call void @assert (i32 16383, i32 524287, i32 540670)
 call void @assert (i32 16383, i32 1048575, i32 1064958)
 call void @assert (i32 16383, i32 2097151, i32 2113534)
 call void @assert (i32 16383, i32 4194303, i32 4210686)
 call void @assert (i32 16383, i32 8388607, i32 8404990)
 call void @assert (i32 16383, i32 16777215, i32 16793598)
 call void @assert (i32 16383, i32 33554431, i32 33570814)
 call void @assert (i32 16383, i32 67108863, i32 67125246)
 call void @assert (i32 16383, i32 134217727, i32 134234110)
 call void @assert (i32 16383, i32 268435455, i32 268451838)
 call void @assert (i32 16383, i32 536870911, i32 536887294)
 call void @assert (i32 16383, i32 1073741823, i32 1073758206)
 call void @assert (i32 16383, i32 2147483647, i32 2147500030)
 call void @assert (i32 32767, i32 32767, i32 65534)
 call void @assert (i32 32767, i32 65535, i32 98302)
 call void @assert (i32 32767, i32 131071, i32 163838)
 call void @assert (i32 32767, i32 262143, i32 294910)
 call void @assert (i32 32767, i32 524287, i32 557054)
 call void @assert (i32 32767, i32 1048575, i32 1081342)
 call void @assert (i32 32767, i32 2097151, i32 2129918)
 call void @assert (i32 32767, i32 4194303, i32 4227070)
 call void @assert (i32 32767, i32 8388607, i32 8421374)
 call void @assert (i32 32767, i32 16777215, i32 16809982)
 call void @assert (i32 32767, i32 33554431, i32 33587198)
 call void @assert (i32 32767, i32 67108863, i32 67141630)
 call void @assert (i32 32767, i32 134217727, i32 134250494)
 call void @assert (i32 32767, i32 268435455, i32 268468222)
 call void @assert (i32 32767, i32 536870911, i32 536903678)
 call void @assert (i32 32767, i32 1073741823, i32 1073774590)
 call void @assert (i32 32767, i32 2147483647, i32 2147516414)
 call void @assert (i32 65535, i32 65535, i32 131070)
 call void @assert (i32 65535, i32 131071, i32 196606)
 call void @assert (i32 65535, i32 262143, i32 327678)
 call void @assert (i32 65535, i32 524287, i32 589822)
 call void @assert (i32 65535, i32 1048575, i32 1114110)
 call void @assert (i32 65535, i32 2097151, i32 2162686)
 call void @assert (i32 65535, i32 4194303, i32 4259838)
 call void @assert (i32 65535, i32 8388607, i32 8454142)
 call void @assert (i32 65535, i32 16777215, i32 16842750)
 call void @assert (i32 65535, i32 33554431, i32 33619966)
 call void @assert (i32 65535, i32 67108863, i32 67174398)
 call void @assert (i32 65535, i32 134217727, i32 134283262)
 call void @assert (i32 65535, i32 268435455, i32 268500990)
 call void @assert (i32 65535, i32 536870911, i32 536936446)
 call void @assert (i32 65535, i32 1073741823, i32 1073807358)
 call void @assert (i32 65535, i32 2147483647, i32 2147549182)
 call void @assert (i32 131071, i32 131071, i32 262142)
 call void @assert (i32 131071, i32 262143, i32 393214)
 call void @assert (i32 131071, i32 524287, i32 655358)
 call void @assert (i32 131071, i32 1048575, i32 1179646)
 call void @assert (i32 131071, i32 2097151, i32 2228222)
 call void @assert (i32 131071, i32 4194303, i32 4325374)
 call void @assert (i32 131071, i32 8388607, i32 8519678)
 call void @assert (i32 131071, i32 16777215, i32 16908286)
 call void @assert (i32 131071, i32 33554431, i32 33685502)
 call void @assert (i32 131071, i32 67108863, i32 67239934)
 call void @assert (i32 131071, i32 134217727, i32 134348798)
 call void @assert (i32 131071, i32 268435455, i32 268566526)
 call void @assert (i32 131071, i32 536870911, i32 537001982)
 call void @assert (i32 131071, i32 1073741823, i32 1073872894)
 call void @assert (i32 131071, i32 2147483647, i32 2147614718)
 call void @assert (i32 262143, i32 262143, i32 524286)
 call void @assert (i32 262143, i32 524287, i32 786430)
 call void @assert (i32 262143, i32 1048575, i32 1310718)
 call void @assert (i32 262143, i32 2097151, i32 2359294)
 call void @assert (i32 262143, i32 4194303, i32 4456446)
 call void @assert (i32 262143, i32 8388607, i32 8650750)
 call void @assert (i32 262143, i32 16777215, i32 17039358)
 call void @assert (i32 262143, i32 33554431, i32 33816574)
 call void @assert (i32 262143, i32 67108863, i32 67371006)
 call void @assert (i32 262143, i32 134217727, i32 134479870)
 call void @assert (i32 262143, i32 268435455, i32 268697598)
 call void @assert (i32 262143, i32 536870911, i32 537133054)
 call void @assert (i32 262143, i32 1073741823, i32 1074003966)
 call void @assert (i32 262143, i32 2147483647, i32 2147745790)
 call void @assert (i32 524287, i32 524287, i32 1048574)
 call void @assert (i32 524287, i32 1048575, i32 1572862)
 call void @assert (i32 524287, i32 2097151, i32 2621438)
 call void @assert (i32 524287, i32 4194303, i32 4718590)
 call void @assert (i32 524287, i32 8388607, i32 8912894)
 call void @assert (i32 524287, i32 16777215, i32 17301502)
 call void @assert (i32 524287, i32 33554431, i32 34078718)
 call void @assert (i32 524287, i32 67108863, i32 67633150)
 call void @assert (i32 524287, i32 134217727, i32 134742014)
 call void @assert (i32 524287, i32 268435455, i32 268959742)
 call void @assert (i32 524287, i32 536870911, i32 537395198)
 call void @assert (i32 524287, i32 1073741823, i32 1074266110)
 call void @assert (i32 524287, i32 2147483647, i32 2148007934)
 call void @assert (i32 1048575, i32 1048575, i32 2097150)
 call void @assert (i32 1048575, i32 2097151, i32 3145726)
 call void @assert (i32 1048575, i32 4194303, i32 5242878)
 call void @assert (i32 1048575, i32 8388607, i32 9437182)
 call void @assert (i32 1048575, i32 16777215, i32 17825790)
 call void @assert (i32 1048575, i32 33554431, i32 34603006)
 call void @assert (i32 1048575, i32 67108863, i32 68157438)
 call void @assert (i32 1048575, i32 134217727, i32 135266302)
 call void @assert (i32 1048575, i32 268435455, i32 269484030)
 call void @assert (i32 1048575, i32 536870911, i32 537919486)
 call void @assert (i32 1048575, i32 1073741823, i32 1074790398)
 call void @assert (i32 1048575, i32 2147483647, i32 2148532222)
 call void @assert (i32 2097151, i32 2097151, i32 4194302)
 call void @assert (i32 2097151, i32 4194303, i32 6291454)
 call void @assert (i32 2097151, i32 8388607, i32 10485758)
 call void @assert (i32 2097151, i32 16777215, i32 18874366)
 call void @assert (i32 2097151, i32 33554431, i32 35651582)
 call void @assert (i32 2097151, i32 67108863, i32 69206014)
 call void @assert (i32 2097151, i32 134217727, i32 136314878)
 call void @assert (i32 2097151, i32 268435455, i32 270532606)
 call void @assert (i32 2097151, i32 536870911, i32 538968062)
 call void @assert (i32 2097151, i32 1073741823, i32 1075838974)
 call void @assert (i32 2097151, i32 2147483647, i32 2149580798)
 call void @assert (i32 4194303, i32 4194303, i32 8388606)
 call void @assert (i32 4194303, i32 8388607, i32 12582910)
 call void @assert (i32 4194303, i32 16777215, i32 20971518)
 call void @assert (i32 4194303, i32 33554431, i32 37748734)
 call void @assert (i32 4194303, i32 67108863, i32 71303166)
 call void @assert (i32 4194303, i32 134217727, i32 138412030)
 call void @assert (i32 4194303, i32 268435455, i32 272629758)
 call void @assert (i32 4194303, i32 536870911, i32 541065214)
 call void @assert (i32 4194303, i32 1073741823, i32 1077936126)
 call void @assert (i32 4194303, i32 2147483647, i32 2151677950)
 call void @assert (i32 8388607, i32 8388607, i32 16777214)
 call void @assert (i32 8388607, i32 16777215, i32 25165822)
 call void @assert (i32 8388607, i32 33554431, i32 41943038)
 call void @assert (i32 8388607, i32 67108863, i32 75497470)
 call void @assert (i32 8388607, i32 134217727, i32 142606334)
 call void @assert (i32 8388607, i32 268435455, i32 276824062)
 call void @assert (i32 8388607, i32 536870911, i32 545259518)
 call void @assert (i32 8388607, i32 1073741823, i32 1082130430)
 call void @assert (i32 8388607, i32 2147483647, i32 2155872254)
 call void @assert (i32 16777215, i32 16777215, i32 33554430)
 call void @assert (i32 16777215, i32 33554431, i32 50331646)
 call void @assert (i32 16777215, i32 67108863, i32 83886078)
 call void @assert (i32 16777215, i32 134217727, i32 150994942)
 call void @assert (i32 16777215, i32 268435455, i32 285212670)
 call void @assert (i32 16777215, i32 536870911, i32 553648126)
 call void @assert (i32 16777215, i32 1073741823, i32 1090519038)
 call void @assert (i32 16777215, i32 2147483647, i32 2164260862)
 call void @assert (i32 33554431, i32 33554431, i32 67108862)
 call void @assert (i32 33554431, i32 67108863, i32 100663294)
 call void @assert (i32 33554431, i32 134217727, i32 167772158)
 call void @assert (i32 33554431, i32 268435455, i32 301989886)
 call void @assert (i32 33554431, i32 536870911, i32 570425342)
 call void @assert (i32 33554431, i32 1073741823, i32 1107296254)
 call void @assert (i32 33554431, i32 2147483647, i32 2181038078)
 call void @assert (i32 67108863, i32 67108863, i32 134217726)
 call void @assert (i32 67108863, i32 134217727, i32 201326590)
 call void @assert (i32 67108863, i32 268435455, i32 335544318)
 call void @assert (i32 67108863, i32 536870911, i32 603979774)
 call void @assert (i32 67108863, i32 1073741823, i32 1140850686)
 call void @assert (i32 67108863, i32 2147483647, i32 2214592510)
 call void @assert (i32 134217727, i32 134217727, i32 268435454)
 call void @assert (i32 134217727, i32 268435455, i32 402653182)
 call void @assert (i32 134217727, i32 536870911, i32 671088638)
 call void @assert (i32 134217727, i32 1073741823, i32 1207959550)
 call void @assert (i32 134217727, i32 2147483647, i32 2281701374)
 call void @assert (i32 268435455, i32 268435455, i32 536870910)
 call void @assert (i32 268435455, i32 536870911, i32 805306366)
 call void @assert (i32 268435455, i32 1073741823, i32 1342177278)
 call void @assert (i32 268435455, i32 2147483647, i32 2415919102)
 call void @assert (i32 536870911, i32 536870911, i32 1073741822)
 call void @assert (i32 536870911, i32 1073741823, i32 1610612734)
 call void @assert (i32 536870911, i32 2147483647, i32 2684354558)
 call void @assert (i32 1073741823, i32 1073741823, i32 2147483646)
 call void @assert (i32 1073741823, i32 2147483647, i32 3221225470)
 call void @assert (i32 2147483647, i32 2147483647, i32 4294967294)
 ret i32 0
}