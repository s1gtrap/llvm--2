@a = global i64 568513516876543756
@b = global i64 -754324895235774564
@c = global i64 156789543257562457
@expected_a = global [64 x i64] [i64 568513516876543756, i64 1137027033753087512, i64 2274054067506175024, i64 4548108135012350048, i64 9096216270024700096, i64 -254311533660151424, i64 -508623067320302848, i64 -1017246134640605696, i64 -2034492269281211392, i64 -4068984538562422784, i64 -8137969077124845568, i64 2170805919459860480, i64 4341611838919720960, i64 8683223677839441920, i64 -1080296718030667776, i64 -2160593436061335552, i64 -4321186872122671104, i64 -8642373744245342208, i64 1161996585218867200, i64 2323993170437734400, i64 4647986340875468800, i64 -9150771391958614016, i64 145201289792323584, i64 290402579584647168, i64 580805159169294336, i64 1161610318338588672, i64 2323220636677177344, i64 4646441273354354688, i64 -9153861527000842240, i64 139021019707867136, i64 278042039415734272, i64 556084078831468544, i64 1112168157662937088, i64 2224336315325874176, i64 4448672630651748352, i64 8897345261303496704, i64 -652053551102558208, i64 -1304107102205116416, i64 -2608214204410232832, i64 -5216428408820465664, i64 8013887256068620288, i64 -2418969561572311040, i64 -4837939123144622080, i64 8770865827420307456, i64 -905012418868936704, i64 -1810024837737873408, i64 -3620049675475746816, i64 -7240099350951493632, i64 3966545371806564352, i64 7933090743613128704, i64 -2580562586483294208, i64 -5161125172966588416, i64 8124493727776374784, i64 -2197756618156802048, i64 -4395513236313604096, i64 -8791026472627208192, i64 864691128455135232, i64 1729382256910270464, i64 3458764513820540928, i64 6917529027641081856, i64 -4611686018427387904, i64 -9223372036854775808, i64 0, i64 0]
@expected_b = global [64 x i64] [i64 -754324895235774564, i64 -377162447617887282, i64 -188581223808943641, i64 -94290611904471821, i64 -47145305952235911, i64 -23572652976117956, i64 -11786326488058978, i64 -5893163244029489, i64 -2946581622014745, i64 -1473290811007373, i64 -736645405503687, i64 -368322702751844, i64 -184161351375922, i64 -92080675687961, i64 -46040337843981, i64 -23020168921991, i64 -11510084460996, i64 -5755042230498, i64 -2877521115249, i64 -1438760557625, i64 -719380278813, i64 -359690139407, i64 -179845069704, i64 -89922534852, i64 -44961267426, i64 -22480633713, i64 -11240316857, i64 -5620158429, i64 -2810079215, i64 -1405039608, i64 -702519804, i64 -351259902, i64 -175629951, i64 -87814976, i64 -43907488, i64 -21953744, i64 -10976872, i64 -5488436, i64 -2744218, i64 -1372109, i64 -686055, i64 -343028, i64 -171514, i64 -85757, i64 -42879, i64 -21440, i64 -10720, i64 -5360, i64 -2680, i64 -1340, i64 -670, i64 -335, i64 -168, i64 -84, i64 -42, i64 -21, i64 -11, i64 -6, i64 -3, i64 -2, i64 -1, i64 -1, i64 -1, i64 -1]
@expected_c = global [64 x i64] [i64 156789543257562457, i64 78394771628781228, i64 39197385814390614, i64 19598692907195307, i64 9799346453597653, i64 4899673226798826, i64 2449836613399413, i64 1224918306699706, i64 612459153349853, i64 306229576674926, i64 153114788337463, i64 76557394168731, i64 38278697084365, i64 19139348542182, i64 9569674271091, i64 4784837135545, i64 2392418567772, i64 1196209283886, i64 598104641943, i64 299052320971, i64 149526160485, i64 74763080242, i64 37381540121, i64 18690770060, i64 9345385030, i64 4672692515, i64 2336346257, i64 1168173128, i64 584086564, i64 292043282, i64 146021641, i64 73010820, i64 36505410, i64 18252705, i64 9126352, i64 4563176, i64 2281588, i64 1140794, i64 570397, i64 285198, i64 142599, i64 71299, i64 35649, i64 17824, i64 8912, i64 4456, i64 2228, i64 1114, i64 557, i64 278, i64 139, i64 69, i64 34, i64 17, i64 8, i64 4, i64 2, i64 1, i64 0, i64 0, i64 0, i64 0, i64 0, i64 0]

declare void @abort()

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 store i32 0, i32* %1
 store i32 0, i32* %2
 br label %3
3:
 %4 = load i32, i32* %2
 %5 = icmp slt i32 %4, 64
 br i1 %5, label %6, label %41
6:
 %7 = load i64, i64* @a
 %8 = load i32, i32* %2
 %9 = zext i32 %8 to i64
 %10 = shl i64 %7, %9
 %11 = load i32, i32* %2
 %12 = sext i32 %11 to i64
 %13 = getelementptr [64 x i64], i8* @expected_a, i64 0, i64 %12
 %14 = load i64, i64* %13
 %15 = icmp ne i64 %10, %14
 br i1 %15, label %36, label %16
16:
 %17 = load i64, i64* @b
 %18 = load i32, i32* %2
 %19 = zext i32 %18 to i64
 %20 = ashr i64 %17, %19
 %21 = load i32, i32* %2
 %22 = sext i32 %21 to i64
 %23 = getelementptr [64 x i64], i8* @expected_b, i64 0, i64 %22
 %24 = load i64, i64* %23
 %25 = icmp ne i64 %20, %24
 br i1 %25, label %36, label %26
26:
 %27 = load i64, i64* @c
 %28 = load i32, i32* %2
 %29 = zext i32 %28 to i64
 %30 = lshr i64 %27, %29
 %31 = load i32, i32* %2
 %32 = sext i32 %31 to i64
 %33 = getelementptr [64 x i64], i8* @expected_c, i64 0, i64 %32
 %34 = load i64, i64* %33
 %35 = icmp ne i64 %30, %34
 br i1 %35, label %36, label %37
36:
 call void @abort ()
 unreachable
37:
 br label %38
38:
 %39 = load i32, i32* %2
 %40 = add i32 %39, 1
 store i32 %40, i32* %2
 br label %3
41:
 ret i32 0
}