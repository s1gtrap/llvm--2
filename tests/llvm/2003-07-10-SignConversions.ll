@.str = global [39 x i8] c"%d %d --> unsigned: us = %d, us2 = %d\0A\00"
@.str.1 = global [39 x i8] c"%d %d -->   signed:  s = %d,  s2 = %d\0A\00"
@.str.2 = global [39 x i8] c"%d %d --> unsigned: uc = %d, uc2 = %d\0A\00"
@.str.3 = global [39 x i8] c"%d %d -->   signed: sc = %d, sc2 = %d\0A\00"

declare i32 @printf(i8*, ...)

define i8 @getUC () {
 ret i8 -128
}

define i8 @getSC () {
 ret i8 -128
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i8
 %3 = alloca i8
 %4 = alloca i16
 %5 = alloca i16
 %6 = alloca i16
 %7 = alloca i16
 %8 = alloca i8
 %9 = alloca i8
 %10 = alloca i8
 %11 = alloca i8
 store i32 0, i32* %1
 %12 = call i8 @getSC ()
 store i8 %12, i8* %2
 %13 = call i8 @getUC ()
 store i8 %13, i8* %3
 %14 = load i8, i8* %2
 %15 = sext i8 %14 to i16
 store i16 %15, i16* %4
 %16 = load i8, i8* %3
 %17 = zext i8 %16 to i16
 store i16 %17, i16* %5
 %18 = load i8, i8* %2
 %19 = sext i8 %18 to i16
 store i16 %19, i16* %6
 %20 = load i8, i8* %3
 %21 = zext i8 %20 to i16
 store i16 %21, i16* %7
 %22 = load i8, i8* %2
 %23 = sext i8 %22 to i32
 %24 = load i8, i8* %3
 %25 = zext i8 %24 to i32
 %26 = load i16, i16* %4
 %27 = zext i16 %26 to i32
 %28 = load i16, i16* %5
 %29 = zext i16 %28 to i32
 %30 = call i32 (i8*, ...) @printf (i8* @.str, i32 %23, i32 %25, i32 %27, i32 %29)
 %31 = load i8, i8* %2
 %32 = sext i8 %31 to i32
 %33 = load i8, i8* %3
 %34 = zext i8 %33 to i32
 %35 = load i16, i16* %6
 %36 = sext i16 %35 to i32
 %37 = load i16, i16* %7
 %38 = sext i16 %37 to i32
 %39 = call i32 (i8*, ...) @printf (i8* @.str.1, i32 %32, i32 %34, i32 %36, i32 %38)
 %40 = load i8, i8* %2
 store i8 %40, i8* %8
 %41 = load i8, i8* %3
 store i8 %41, i8* %9
 %42 = load i8, i8* %2
 store i8 %42, i8* %10
 %43 = load i8, i8* %3
 store i8 %43, i8* %11
 %44 = load i8, i8* %2
 %45 = sext i8 %44 to i32
 %46 = load i8, i8* %3
 %47 = zext i8 %46 to i32
 %48 = load i8, i8* %8
 %49 = zext i8 %48 to i32
 %50 = load i8, i8* %9
 %51 = zext i8 %50 to i32
 %52 = call i32 (i8*, ...) @printf (i8* @.str.2, i32 %45, i32 %47, i32 %49, i32 %51)
 %53 = load i8, i8* %2
 %54 = sext i8 %53 to i32
 %55 = load i8, i8* %3
 %56 = zext i8 %55 to i32
 %57 = load i8, i8* %10
 %58 = sext i8 %57 to i32
 %59 = load i8, i8* %11
 %60 = sext i8 %59 to i32
 %61 = call i32 (i8*, ...) @printf (i8* @.str.3, i32 %54, i32 %56, i32 %58, i32 %60)
 ret i32 0
}
