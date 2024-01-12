%struct.unit_flags = type { i32, i32 }

declare void @abort()

define void @new_unit (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 %3 = load i8*, i8** %2
 %4 = getelementptr %struct.unit_flags, i8* %3, i32 0, i32 1
 %5 = load i32, i32* %4
 %6 = icmp eq i32 %5, 1
 br i1 %6, label %7, label %10
7:
 %8 = load i8*, i8** %2
 %9 = getelementptr %struct.unit_flags, i8* %8, i32 0, i32 1
 store i32 0, i32* %9
 br label %10
10:
 %11 = load i8*, i8** %2
 %12 = getelementptr %struct.unit_flags, i8* %11, i32 0, i32 0
 %13 = load i32, i32* %12
 %14 = icmp eq i32 %13, 1
 br i1 %14, label %15, label %18
15:
 %16 = load i8*, i8** %2
 %17 = getelementptr %struct.unit_flags, i8* %16, i32 0, i32 0
 store i32 0, i32* %17
 br label %18
18:
 %19 = load i8*, i8** %2
 %20 = getelementptr %struct.unit_flags, i8* %19, i32 0, i32 1
 %21 = load i32, i32* %20
 switch i32 %21, label %23 [
    i32 0, label %22
  ]
22:
 br label %24
23:
 call void @abort ()
 unreachable
24:
 ret void
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca %struct.unit_flags
 store i32 0, i32* %1
 %3 = getelementptr %struct.unit_flags, i8* %2, i32 0, i32 1
 store i32 1, i32* %3
 call void @new_unit (i8* %2)
 ret i32 0
}
