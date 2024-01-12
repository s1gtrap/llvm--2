%union.U = type { i32 }

@u = global %union.U {i32 305419896}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = load i32, i32* @u
 %3 = and i32 %2, 16777215
 %4 = sub i32 %3, 3430008
 ret i32 %4
}
