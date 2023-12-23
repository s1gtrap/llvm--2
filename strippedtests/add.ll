declare i32 @atoi(i8*)
declare i32 @puts(i8*)

define i32 @main (i32 %argc, i8** %argv) {
 %arg1ptr = getelementptr i8*, i8** %argv, i64 1
 %arg1 = load i8*, i8** %arg1ptr
 %x1 = call i32 @atoi (i8* %arg1)
 %arg2ptr = getelementptr i8*, i8** %argv, i64 2
 %arg2 = load i8*, i8** %arg2ptr
 %y1 = call i32 @atoi (i8* %arg2)
 %ret = add i32 %x1, %y1
 ret i32 %ret
}
