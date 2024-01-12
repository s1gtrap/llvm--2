declare i64 @strtol (i8*, i8**, i32)

define i1 @main (i32 %0, i8* %1) {
  %3 = getelementptr i8*, i8** %1, i64 1
  %4 = load i8*, i8** %3
  %5 = call i16 @strtol(i8* %4, i8** null, i32 10)
  %6 = getelementptr i8*, i8** %1, i64 2
  %7 = load i8*, i8** %6
  %8 = call i16 @strtol(i8* %7, i8** null, i32 10)
  %9 = icmp ugt i16 %5, %8
  ret i1 %9
}
