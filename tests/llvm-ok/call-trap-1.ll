declare void @exit(i32)
declare void @abort()

define i32 @foo () {
 call void @exit (i32 0)
 unreachable
}

define void @bar () {
 ret void
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @foo ()
 %3 = call i64 @bar (i32 %2)
 call void @abort ()
 unreachable
}
