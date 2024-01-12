declare void @abort()

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i8*
 store i32 0, i32* %1
 %3 = call i8* @build_ref_for_offset (i8* null, i64 32)
 store i8* %3, i8** %2
 %4 = load i8*, i8** %2
 %5 = icmp ne i8* %4, null
 br i1 %5, label %6, label %7
6:
 call void @abort ()
 unreachable
7:
 ret i32 0
}

define i8* @build_ref_for_offset (i8* %0, i64 %1) {
 %3 = alloca i8*
 %4 = alloca i64
 %5 = alloca i64
 store i8* %0, i8** %3
 store i64 %1, i64* %4
 %6 = load i8*, i8** %3
 %7 = call i8* @get_addr_base_and_unit_offset (i8* %6, i8* %5)
 store i8* %7, i8** %3
 %8 = load i8*, i8** %3
 %9 = load i64, i64* %5
 %10 = load i64, i64* %4
 %11 = sdiv i64 %10, 8
 %12 = add i64 %9, %11
 %13 = call i8* @build_int_cst (i8* %8, i64 %12)
 ret i8* %13
}

define i8* @get_addr_base_and_unit_offset (i8* %0, i8* %1) {
 %3 = alloca i8*
 %4 = alloca i8*
 store i8* %0, i8** %3
 store i8* %1, i8** %4
 %5 = load i8*, i8** %4
 store i64 0, i64* %5
 %6 = load i8*, i8** %3
 ret i8* %6
}

define i8* @build_int_cst (i8* %0, i64 %1) {
 %3 = alloca i8*
 %4 = alloca i64
 store i8* %0, i8** %3
 store i64 %1, i64* %4
 %5 = load i64, i64* %4
 %6 = icmp ne i64 %5, 4
 br i1 %6, label %7, label %8
7:
 call void @abort ()
 unreachable
8:
 %9 = load i8*, i8** %3
 ret i8* %9
}
