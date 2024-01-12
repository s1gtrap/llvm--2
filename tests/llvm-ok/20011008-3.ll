%struct.__db_lsn = type { i32, i32 }
%struct.__db_txnlist = type { i32, %struct.anon, %union.anon }
%struct.anon = type { i8*, i8* }
%union.anon = type { %struct.anon.3 }
%struct.anon.3 = type { i32, i32, i8*, i32, i8*, [20 x i8] }
%struct.anon.2 = type { i32, i32, i8* }

declare void @llvm.memcpy.p0.p0.i64(i8*, i8*, i64, i1)
declare void @abort()
declare void @exit(i32)

define i32 @log_compare (i8* %0, i8* %1) {
 %3 = alloca i8*
 %4 = alloca i8*
 store i8* %0, i8** %3
 store i8* %1, i8** %4
 ret i32 1
}

define i32 @__db_txnlist_lsnadd (i32 %0, i8* %1, i8* %2, i32 %3) {
 %5 = alloca i32
 %6 = alloca i8*
 %7 = alloca i8*
 %8 = alloca i32
 %9 = alloca i32
 %10 = alloca i32
 %11 = alloca %struct.__db_lsn
 store i32 %0, i32* %5
 store i8* %1, i8** %6
 store i8* %2, i8** %7
 store i32 %3, i32* %8
 store i32 0, i32* %9
 br label %12
12:
 %13 = load i32, i32* %9
 %14 = load i32, i32* %8
 %15 = and i32 %14, 1
 %16 = icmp ne i32 %15, 0
 br i1 %16, label %18, label %17
17:
 br label %23
18:
 %19 = load i8*, i8** %6
 %20 = getelementptr %struct.__db_txnlist, i8* %19, i32 0, i32 2
 %21 = getelementptr %struct.anon.2, i8* %20, i32 0, i32 0
 %22 = load i32, i32* %21
 br label %23
23:
 %24 = phi i32 [1, %17], [%22, %18]
 %25 = icmp slt i32 %13, %24
 br i1 %25, label %26, label %94
26:
 %27 = load i32, i32* %5
 %28 = add i32 %27, 1
 store i32 %28, i32* %5
 store i32 0, i32* %10
 br label %29
29:
 %30 = load i32, i32* %10
 %31 = load i8*, i8** %6
 %32 = getelementptr %struct.__db_txnlist, i8* %31, i32 0, i32 2
 %33 = getelementptr %struct.anon.2, i8* %32, i32 0, i32 0
 %34 = load i32, i32* %33
 %35 = sub i32 %34, 1
 %36 = icmp slt i32 %30, %35
 br i1 %36, label %37, label %90
37:
 %38 = load i8*, i8** %6
 %39 = getelementptr %struct.__db_txnlist, i8* %38, i32 0, i32 2
 %40 = getelementptr %struct.anon.2, i8* %39, i32 0, i32 2
 %41 = load i8*, i8** %40
 %42 = load i32, i32* %10
 %43 = sext i32 %42 to i64
 %44 = getelementptr %struct.__db_lsn, i8* %41, i64 %43
 %45 = load i8*, i8** %6
 %46 = getelementptr %struct.__db_txnlist, i8* %45, i32 0, i32 2
 %47 = getelementptr %struct.anon.2, i8* %46, i32 0, i32 2
 %48 = load i8*, i8** %47
 %49 = load i32, i32* %10
 %50 = add i32 %49, 1
 %51 = sext i32 %50 to i64
 %52 = getelementptr %struct.__db_lsn, i8* %48, i64 %51
 %53 = call i32 @log_compare (i8* %44, i8* %52)
 %54 = icmp slt i32 %53, 0
 br i1 %54, label %55, label %86
55:
 %56 = load i8*, i8** %6
 %57 = getelementptr %struct.__db_txnlist, i8* %56, i32 0, i32 2
 %58 = getelementptr %struct.anon.2, i8* %57, i32 0, i32 2
 %59 = load i8*, i8** %58
 %60 = load i32, i32* %10
 %61 = sext i32 %60 to i64
 %62 = getelementptr %struct.__db_lsn, i8* %59, i64 %61
 call void @memcpy (i8* %11, i8* %62, i64 8, i1 0)
 %63 = load i8*, i8** %6
 %64 = getelementptr %struct.__db_txnlist, i8* %63, i32 0, i32 2
 %65 = getelementptr %struct.anon.2, i8* %64, i32 0, i32 2
 %66 = load i8*, i8** %65
 %67 = load i32, i32* %10
 %68 = sext i32 %67 to i64
 %69 = getelementptr %struct.__db_lsn, i8* %66, i64 %68
 %70 = load i8*, i8** %6
 %71 = getelementptr %struct.__db_txnlist, i8* %70, i32 0, i32 2
 %72 = getelementptr %struct.anon.2, i8* %71, i32 0, i32 2
 %73 = load i8*, i8** %72
 %74 = load i32, i32* %10
 %75 = add i32 %74, 1
 %76 = sext i32 %75 to i64
 %77 = getelementptr %struct.__db_lsn, i8* %73, i64 %76
 call void @memcpy (i8* %69, i8* %77, i64 8, i1 0)
 %78 = load i8*, i8** %6
 %79 = getelementptr %struct.__db_txnlist, i8* %78, i32 0, i32 2
 %80 = getelementptr %struct.anon.2, i8* %79, i32 0, i32 2
 %81 = load i8*, i8** %80
 %82 = load i32, i32* %10
 %83 = add i32 %82, 1
 %84 = sext i32 %83 to i64
 %85 = getelementptr %struct.__db_lsn, i8* %81, i64 %84
 call void @memcpy (i8* %85, i8* %11, i64 8, i1 0)
 br label %86
86:
 br label %87
87:
 %88 = load i32, i32* %10
 %89 = add i32 %88, 1
 store i32 %89, i32* %10
 br label %29
90:
 br label %91
91:
 %92 = load i32, i32* %9
 %93 = add i32 %92, 1
 store i32 %93, i32* %9
 br label %12
94:
 %95 = load i8*, i8** %7
 %96 = load i8*, i8** %6
 %97 = getelementptr %struct.__db_txnlist, i8* %96, i32 0, i32 2
 %98 = getelementptr %struct.anon.2, i8* %97, i32 0, i32 2
 %99 = load i8*, i8** %98
 %100 = getelementptr %struct.__db_lsn, i8* %99, i64 0
 call void @memcpy (i8* %95, i8* %100, i64 8, i1 0)
 %101 = load i32, i32* %5
 ret i32 %101
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca %struct.__db_txnlist
 %3 = alloca %struct.__db_lsn
 %4 = alloca [1235 x %struct.__db_lsn]
 store i32 0, i32* %1
 %5 = getelementptr %struct.__db_txnlist, i8* %2, i32 0, i32 2
 %6 = getelementptr %struct.anon.2, i8* %5, i32 0, i32 0
 store i32 1234, i32* %6
 %7 = getelementptr [1235 x %struct.__db_lsn], i8* %4, i64 0, i64 0
 %8 = getelementptr %struct.__db_txnlist, i8* %2, i32 0, i32 2
 %9 = getelementptr %struct.anon.2, i8* %8, i32 0, i32 2
 store i8* %7, i8** %9
 %10 = call i32 @__db_txnlist_lsnadd (i32 0, i8* %2, i8* %3, i32 0)
 %11 = icmp ne i32 %10, 1
 br i1 %11, label %12, label %13
12:
 call void @abort ()
 unreachable
13:
 %14 = call i32 @__db_txnlist_lsnadd (i32 0, i8* %2, i8* %3, i32 1)
 %15 = icmp ne i32 %14, 1234
 br i1 %15, label %16, label %17
16:
 call void @abort ()
 unreachable
17:
 call void @exit (i32 0)
 unreachable
}
