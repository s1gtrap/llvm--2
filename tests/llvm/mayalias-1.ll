declare void @abort()
declare void @exit(i32)

define i32 @main () {
 %1 = alloca i32
 %2 = alloca i32
 %3 = alloca i8*
 store i32 0, i32* %1
 store i32 305419896, i32* %2
 store i8* %2, i8** %3
 %4 = load i8*, i8** %3
 %5 = getelementptr i16, i8* %4, i64 1
 store i16 0, i16* %5
 %6 = load i32, i32* %2
 %7 = icmp eq i32 %6, 305419896
 br i1 %7, label %8, label %9
8:
 call void @abort ()
 unreachable
9:
 call void @exit (i32 0)
 unreachable
}
