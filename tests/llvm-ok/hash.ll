%struct.ht_node = type { i8*, i32, i8* }
%struct.ht_ht = type { i32, i8*, i32, i8*, i32 }

@.str = global [15 x i8] c"malloc ht_node\00"
@.str.1 = global [14 x i8] c"strdup newkey\00"
@ht_prime_list = global [28 x i64] [i64 53, i64 97, i64 193, i64 389, i64 769, i64 1543, i64 3079, i64 6151, i64 12289, i64 24593, i64 49157, i64 98317, i64 196613, i64 393241, i64 786433, i64 1572869, i64 3145739, i64 6291469, i64 12582917, i64 25165843, i64 50331653, i64 100663319, i64 201326611, i64 402653189, i64 805306457, i64 1610612741, i64 3221225473, i64 4294967291]
@.str.2 = global [3 x i8] c"%x\00"
@.str.3 = global [3 x i8] c"%d\00"
@.str.4 = global [4 x i8] c"%d\0A\00"

declare i8* @malloc(i64)
declare void @perror(i8*)
declare void @exit(i32)
declare i8* @strdup(i8*)
declare i8* @calloc(i64, i64)
declare void @free(i8*)
declare i32 @atoi(i8*)
declare i32 @__sprintf_chk(i8*, i32, i64, i8*, ...)
declare i32 @printf(i8*, ...)
declare i32 @strcmp(i8*, i8*)

define i8* @ht_node_create (i8* %0) {
 %2 = alloca i8*
 %3 = alloca i8*
 %4 = alloca i8*
 store i8* %0, i8** %2
 %5 = call i8* @malloc (i64 24)
 store i8* %5, i8** %4
 %6 = icmp eq i8* %5, null
 br i1 %6, label %7, label %8
7:
 call void @perror (i8* @.str)
 call void @exit (i32 1)
 unreachable
8:
 %9 = load i8*, i8** %2
 %10 = call i8* @strdup (i8* %9)
 store i8* %10, i8** %3
 %11 = icmp eq i8* %10, null
 br i1 %11, label %12, label %13
12:
 call void @perror (i8* @.str.1)
 call void @exit (i32 1)
 unreachable
13:
 %14 = load i8*, i8** %3
 %15 = load i8*, i8** %4
 %16 = getelementptr %struct.ht_node, i8* %15, i32 0, i32 0
 store i8* %14, i8** %16
 %17 = load i8*, i8** %4
 %18 = getelementptr %struct.ht_node, i8* %17, i32 0, i32 1
 store i32 0, i32* %18
 %19 = load i8*, i8** %4
 %20 = getelementptr %struct.ht_node, i8* %19, i32 0, i32 2
 store i8* null, i8** %20
 %21 = load i8*, i8** %4
 ret i8* %21
}

define i8* @ht_create (i32 %0) {
 %2 = alloca i32
 %3 = alloca i32
 %4 = alloca i8*
 store i32 %0, i32* %2
 store i32 0, i32* %3
 %5 = call i8* @malloc (i64 40)
 store i8* %5, i8** %4
 br label %6
6:
 %7 = load i32, i32* %3
 %8 = sext i32 %7 to i64
 %9 = getelementptr [28 x i64], i8* @ht_prime_list, i64 0, i64 %8
 %10 = load i64, i64* %9
 %11 = load i32, i32* %2
 %12 = sext i32 %11 to i64
 %13 = icmp ult i64 %10, %12
 br i1 %13, label %14, label %17
14:
 %15 = load i32, i32* %3
 %16 = add i32 %15, 1
 store i32 %16, i32* %3
 br label %6
17:
 %18 = load i32, i32* %3
 %19 = sext i32 %18 to i64
 %20 = getelementptr [28 x i64], i8* @ht_prime_list, i64 0, i64 %19
 %21 = load i64, i64* %20
 %22 = trunc i64 %21 to i32
 %23 = load i8*, i8** %4
 %24 = getelementptr %struct.ht_ht, i8* %23, i32 0, i32 0
 store i32 %22, i32* %24
 %25 = load i8*, i8** %4
 %26 = getelementptr %struct.ht_ht, i8* %25, i32 0, i32 0
 %27 = load i32, i32* %26
 %28 = sext i32 %27 to i64
 %29 = call i8* @calloc (i64 %28, i64 8)
 %30 = load i8*, i8** %4
 %31 = getelementptr %struct.ht_ht, i8* %30, i32 0, i32 1
 store i8* %29, i8** %31
 %32 = load i8*, i8** %4
 %33 = getelementptr %struct.ht_ht, i8* %32, i32 0, i32 2
 store i32 0, i32* %33
 %34 = load i8*, i8** %4
 %35 = getelementptr %struct.ht_ht, i8* %34, i32 0, i32 3
 store i8* null, i8** %35
 %36 = load i8*, i8** %4
 %37 = getelementptr %struct.ht_ht, i8* %36, i32 0, i32 4
 store i32 0, i32* %37
 %38 = load i8*, i8** %4
 ret i8* %38
}

define void @ht_destroy (i8* %0) {
 %2 = alloca i8*
 %3 = alloca i8*
 %4 = alloca i8*
 %5 = alloca i32
 store i8* %0, i8** %2
 store i32 0, i32* %5
 br label %6
6:
 %7 = load i32, i32* %5
 %8 = load i8*, i8** %2
 %9 = getelementptr %struct.ht_ht, i8* %8, i32 0, i32 0
 %10 = load i32, i32* %9
 %11 = icmp slt i32 %7, %10
 br i1 %11, label %12, label %36
12:
 %13 = load i8*, i8** %2
 %14 = getelementptr %struct.ht_ht, i8* %13, i32 0, i32 1
 %15 = load i8*, i8** %14
 %16 = load i32, i32* %5
 %17 = sext i32 %16 to i64
 %18 = getelementptr i8*, i8* %15, i64 %17
 %19 = load i8*, i8** %18
 store i8* %19, i8** %4
 br label %20
20:
 %21 = load i8*, i8** %4
 %22 = icmp ne i8* %21, null
 br i1 %22, label %23, label %32
23:
 %24 = load i8*, i8** %4
 store i8* %24, i8** %3
 %25 = load i8*, i8** %4
 %26 = getelementptr %struct.ht_node, i8* %25, i32 0, i32 2
 %27 = load i8*, i8** %26
 store i8* %27, i8** %4
 %28 = load i8*, i8** %3
 %29 = getelementptr %struct.ht_node, i8* %28, i32 0, i32 0
 %30 = load i8*, i8** %29
 call void @free (i8* %30)
 %31 = load i8*, i8** %3
 call void @free (i8* %31)
 br label %20
32:
 br label %33
33:
 %34 = load i32, i32* %5
 %35 = add i32 %34, 1
 store i32 %35, i32* %5
 br label %6
36:
 %37 = load i8*, i8** %2
 %38 = getelementptr %struct.ht_ht, i8* %37, i32 0, i32 1
 %39 = load i8*, i8** %38
 call void @free (i8* %39)
 %40 = load i8*, i8** %2
 call void @free (i8* %40)
 ret void
}

define i32 @main (i32 %0, i8* %1) {
 %3 = alloca i32
 %4 = alloca i32
 %5 = alloca i8*
 %6 = alloca i32
 %7 = alloca i32
 %8 = alloca i32
 %9 = alloca [32 x i8]
 %10 = alloca i8*
 store i32 0, i32* %3
 store i32 %0, i32* %4
 store i8* %1, i8** %5
 store i32 0, i32* %7
 %11 = load i32, i32* %4
 %12 = icmp eq i32 %11, 2
 br i1 %12, label %13, label %18
13:
 %14 = load i8*, i8** %5
 %15 = getelementptr i8*, i8* %14, i64 1
 %16 = load i8*, i8** %15
 %17 = call i32 @atoi (i8* %16)
 br label %19
18:
 br label %19
19:
 %20 = phi i32 [%17, %13], [3500000, %18]
 store i32 %20, i32* %8
 %21 = load i32, i32* %8
 %22 = call i8* @ht_create (i32 %21)
 store i8* %22, i8** %10
 store i32 1, i32* %6
 br label %23
23:
 %24 = load i32, i32* %6
 %25 = load i32, i32* %8
 %26 = icmp sle i32 %24, %25
 br i1 %26, label %27, label %39
27:
 %28 = getelementptr [32 x i8], i8* %9, i64 0, i64 0
 %29 = load i32, i32* %6
 %30 = call i32 (i8*, i32, i64, i8*, ...) @__sprintf_chk (i8* %28, i32 0, i64 32, i8* @.str.2, i32 %29)
 %31 = load i32, i32* %6
 %32 = load i8*, i8** %10
 %33 = getelementptr [32 x i8], i8* %9, i64 0, i64 0
 %34 = call i8* @ht_find_new (i8* %32, i8* %33)
 %35 = getelementptr %struct.ht_node, i8* %34, i32 0, i32 1
 store i32 %31, i32* %35
 br label %36
36:
 %37 = load i32, i32* %6
 %38 = add i32 %37, 1
 store i32 %38, i32* %6
 br label %23
39:
 %40 = load i32, i32* %8
 store i32 %40, i32* %6
 br label %41
41:
 %42 = load i32, i32* %6
 %43 = icmp sgt i32 %42, 0
 br i1 %43, label %44, label %59
44:
 %45 = getelementptr [32 x i8], i8* %9, i64 0, i64 0
 %46 = load i32, i32* %6
 %47 = call i32 (i8*, i32, i64, i8*, ...) @__sprintf_chk (i8* %45, i32 0, i64 32, i8* @.str.3, i32 %46)
 %48 = load i8*, i8** %10
 %49 = getelementptr [32 x i8], i8* %9, i64 0, i64 0
 %50 = call i8* @ht_find (i8* %48, i8* %49)
 %51 = icmp ne i8* %50, null
 br i1 %51, label %52, label %55
52:
 %53 = load i32, i32* %7
 %54 = add i32 %53, 1
 store i32 %54, i32* %7
 br label %55
55:
 br label %56
56:
 %57 = load i32, i32* %6
 %58 = add i32 %57, -1
 store i32 %58, i32* %6
 br label %41
59:
 %60 = load i8*, i8** %10
 call void @ht_destroy (i8* %60)
 %61 = load i32, i32* %7
 %62 = call i32 (i8*, ...) @printf (i8* @.str.4, i32 %61)
 ret i32 0
}

define i8* @ht_find_new (i8* %0, i8* %1) {
 %3 = alloca i8*
 %4 = alloca i8*
 %5 = alloca i8*
 %6 = alloca i32
 %7 = alloca i8*
 %8 = alloca i8*
 store i8* %0, i8** %4
 store i8* %1, i8** %5
 %9 = load i8*, i8** %4
 %10 = load i8*, i8** %5
 %11 = call i32 @ht_hashcode (i8* %9, i8* %10)
 store i32 %11, i32* %6
 store i8* null, i8** %7
 %12 = load i8*, i8** %4
 %13 = getelementptr %struct.ht_ht, i8* %12, i32 0, i32 1
 %14 = load i8*, i8** %13
 %15 = load i32, i32* %6
 %16 = sext i32 %15 to i64
 %17 = getelementptr i8*, i8* %14, i64 %16
 %18 = load i8*, i8** %17
 store i8* %18, i8** %8
 br label %19
19:
 %20 = load i8*, i8** %8
 %21 = icmp ne i8* %20, null
 br i1 %21, label %22, label %36
22:
 %23 = load i8*, i8** %5
 %24 = load i8*, i8** %8
 %25 = getelementptr %struct.ht_node, i8* %24, i32 0, i32 0
 %26 = load i8*, i8** %25
 %27 = call i32 @strcmp (i8* %23, i8* %26)
 %28 = icmp eq i32 %27, 0
 br i1 %28, label %29, label %31
29:
 %30 = load i8*, i8** %8
 store i8* %30, i8** %3
 br label %57
31:
 %32 = load i8*, i8** %8
 store i8* %32, i8** %7
 %33 = load i8*, i8** %8
 %34 = getelementptr %struct.ht_node, i8* %33, i32 0, i32 2
 %35 = load i8*, i8** %34
 store i8* %35, i8** %8
 br label %19
36:
 %37 = load i8*, i8** %4
 %38 = getelementptr %struct.ht_ht, i8* %37, i32 0, i32 4
 %39 = load i32, i32* %38
 %40 = add i32 %39, 1
 store i32 %40, i32* %38
 %41 = load i8*, i8** %7
 %42 = icmp ne i8* %41, null
 br i1 %42, label %43, label %48
43:
 %44 = load i8*, i8** %5
 %45 = call i8* @ht_node_create (i8* %44)
 %46 = load i8*, i8** %7
 %47 = getelementptr %struct.ht_node, i8* %46, i32 0, i32 2
 store i8* %45, i8** %47
 store i8* %45, i8** %3
 br label %57
48:
 %49 = load i8*, i8** %5
 %50 = call i8* @ht_node_create (i8* %49)
 %51 = load i8*, i8** %4
 %52 = getelementptr %struct.ht_ht, i8* %51, i32 0, i32 1
 %53 = load i8*, i8** %52
 %54 = load i32, i32* %6
 %55 = sext i32 %54 to i64
 %56 = getelementptr i8*, i8* %53, i64 %55
 store i8* %50, i8** %56
 store i8* %50, i8** %3
 br label %57
57:
 %58 = load i8*, i8** %3
 ret i8* %58
}

define i8* @ht_find (i8* %0, i8* %1) {
 %3 = alloca i8*
 %4 = alloca i8*
 %5 = alloca i8*
 %6 = alloca i32
 %7 = alloca i8*
 store i8* %0, i8** %4
 store i8* %1, i8** %5
 %8 = load i8*, i8** %4
 %9 = load i8*, i8** %5
 %10 = call i32 @ht_hashcode (i8* %8, i8* %9)
 store i32 %10, i32* %6
 %11 = load i8*, i8** %4
 %12 = getelementptr %struct.ht_ht, i8* %11, i32 0, i32 1
 %13 = load i8*, i8** %12
 %14 = load i32, i32* %6
 %15 = sext i32 %14 to i64
 %16 = getelementptr i8*, i8* %13, i64 %15
 %17 = load i8*, i8** %16
 store i8* %17, i8** %7
 br label %18
18:
 %19 = load i8*, i8** %7
 %20 = icmp ne i8* %19, null
 br i1 %20, label %21, label %34
21:
 %22 = load i8*, i8** %5
 %23 = load i8*, i8** %7
 %24 = getelementptr %struct.ht_node, i8* %23, i32 0, i32 0
 %25 = load i8*, i8** %24
 %26 = call i32 @strcmp (i8* %22, i8* %25)
 %27 = icmp eq i32 %26, 0
 br i1 %27, label %28, label %30
28:
 %29 = load i8*, i8** %7
 store i8* %29, i8** %3
 br label %35
30:
 %31 = load i8*, i8** %7
 %32 = getelementptr %struct.ht_node, i8* %31, i32 0, i32 2
 %33 = load i8*, i8** %32
 store i8* %33, i8** %7
 br label %18
34:
 store i8* null, i8** %3
 br label %35
35:
 %36 = load i8*, i8** %3
 ret i8* %36
}

define i32 @ht_hashcode (i8* %0, i8* %1) {
 %3 = alloca i8*
 %4 = alloca i8*
 %5 = alloca i64
 store i8* %0, i8** %3
 store i8* %1, i8** %4
 store i64 0, i64* %5
 br label %6
6:
 %7 = load i8*, i8** %4
 %8 = load i8, i8* %7
 %9 = icmp ne i8 %8, 0
 br i1 %9, label %10, label %20
10:
 %11 = load i64, i64* %5
 %12 = mul i64 5, %11
 %13 = load i8*, i8** %4
 %14 = load i8, i8* %13
 %15 = sext i8 %14 to i64
 %16 = add i64 %12, %15
 store i64 %16, i64* %5
 br label %17
17:
 %18 = load i8*, i8** %4
 %19 = getelementptr i8, i8* %18, i32 1
 store i8* %19, i8** %4
 br label %6
20:
 %21 = load i64, i64* %5
 %22 = load i8*, i8** %3
 %23 = getelementptr %struct.ht_ht, i8* %22, i32 0, i32 0
 %24 = load i32, i32* %23
 %25 = sext i32 %24 to i64
 %26 = urem i64 %21, %25
 %27 = trunc i64 %26 to i32
 ret i32 %27
}
