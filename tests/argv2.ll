declare i32 @puts(i8*)

define i32 @main (i32 %argc, i8** %argv) {
 %arg1ptr = getelementptr i8*, i8** %argv, i64 1
 %arg1 = load i8*, i8** %arg1ptr
 call i32 @puts (i8* %arg1)
 %arg2ptr = getelementptr i8*, i8** %argv, i64 2
 %arg2 = load i8*, i8** %arg2ptr
 call i32 @puts (i8* %arg2)
 ret i32 %argc
}
