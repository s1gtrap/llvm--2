@.str = global [6 x i8] c"%08x\0A\00"
@.str.1 = global [9 x i8] c"%016llx\0A\00"

declare i32 @printf(i8*, ...)

define i64 @zz () {
 ret i64 0
}

define i64 @zs () {
 ret i64 65535
}

define i64 @zu () {
 ret i64 32767
}

define i64 @sz () {
 ret i64 4294901760
}

define i64 @ss () {
 ret i64 4294967295
}

define i64 @su () {
 ret i64 4294934527
}

define i64 @uz () {
 ret i64 2147418112
}

define i64 @us () {
 ret i64 2147483647
}

define i64 @uu () {
 ret i64 2147450879
}

define i64 @zzzz () {
 ret i64 0
}

define i64 @zzzs () {
 ret i64 65535
}

define i64 @zzzu () {
 ret i64 32767
}

define i64 @zzsz () {
 ret i64 4294901760
}

define i64 @zzss () {
 ret i64 4294967295
}

define i64 @zzsu () {
 ret i64 4294934527
}

define i64 @zzuz () {
 ret i64 2147418112
}

define i64 @zzus () {
 ret i64 2147483647
}

define i64 @zzuu () {
 ret i64 2147450879
}

define i64 @zszz () {
 ret i64 281470681743360
}

define i64 @zszs () {
 ret i64 281470681808895
}

define i64 @zszu () {
 ret i64 281470681776127
}

define i64 @zssz () {
 ret i64 281474976645120
}

define i64 @zsss () {
 ret i64 281474976710655
}

define i64 @zssu () {
 ret i64 281474976677887
}

define i64 @zsuz () {
 ret i64 281472829161472
}

define i64 @zsus () {
 ret i64 281472829227007
}

define i64 @zsuu () {
 ret i64 281472829194239
}

define i64 @zuzz () {
 ret i64 140733193388032
}

define i64 @zuzs () {
 ret i64 140733193453567
}

define i64 @zuzu () {
 ret i64 140733193420799
}

define i64 @zusz () {
 ret i64 140737488289792
}

define i64 @zuss () {
 ret i64 140737488355327
}

define i64 @zusu () {
 ret i64 140737488322559
}

define i64 @zuuz () {
 ret i64 140735340806144
}

define i64 @zuus () {
 ret i64 140735340871679
}

define i64 @zuuu () {
 ret i64 140735340838911
}

define i64 @szzz () {
 ret i64 -281474976710656
}

define i64 @szzs () {
 ret i64 -281474976645121
}

define i64 @szzu () {
 ret i64 -281474976677889
}

define i64 @szsz () {
 ret i64 -281470681808896
}

define i64 @szss () {
 ret i64 -281470681743361
}

define i64 @szsu () {
 ret i64 -281470681776129
}

define i64 @szuz () {
 ret i64 -281472829292544
}

define i64 @szus () {
 ret i64 -281472829227009
}

define i64 @szuu () {
 ret i64 -281472829259777
}

define i64 @sszz () {
 ret i64 -4294967296
}

define i64 @sszs () {
 ret i64 -4294901761
}

define i64 @sszu () {
 ret i64 -4294934529
}

define i64 @sssz () {
 ret i64 -65536
}

define i64 @ssss () {
 ret i64 -1
}

define i64 @sssu () {
 ret i64 -32769
}

define i64 @ssuz () {
 ret i64 -2147549184
}

define i64 @ssus () {
 ret i64 -2147483649
}

define i64 @ssuu () {
 ret i64 -2147516417
}

define i64 @suzz () {
 ret i64 -140741783322624
}

define i64 @suzs () {
 ret i64 -140741783257089
}

define i64 @suzu () {
 ret i64 -140741783289857
}

define i64 @susz () {
 ret i64 -140737488420864
}

define i64 @suss () {
 ret i64 -140737488355329
}

define i64 @susu () {
 ret i64 -140737488388097
}

define i64 @suuz () {
 ret i64 -140739635904512
}

define i64 @suus () {
 ret i64 -140739635838977
}

define i64 @suuu () {
 ret i64 -140739635871745
}

define i64 @uzzz () {
 ret i64 9223090561878065152
}

define i64 @uzzs () {
 ret i64 9223090561878130687
}

define i64 @uzzu () {
 ret i64 9223090561878097919
}

define i64 @uzsz () {
 ret i64 9223090566172966912
}

define i64 @uzss () {
 ret i64 9223090566173032447
}

define i64 @uzsu () {
 ret i64 9223090566172999679
}

define i64 @uzuz () {
 ret i64 9223090564025483264
}

define i64 @uzus () {
 ret i64 9223090564025548799
}

define i64 @uzuu () {
 ret i64 9223090564025516031
}

define i64 @uszz () {
 ret i64 9223372032559808512
}

define i64 @uszs () {
 ret i64 9223372032559874047
}

define i64 @uszu () {
 ret i64 9223372032559841279
}

define i64 @ussz () {
 ret i64 9223372036854710272
}

define i64 @usss () {
 ret i64 9223372036854775807
}

define i64 @ussu () {
 ret i64 9223372036854743039
}

define i64 @usuz () {
 ret i64 9223372034707226624
}

define i64 @usus () {
 ret i64 9223372034707292159
}

define i64 @usuu () {
 ret i64 9223372034707259391
}

define i64 @uuzz () {
 ret i64 9223231295071453184
}

define i64 @uuzs () {
 ret i64 9223231295071518719
}

define i64 @uuzu () {
 ret i64 9223231295071485951
}

define i64 @uusz () {
 ret i64 9223231299366354944
}

define i64 @uuss () {
 ret i64 9223231299366420479
}

define i64 @uusu () {
 ret i64 9223231299366387711
}

define i64 @uuuz () {
 ret i64 9223231297218871296
}

define i64 @uuus () {
 ret i64 9223231297218936831
}

define i64 @uuuu () {
 ret i64 9223231297218904063
}

define i64 @bit00 () {
 ret i64 1
}

define i64 @bit01 () {
 ret i64 2
}

define i64 @bit02 () {
 ret i64 4
}

define i64 @bit03 () {
 ret i64 8
}

define i64 @bit04 () {
 ret i64 16
}

define i64 @bit05 () {
 ret i64 32
}

define i64 @bit06 () {
 ret i64 64
}

define i64 @bit07 () {
 ret i64 128
}

define i64 @bit08 () {
 ret i64 256
}

define i64 @bit09 () {
 ret i64 512
}

define i64 @bit10 () {
 ret i64 1024
}

define i64 @bit11 () {
 ret i64 2048
}

define i64 @bit12 () {
 ret i64 4096
}

define i64 @bit13 () {
 ret i64 8192
}

define i64 @bit14 () {
 ret i64 16384
}

define i64 @bit15 () {
 ret i64 32768
}

define i64 @bit16 () {
 ret i64 65536
}

define i64 @bit17 () {
 ret i64 131072
}

define i64 @bit18 () {
 ret i64 262144
}

define i64 @bit19 () {
 ret i64 524288
}

define i64 @bit20 () {
 ret i64 1048576
}

define i64 @bit21 () {
 ret i64 2097152
}

define i64 @bit22 () {
 ret i64 4194304
}

define i64 @bit23 () {
 ret i64 8388608
}

define i64 @bit24 () {
 ret i64 16777216
}

define i64 @bit25 () {
 ret i64 33554432
}

define i64 @bit26 () {
 ret i64 67108864
}

define i64 @bit27 () {
 ret i64 134217728
}

define i64 @bit28 () {
 ret i64 268435456
}

define i64 @bit29 () {
 ret i64 536870912
}

define i64 @bit30 () {
 ret i64 1073741824
}

define i64 @bit31 () {
 ret i64 2147483648
}

define i64 @bit32 () {
 ret i64 4294967296
}

define i64 @bit33 () {
 ret i64 8589934592
}

define i64 @bit34 () {
 ret i64 17179869184
}

define i64 @bit35 () {
 ret i64 34359738368
}

define i64 @bit36 () {
 ret i64 68719476736
}

define i64 @bit37 () {
 ret i64 137438953472
}

define i64 @bit38 () {
 ret i64 274877906944
}

define i64 @bit39 () {
 ret i64 549755813888
}

define i64 @bit40 () {
 ret i64 1099511627776
}

define i64 @bit41 () {
 ret i64 2199023255552
}

define i64 @bit42 () {
 ret i64 4398046511104
}

define i64 @bit43 () {
 ret i64 8796093022208
}

define i64 @bit44 () {
 ret i64 17592186044416
}

define i64 @bit45 () {
 ret i64 35184372088832
}

define i64 @bit46 () {
 ret i64 70368744177664
}

define i64 @bit47 () {
 ret i64 140737488355328
}

define i64 @bit48 () {
 ret i64 281474976710656
}

define i64 @bit49 () {
 ret i64 562949953421312
}

define i64 @bit50 () {
 ret i64 1125899906842624
}

define i64 @bit51 () {
 ret i64 2251799813685248
}

define i64 @bit52 () {
 ret i64 4503599627370496
}

define i64 @bit53 () {
 ret i64 9007199254740992
}

define i64 @bit54 () {
 ret i64 18014398509481984
}

define i64 @bit55 () {
 ret i64 36028797018963968
}

define i64 @bit56 () {
 ret i64 72057594037927936
}

define i64 @bit57 () {
 ret i64 144115188075855872
}

define i64 @bit58 () {
 ret i64 288230376151711744
}

define i64 @bit59 () {
 ret i64 576460752303423488
}

define i64 @bit60 () {
 ret i64 1152921504606846976
}

define i64 @bit61 () {
 ret i64 2305843009213693952
}

define i64 @bit62 () {
 ret i64 4611686018427387904
}

define i64 @bit63 () {
 ret i64 -9223372036854775808
}

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 %6 = call i64 @zz ()
 %7 = call i32 (i8*, ...) @printf (i8* @.str, i64 %6)
 %8 = call i64 @zs ()
 %9 = call i32 (i8*, ...) @printf (i8* @.str, i64 %8)
 %10 = call i64 @zu ()
 %11 = call i32 (i8*, ...) @printf (i8* @.str, i64 %10)
 %12 = call i64 @sz ()
 %13 = call i32 (i8*, ...) @printf (i8* @.str, i64 %12)
 %14 = call i64 @ss ()
 %15 = call i32 (i8*, ...) @printf (i8* @.str, i64 %14)
 %16 = call i64 @su ()
 %17 = call i32 (i8*, ...) @printf (i8* @.str, i64 %16)
 %18 = call i64 @uz ()
 %19 = call i32 (i8*, ...) @printf (i8* @.str, i64 %18)
 %20 = call i64 @us ()
 %21 = call i32 (i8*, ...) @printf (i8* @.str, i64 %20)
 %22 = call i64 @uu ()
 %23 = call i32 (i8*, ...) @printf (i8* @.str, i64 %22)
 %24 = call i64 @zzzz ()
 %25 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %24)
 %26 = call i64 @zzzs ()
 %27 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %26)
 %28 = call i64 @zzzu ()
 %29 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %28)
 %30 = call i64 @zzsz ()
 %31 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %30)
 %32 = call i64 @zzss ()
 %33 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %32)
 %34 = call i64 @zzsu ()
 %35 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %34)
 %36 = call i64 @zzuz ()
 %37 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %36)
 %38 = call i64 @zzus ()
 %39 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %38)
 %40 = call i64 @zzuu ()
 %41 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %40)
 %42 = call i64 @zszz ()
 %43 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %42)
 %44 = call i64 @zszs ()
 %45 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %44)
 %46 = call i64 @zszu ()
 %47 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %46)
 %48 = call i64 @zssz ()
 %49 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %48)
 %50 = call i64 @zsss ()
 %51 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %50)
 %52 = call i64 @zssu ()
 %53 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %52)
 %54 = call i64 @zsuz ()
 %55 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %54)
 %56 = call i64 @zsus ()
 %57 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %56)
 %58 = call i64 @zsuu ()
 %59 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %58)
 %60 = call i64 @zuzz ()
 %61 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %60)
 %62 = call i64 @zuzs ()
 %63 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %62)
 %64 = call i64 @zuzu ()
 %65 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %64)
 %66 = call i64 @zusz ()
 %67 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %66)
 %68 = call i64 @zuss ()
 %69 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %68)
 %70 = call i64 @zusu ()
 %71 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %70)
 %72 = call i64 @zuuz ()
 %73 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %72)
 %74 = call i64 @zuus ()
 %75 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %74)
 %76 = call i64 @zuuu ()
 %77 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %76)
 %78 = call i64 @szzz ()
 %79 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %78)
 %80 = call i64 @szzs ()
 %81 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %80)
 %82 = call i64 @szzu ()
 %83 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %82)
 %84 = call i64 @szsz ()
 %85 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %84)
 %86 = call i64 @szss ()
 %87 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %86)
 %88 = call i64 @szsu ()
 %89 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %88)
 %90 = call i64 @szuz ()
 %91 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %90)
 %92 = call i64 @szus ()
 %93 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %92)
 %94 = call i64 @szuu ()
 %95 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %94)
 %96 = call i64 @sszz ()
 %97 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %96)
 %98 = call i64 @sszs ()
 %99 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %98)
 %100 = call i64 @sszu ()
 %101 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %100)
 %102 = call i64 @sssz ()
 %103 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %102)
 %104 = call i64 @ssss ()
 %105 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %104)
 %106 = call i64 @sssu ()
 %107 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %106)
 %108 = call i64 @ssuz ()
 %109 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %108)
 %110 = call i64 @ssus ()
 %111 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %110)
 %112 = call i64 @ssuu ()
 %113 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %112)
 %114 = call i64 @suzz ()
 %115 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %114)
 %116 = call i64 @suzs ()
 %117 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %116)
 %118 = call i64 @suzu ()
 %119 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %118)
 %120 = call i64 @susz ()
 %121 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %120)
 %122 = call i64 @suss ()
 %123 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %122)
 %124 = call i64 @susu ()
 %125 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %124)
 %126 = call i64 @suuz ()
 %127 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %126)
 %128 = call i64 @suus ()
 %129 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %128)
 %130 = call i64 @suuu ()
 %131 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %130)
 %132 = call i64 @uzzz ()
 %133 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %132)
 %134 = call i64 @uzzs ()
 %135 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %134)
 %136 = call i64 @uzzu ()
 %137 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %136)
 %138 = call i64 @uzsz ()
 %139 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %138)
 %140 = call i64 @uzss ()
 %141 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %140)
 %142 = call i64 @uzsu ()
 %143 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %142)
 %144 = call i64 @uzuz ()
 %145 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %144)
 %146 = call i64 @uzus ()
 %147 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %146)
 %148 = call i64 @uzuu ()
 %149 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %148)
 %150 = call i64 @uszz ()
 %151 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %150)
 %152 = call i64 @uszs ()
 %153 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %152)
 %154 = call i64 @uszu ()
 %155 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %154)
 %156 = call i64 @ussz ()
 %157 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %156)
 %158 = call i64 @usss ()
 %159 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %158)
 %160 = call i64 @ussu ()
 %161 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %160)
 %162 = call i64 @usuz ()
 %163 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %162)
 %164 = call i64 @usus ()
 %165 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %164)
 %166 = call i64 @usuu ()
 %167 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %166)
 %168 = call i64 @uuzz ()
 %169 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %168)
 %170 = call i64 @uuzs ()
 %171 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %170)
 %172 = call i64 @uuzu ()
 %173 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %172)
 %174 = call i64 @uusz ()
 %175 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %174)
 %176 = call i64 @uuss ()
 %177 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %176)
 %178 = call i64 @uusu ()
 %179 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %178)
 %180 = call i64 @uuuz ()
 %181 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %180)
 %182 = call i64 @uuus ()
 %183 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %182)
 %184 = call i64 @uuuu ()
 %185 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %184)
 %186 = call i64 @bit00 ()
 %187 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %186)
 %188 = call i64 @bit01 ()
 %189 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %188)
 %190 = call i64 @bit02 ()
 %191 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %190)
 %192 = call i64 @bit03 ()
 %193 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %192)
 %194 = call i64 @bit04 ()
 %195 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %194)
 %196 = call i64 @bit05 ()
 %197 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %196)
 %198 = call i64 @bit06 ()
 %199 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %198)
 %200 = call i64 @bit07 ()
 %201 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %200)
 %202 = call i64 @bit08 ()
 %203 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %202)
 %204 = call i64 @bit09 ()
 %205 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %204)
 %206 = call i64 @bit10 ()
 %207 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %206)
 %208 = call i64 @bit11 ()
 %209 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %208)
 %210 = call i64 @bit12 ()
 %211 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %210)
 %212 = call i64 @bit13 ()
 %213 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %212)
 %214 = call i64 @bit14 ()
 %215 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %214)
 %216 = call i64 @bit15 ()
 %217 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %216)
 %218 = call i64 @bit16 ()
 %219 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %218)
 %220 = call i64 @bit17 ()
 %221 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %220)
 %222 = call i64 @bit18 ()
 %223 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %222)
 %224 = call i64 @bit19 ()
 %225 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %224)
 %226 = call i64 @bit20 ()
 %227 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %226)
 %228 = call i64 @bit21 ()
 %229 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %228)
 %230 = call i64 @bit22 ()
 %231 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %230)
 %232 = call i64 @bit23 ()
 %233 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %232)
 %234 = call i64 @bit24 ()
 %235 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %234)
 %236 = call i64 @bit25 ()
 %237 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %236)
 %238 = call i64 @bit26 ()
 %239 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %238)
 %240 = call i64 @bit27 ()
 %241 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %240)
 %242 = call i64 @bit28 ()
 %243 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %242)
 %244 = call i64 @bit29 ()
 %245 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %244)
 %246 = call i64 @bit30 ()
 %247 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %246)
 %248 = call i64 @bit31 ()
 %249 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %248)
 %250 = call i64 @bit32 ()
 %251 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %250)
 %252 = call i64 @bit33 ()
 %253 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %252)
 %254 = call i64 @bit34 ()
 %255 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %254)
 %256 = call i64 @bit35 ()
 %257 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %256)
 %258 = call i64 @bit36 ()
 %259 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %258)
 %260 = call i64 @bit37 ()
 %261 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %260)
 %262 = call i64 @bit38 ()
 %263 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %262)
 %264 = call i64 @bit39 ()
 %265 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %264)
 %266 = call i64 @bit40 ()
 %267 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %266)
 %268 = call i64 @bit41 ()
 %269 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %268)
 %270 = call i64 @bit42 ()
 %271 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %270)
 %272 = call i64 @bit43 ()
 %273 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %272)
 %274 = call i64 @bit44 ()
 %275 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %274)
 %276 = call i64 @bit45 ()
 %277 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %276)
 %278 = call i64 @bit46 ()
 %279 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %278)
 %280 = call i64 @bit47 ()
 %281 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %280)
 %282 = call i64 @bit48 ()
 %283 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %282)
 %284 = call i64 @bit49 ()
 %285 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %284)
 %286 = call i64 @bit50 ()
 %287 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %286)
 %288 = call i64 @bit51 ()
 %289 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %288)
 %290 = call i64 @bit52 ()
 %291 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %290)
 %292 = call i64 @bit53 ()
 %293 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %292)
 %294 = call i64 @bit54 ()
 %295 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %294)
 %296 = call i64 @bit55 ()
 %297 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %296)
 %298 = call i64 @bit56 ()
 %299 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %298)
 %300 = call i64 @bit57 ()
 %301 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %300)
 %302 = call i64 @bit58 ()
 %303 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %302)
 %304 = call i64 @bit59 ()
 %305 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %304)
 %306 = call i64 @bit60 ()
 %307 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %306)
 %308 = call i64 @bit61 ()
 %309 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %308)
 %310 = call i64 @bit62 ()
 %311 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %310)
 %312 = call i64 @bit63 ()
 %313 = call i32 (i8*, ...) @printf (i8* @.str.1, i64 %312)
 ret i32 0
}
