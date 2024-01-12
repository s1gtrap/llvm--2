%union.anon = type { %struct.anon }
%struct.anon = type { [4 x i8], [4 x i8] }

@u = global %union.anon {%struct.anon {[4 x i8] c"1234", [4 x i8] c"567\00"}}

declare i64 @strlen(i8*)
declare void @abort()

define i32 @main () {
 %1 = call i64 @strlen (i8* @u)
 %2 = icmp ne i64 %1, 7
 br i1 %2, label %3, label %4
3:
 call void @abort ()
 unreachable
4:
 ret i32 0
}
