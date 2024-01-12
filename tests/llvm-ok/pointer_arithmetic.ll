%struct.S2Ty = type { %struct.S1Ty, %struct.S1Ty }
%struct.S1Ty = type { i32 }

define void @takeS1 (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 ret void
}

define void @takeVoid (i8* %0) {
 %2 = alloca i8*
 store i8* %0, i8** %2
 ret void
}

define i32 @main () {
 %1 = alloca i32
 %2 = alloca %struct.S2Ty
 store i32 0, i32* %1
 %3 = getelementptr %struct.S2Ty, i8* %2, i32 0, i32 1
 call void @takeS1 (i8* %3)
 call void @takeVoid (i8* %2)
 ret i32 0
}
