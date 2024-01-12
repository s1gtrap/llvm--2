%struct.Pcc_cell = type { i8*, i64, i64 }
%struct.PMC = type { i32 }

declare void @abort()

define void @Parrot_gc_mark_PMC_alive_fun (i8* %0, i8* %1) {
 %3 = alloca i8*
 %4 = alloca i8*
 store i8* %0, i8** %3
 store i8* %1, i8** %4
 call void @abort ()
 unreachable
}

define void @foo (i8* %0, i8* %1) {
 %3 = alloca i8*
 %4 = alloca i8*
 store i8* %0, i8** %3
 store i8* %1, i8** %4
 %5 = load i8*, i8** %3
 %6 = load i8*, i8** %4
 call void @mark_cell (i8* %5, i8* %6)
 ret void
}

define void @mark_cell (i8* %0, i8* %1) {
 %3 = alloca i8*
 %4 = alloca i8*
 store i8* %0, i8** %3
 store i8* %1, i8** %4
 %5 = load i8*, i8** %4
 %6 = getelementptr %struct.Pcc_cell, i8* %5, i32 0, i32 2
 %7 = load i64, i64* %6
 %8 = icmp eq i64 %7, 4
 br i1 %8, label %9, label %27
9:
 %10 = load i8*, i8** %4
 %11 = getelementptr %struct.Pcc_cell, i8* %10, i32 0, i32 0
 %12 = load i8*, i8** %11
 %13 = icmp ne i8* %12, null
 br i1 %13, label %14, label %27
14:
 %15 = load i8*, i8** %4
 %16 = getelementptr %struct.Pcc_cell, i8* %15, i32 0, i32 0
 %17 = load i8*, i8** %16
 %18 = getelementptr %struct.PMC, i8* %17, i32 0, i32 0
 %19 = load i32, i32* %18
 %20 = and i32 %19, 262144
 %21 = icmp ne i32 %20, 0
 br i1 %21, label %27, label %22
22:
 %23 = load i8*, i8** %3
 %24 = load i8*, i8** %4
 %25 = getelementptr %struct.Pcc_cell, i8* %24, i32 0, i32 0
 %26 = load i8*, i8** %25
 call void @Parrot_gc_mark_PMC_alive_fun (i8* %23, i8* %26)
 br label %27
27:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 %3 = alloca %struct.Pcc_cell
 store i32 0, i32* %1
 %4 = getelementptr %struct.Pcc_cell, i8* %3, i32 0, i32 0
 store i8* null, i8** %4
 %5 = getelementptr %struct.Pcc_cell, i8* %3, i32 0, i32 1
 store i64 42, i64* %5
 %6 = getelementptr %struct.Pcc_cell, i8* %3, i32 0, i32 2
 store i64 4, i64* %6
 call void @foo (i8* %2, i8* %3)
 ret i32 0
}
