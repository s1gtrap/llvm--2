declare i32 @puts(i8*)

define i32 @main (i32 %argc, i8** %argv) {
 %arg0 = load i8*, i8** %argv
 call i32 @puts (i8* %arg0)
 ret i32 %argc
}
