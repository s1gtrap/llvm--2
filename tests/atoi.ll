declare i32 @atoi(i8*)

define i32 @main(i32 %argc, i8** %argv) {
    %arg1ptr = getelementptr i8*, i8** %argv, i64 1
    %arg1 = load i8*, i8** %arg1ptr
    %x = call i32 @atoi(i8* %arg1)
    ret i32 %x
}
