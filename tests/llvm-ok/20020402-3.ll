%struct.symtab = type { i8* }
%struct.blockvector = type { i32, [2 x i8*] }
%struct.block = type { i64, i64, i8*, i8*, i8, i32, [1 x %struct.symbol] }
%struct.symbol = type { i32, i8* }

declare void @llvm.memset.p0.i64(i8*, i8, i64, i1)

define i8* @blockvector_for_pc_sect (i64 %0, i8* %1) {
 %3 = alloca i8*
 %4 = alloca i64
 %5 = alloca i8*
 %6 = alloca i8*
 %7 = alloca i32
 %8 = alloca i32
 %9 = alloca i32
 %10 = alloca i8*
 store i64 %0, i64* %4
 store i8* %1, i8** %5
 %11 = load i8*, i8** %5
 %12 = getelementptr %struct.symtab, i8* %11, i32 0, i32 0
 %13 = load i8*, i8** %12
 store i8* %13, i8** %10
 %14 = load i8*, i8** %10
 %15 = getelementptr %struct.blockvector, i8* %14, i32 0, i32 1
 %16 = getelementptr [2 x i8*], i8* %15, i64 0, i64 0
 %17 = load i8*, i8** %16
 store i8* %17, i8** %6
 store i32 0, i32* %7
 %18 = load i8*, i8** %10
 %19 = getelementptr %struct.blockvector, i8* %18, i32 0, i32 0
 %20 = load i32, i32* %19
 store i32 %20, i32* %8
 br label %21
21:
 %22 = load i32, i32* %8
 %23 = load i32, i32* %7
 %24 = sub i32 %22, %23
 %25 = icmp sgt i32 %24, 1
 br i1 %25, label %26, label %54
26:
 %27 = load i32, i32* %8
 %28 = load i32, i32* %7
 %29 = sub i32 %27, %28
 %30 = add i32 %29, 1
 %31 = ashr i32 %30, 1
 store i32 %31, i32* %9
 %32 = load i8*, i8** %10
 %33 = getelementptr %struct.blockvector, i8* %32, i32 0, i32 1
 %34 = load i32, i32* %7
 %35 = load i32, i32* %9
 %36 = add i32 %34, %35
 %37 = sext i32 %36 to i64
 %38 = getelementptr [2 x i8*], i8* %33, i64 0, i64 %37
 %39 = load i8*, i8** %38
 store i8* %39, i8** %6
 %40 = load i8*, i8** %6
 %41 = getelementptr %struct.block, i8* %40, i32 0, i32 0
 %42 = load i64, i64* %41
 %43 = load i64, i64* %4
 %44 = icmp ule i64 %42, %43
 br i1 %44, label %45, label %49
45:
 %46 = load i32, i32* %9
 %47 = load i32, i32* %7
 %48 = add i32 %47, %46
 store i32 %48, i32* %7
 br label %53
49:
 %50 = load i32, i32* %7
 %51 = load i32, i32* %9
 %52 = add i32 %50, %51
 store i32 %52, i32* %8
 br label %53
53:
 br label %21
54:
 br label %55
55:
 %56 = load i32, i32* %7
 %57 = icmp sge i32 %56, 0
 br i1 %57, label %58, label %75
58:
 %59 = load i8*, i8** %10
 %60 = getelementptr %struct.blockvector, i8* %59, i32 0, i32 1
 %61 = load i32, i32* %7
 %62 = sext i32 %61 to i64
 %63 = getelementptr [2 x i8*], i8* %60, i64 0, i64 %62
 %64 = load i8*, i8** %63
 store i8* %64, i8** %6
 %65 = load i8*, i8** %6
 %66 = getelementptr %struct.block, i8* %65, i32 0, i32 1
 %67 = load i64, i64* %66
 %68 = load i64, i64* %4
 %69 = icmp ugt i64 %67, %68
 br i1 %69, label %70, label %72
70:
 %71 = load i8*, i8** %10
 store i8* %71, i8** %3
 br label %76
72:
 %73 = load i32, i32* %7
 %74 = add i32 %73, -1
 store i32 %74, i32* %7
 br label %55
75:
 store i8* null, i8** %3
 br label %76
76:
 %77 = load i8*, i8** %3
 ret i8* %77
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca %struct.block
 %3 = alloca %struct.block
 %4 = alloca %struct.blockvector
 %5 = alloca %struct.symtab
 %6 = alloca i8*
 store i32 0, i32* %1
 call void @memset (i8* %2, i8 0, i64 56, i1 0)
 %7 = getelementptr %struct.block, i8* %2, i32 0, i32 1
 store i64 65536, i64* %7
 %8 = getelementptr %struct.block, i8* %2, i32 0, i32 4
 store i8 1, i8* %8
 %9 = getelementptr %struct.block, i8* %2, i32 0, i32 5
 store i32 20, i32* %9
 call void @memset (i8* %3, i8 0, i64 56, i1 0)
 %10 = getelementptr %struct.block, i8* %3, i32 0, i32 0
 store i64 65536, i64* %10
 %11 = getelementptr %struct.block, i8* %3, i32 0, i32 1
 store i64 131072, i64* %11
 %12 = getelementptr %struct.block, i8* %3, i32 0, i32 4
 store i8 1, i8* %12
 %13 = getelementptr %struct.block, i8* %3, i32 0, i32 5
 store i32 20, i32* %13
 %14 = getelementptr %struct.blockvector, i8* %4, i32 0, i32 0
 store i32 2, i32* %14
 %15 = getelementptr %struct.blockvector, i8* %4, i32 0, i32 1
 %16 = getelementptr [2 x i8*], i8* %15, i64 0, i64 0
 store i8* %2, i8** %16
 %17 = getelementptr i8*, i8* %16, i64 1
 store i8* %3, i8** %17
 %18 = getelementptr %struct.symtab, i8* %5, i32 0, i32 0
 store i8* %4, i8** %18
 %19 = call i8* @blockvector_for_pc_sect (i64 1280, i8* %5)
 store i8* %19, i8** %6
 ret i32 0
}
