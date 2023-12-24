; ModuleID = 'sudoku.c'
source_filename = "sudoku.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-macosx14.0.0"

@.str = private unnamed_addr constant [3 x i8] c"+-\00", align 1
@.str.1 = private unnamed_addr constant [3 x i8] c"--\00", align 1
@.str.2 = private unnamed_addr constant [3 x i8] c"+\0A\00", align 1
@.str.3 = private unnamed_addr constant [4 x i8] c"|%c\00", align 1
@.str.4 = private unnamed_addr constant [3 x i8] c"| \00", align 1
@.str.5 = private unnamed_addr constant [4 x i8] c" %c\00", align 1
@.str.6 = private unnamed_addr constant [3 x i8] c"  \00", align 1
@.str.7 = private unnamed_addr constant [3 x i8] c"|\0A\00", align 1

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @add_edge(i32 noundef %0, i32 noundef %1, i32 noundef %2, ptr noundef %3) #0 {
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca ptr, align 8
  store i32 %0, ptr %5, align 4
  store i32 %1, ptr %6, align 4
  store i32 %2, ptr %7, align 4
  store ptr %3, ptr %8, align 8
  %9 = load ptr, ptr %8, align 8
  %10 = load i32, ptr %6, align 4
  %11 = load i32, ptr %7, align 4
  %12 = load i32, ptr %5, align 4
  %13 = mul nsw i32 %11, %12
  %14 = load i32, ptr %5, align 4
  %15 = mul nsw i32 %13, %14
  %16 = load i32, ptr %5, align 4
  %17 = mul nsw i32 %15, %16
  %18 = load i32, ptr %5, align 4
  %19 = mul nsw i32 %17, %18
  %20 = add nsw i32 %10, %19
  %21 = sext i32 %20 to i64
  %22 = getelementptr inbounds i8, ptr %9, i64 %21
  store i8 1, ptr %22, align 1
  %23 = load ptr, ptr %8, align 8
  %24 = load i32, ptr %7, align 4
  %25 = load i32, ptr %6, align 4
  %26 = load i32, ptr %5, align 4
  %27 = mul nsw i32 %25, %26
  %28 = load i32, ptr %5, align 4
  %29 = mul nsw i32 %27, %28
  %30 = load i32, ptr %5, align 4
  %31 = mul nsw i32 %29, %30
  %32 = load i32, ptr %5, align 4
  %33 = mul nsw i32 %31, %32
  %34 = add nsw i32 %24, %33
  %35 = sext i32 %34 to i64
  %36 = getelementptr inbounds i8, ptr %23, i64 %35
  store i8 1, ptr %36, align 1
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @init_sudoku(i32 noundef %0, ptr noundef %1, ptr noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  store i32 %0, ptr %4, align 4
  store ptr %1, ptr %5, align 8
  store ptr %2, ptr %6, align 8
  store i32 0, ptr %7, align 4
  br label %18

18:                                               ; preds = %33, %3
  %19 = load i32, ptr %7, align 4
  %20 = load i32, ptr %4, align 4
  %21 = load i32, ptr %4, align 4
  %22 = mul nsw i32 %20, %21
  %23 = load i32, ptr %4, align 4
  %24 = mul nsw i32 %22, %23
  %25 = load i32, ptr %4, align 4
  %26 = mul nsw i32 %24, %25
  %27 = icmp slt i32 %19, %26
  br i1 %27, label %28, label %36

28:                                               ; preds = %18
  %29 = load ptr, ptr %5, align 8
  %30 = load i32, ptr %7, align 4
  %31 = sext i32 %30 to i64
  %32 = getelementptr inbounds i32, ptr %29, i64 %31
  store i32 0, ptr %32, align 4
  br label %33

33:                                               ; preds = %28
  %34 = load i32, ptr %7, align 4
  %35 = add nsw i32 %34, 1
  store i32 %35, ptr %7, align 4
  br label %18, !llvm.loop !5

36:                                               ; preds = %18
  store i32 0, ptr %8, align 4
  br label %37

37:                                               ; preds = %60, %36
  %38 = load i32, ptr %8, align 4
  %39 = load i32, ptr %4, align 4
  %40 = load i32, ptr %4, align 4
  %41 = mul nsw i32 %39, %40
  %42 = load i32, ptr %4, align 4
  %43 = mul nsw i32 %41, %42
  %44 = load i32, ptr %4, align 4
  %45 = mul nsw i32 %43, %44
  %46 = load i32, ptr %4, align 4
  %47 = mul nsw i32 %45, %46
  %48 = load i32, ptr %4, align 4
  %49 = mul nsw i32 %47, %48
  %50 = load i32, ptr %4, align 4
  %51 = mul nsw i32 %49, %50
  %52 = load i32, ptr %4, align 4
  %53 = mul nsw i32 %51, %52
  %54 = icmp slt i32 %38, %53
  br i1 %54, label %55, label %63

55:                                               ; preds = %37
  %56 = load ptr, ptr %6, align 8
  %57 = load i32, ptr %8, align 4
  %58 = sext i32 %57 to i64
  %59 = getelementptr inbounds i8, ptr %56, i64 %58
  store i8 0, ptr %59, align 1
  br label %60

60:                                               ; preds = %55
  %61 = load i32, ptr %8, align 4
  %62 = add nsw i32 %61, 1
  store i32 %62, ptr %8, align 4
  br label %37, !llvm.loop !7

63:                                               ; preds = %37
  store i32 0, ptr %9, align 4
  br label %64

64:                                               ; preds = %194, %63
  %65 = load i32, ptr %9, align 4
  %66 = load i32, ptr %4, align 4
  %67 = load i32, ptr %4, align 4
  %68 = mul nsw i32 %66, %67
  %69 = icmp slt i32 %65, %68
  br i1 %69, label %70, label %197

70:                                               ; preds = %64
  store i32 0, ptr %10, align 4
  br label %71

71:                                               ; preds = %190, %70
  %72 = load i32, ptr %10, align 4
  %73 = load i32, ptr %4, align 4
  %74 = load i32, ptr %4, align 4
  %75 = mul nsw i32 %73, %74
  %76 = icmp slt i32 %72, %75
  br i1 %76, label %77, label %193

77:                                               ; preds = %71
  store i32 0, ptr %11, align 4
  br label %78

78:                                               ; preds = %186, %77
  %79 = load i32, ptr %11, align 4
  %80 = load i32, ptr %4, align 4
  %81 = load i32, ptr %4, align 4
  %82 = mul nsw i32 %80, %81
  %83 = icmp slt i32 %79, %82
  br i1 %83, label %84, label %189

84:                                               ; preds = %78
  %85 = load i32, ptr %11, align 4
  %86 = load i32, ptr %9, align 4
  %87 = icmp ne i32 %85, %86
  br i1 %87, label %88, label %105

88:                                               ; preds = %84
  %89 = load i32, ptr %4, align 4
  %90 = load i32, ptr %9, align 4
  %91 = load i32, ptr %10, align 4
  %92 = load i32, ptr %4, align 4
  %93 = mul nsw i32 %91, %92
  %94 = load i32, ptr %4, align 4
  %95 = mul nsw i32 %93, %94
  %96 = add nsw i32 %90, %95
  %97 = load i32, ptr %11, align 4
  %98 = load i32, ptr %10, align 4
  %99 = load i32, ptr %4, align 4
  %100 = mul nsw i32 %98, %99
  %101 = load i32, ptr %4, align 4
  %102 = mul nsw i32 %100, %101
  %103 = add nsw i32 %97, %102
  %104 = load ptr, ptr %6, align 8
  call void @add_edge(i32 noundef %89, i32 noundef %96, i32 noundef %103, ptr noundef %104)
  br label %105

105:                                              ; preds = %88, %84
  %106 = load i32, ptr %11, align 4
  %107 = load i32, ptr %10, align 4
  %108 = icmp ne i32 %106, %107
  br i1 %108, label %109, label %126

109:                                              ; preds = %105
  %110 = load i32, ptr %4, align 4
  %111 = load i32, ptr %9, align 4
  %112 = load i32, ptr %10, align 4
  %113 = load i32, ptr %4, align 4
  %114 = mul nsw i32 %112, %113
  %115 = load i32, ptr %4, align 4
  %116 = mul nsw i32 %114, %115
  %117 = add nsw i32 %111, %116
  %118 = load i32, ptr %9, align 4
  %119 = load i32, ptr %11, align 4
  %120 = load i32, ptr %4, align 4
  %121 = mul nsw i32 %119, %120
  %122 = load i32, ptr %4, align 4
  %123 = mul nsw i32 %121, %122
  %124 = add nsw i32 %118, %123
  %125 = load ptr, ptr %6, align 8
  call void @add_edge(i32 noundef %110, i32 noundef %117, i32 noundef %124, ptr noundef %125)
  br label %126

126:                                              ; preds = %109, %105
  %127 = load i32, ptr %9, align 4
  %128 = load i32, ptr %4, align 4
  %129 = sdiv i32 %127, %128
  %130 = load i32, ptr %4, align 4
  %131 = mul nsw i32 %129, %130
  store i32 %131, ptr %12, align 4
  %132 = load i32, ptr %10, align 4
  %133 = load i32, ptr %4, align 4
  %134 = sdiv i32 %132, %133
  %135 = load i32, ptr %4, align 4
  %136 = mul nsw i32 %134, %135
  store i32 %136, ptr %13, align 4
  store i32 0, ptr %14, align 4
  br label %137

137:                                              ; preds = %182, %126
  %138 = load i32, ptr %14, align 4
  %139 = load i32, ptr %4, align 4
  %140 = icmp slt i32 %138, %139
  br i1 %140, label %141, label %185

141:                                              ; preds = %137
  store i32 0, ptr %15, align 4
  br label %142

142:                                              ; preds = %178, %141
  %143 = load i32, ptr %15, align 4
  %144 = load i32, ptr %4, align 4
  %145 = icmp slt i32 %143, %144
  br i1 %145, label %146, label %181

146:                                              ; preds = %142
  %147 = load i32, ptr %12, align 4
  %148 = load i32, ptr %14, align 4
  %149 = add nsw i32 %147, %148
  store i32 %149, ptr %16, align 4
  %150 = load i32, ptr %13, align 4
  %151 = load i32, ptr %15, align 4
  %152 = add nsw i32 %150, %151
  store i32 %152, ptr %17, align 4
  %153 = load i32, ptr %16, align 4
  %154 = load i32, ptr %9, align 4
  %155 = icmp ne i32 %153, %154
  br i1 %155, label %160, label %156

156:                                              ; preds = %146
  %157 = load i32, ptr %17, align 4
  %158 = load i32, ptr %10, align 4
  %159 = icmp ne i32 %157, %158
  br i1 %159, label %160, label %177

160:                                              ; preds = %156, %146
  %161 = load i32, ptr %4, align 4
  %162 = load i32, ptr %9, align 4
  %163 = load i32, ptr %10, align 4
  %164 = load i32, ptr %4, align 4
  %165 = mul nsw i32 %163, %164
  %166 = load i32, ptr %4, align 4
  %167 = mul nsw i32 %165, %166
  %168 = add nsw i32 %162, %167
  %169 = load i32, ptr %16, align 4
  %170 = load i32, ptr %17, align 4
  %171 = load i32, ptr %4, align 4
  %172 = mul nsw i32 %170, %171
  %173 = load i32, ptr %4, align 4
  %174 = mul nsw i32 %172, %173
  %175 = add nsw i32 %169, %174
  %176 = load ptr, ptr %6, align 8
  call void @add_edge(i32 noundef %161, i32 noundef %168, i32 noundef %175, ptr noundef %176)
  br label %177

177:                                              ; preds = %160, %156
  br label %178

178:                                              ; preds = %177
  %179 = load i32, ptr %15, align 4
  %180 = add nsw i32 %179, 1
  store i32 %180, ptr %15, align 4
  br label %142, !llvm.loop !8

181:                                              ; preds = %142
  br label %182

182:                                              ; preds = %181
  %183 = load i32, ptr %14, align 4
  %184 = add nsw i32 %183, 1
  store i32 %184, ptr %14, align 4
  br label %137, !llvm.loop !9

185:                                              ; preds = %137
  br label %186

186:                                              ; preds = %185
  %187 = load i32, ptr %11, align 4
  %188 = add nsw i32 %187, 1
  store i32 %188, ptr %11, align 4
  br label %78, !llvm.loop !10

189:                                              ; preds = %78
  br label %190

190:                                              ; preds = %189
  %191 = load i32, ptr %10, align 4
  %192 = add nsw i32 %191, 1
  store i32 %192, ptr %10, align 4
  br label %71, !llvm.loop !11

193:                                              ; preds = %71
  br label %194

194:                                              ; preds = %193
  %195 = load i32, ptr %9, align 4
  %196 = add nsw i32 %195, 1
  store i32 %196, ptr %9, align 4
  br label %64, !llvm.loop !12

197:                                              ; preds = %64
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define signext i8 @toc(i32 noundef %0) #0 {
  %2 = alloca i8, align 1
  %3 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  %4 = load i32, ptr %3, align 4
  %5 = icmp slt i32 %4, 10
  br i1 %5, label %6, label %10

6:                                                ; preds = %1
  %7 = load i32, ptr %3, align 4
  %8 = add nsw i32 48, %7
  %9 = trunc i32 %8 to i8
  store i8 %9, ptr %2, align 1
  br label %19

10:                                               ; preds = %1
  %11 = load i32, ptr %3, align 4
  %12 = icmp slt i32 %11, 46
  br i1 %12, label %13, label %18

13:                                               ; preds = %10
  %14 = load i32, ptr %3, align 4
  %15 = add nsw i32 65, %14
  %16 = sub nsw i32 %15, 10
  %17 = trunc i32 %16 to i8
  store i8 %17, ptr %2, align 1
  br label %19

18:                                               ; preds = %10
  br label %19

19:                                               ; preds = %6, %13, %18
  %20 = load i8, ptr %2, align 1
  ret i8 %20
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @print_sudoku(i32 noundef %0, ptr noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store ptr %1, ptr %4, align 8
  store i32 0, ptr %5, align 4
  br label %9

9:                                                ; preds = %27, %2
  %10 = load i32, ptr %5, align 4
  %11 = load i32, ptr %3, align 4
  %12 = load i32, ptr %3, align 4
  %13 = mul nsw i32 %11, %12
  %14 = icmp slt i32 %10, %13
  br i1 %14, label %15, label %30

15:                                               ; preds = %9
  %16 = load i32, ptr %3, align 4
  %17 = load i32, ptr %5, align 4
  %18 = mul nsw i32 %16, %17
  %19 = load i32, ptr %3, align 4
  %20 = load i32, ptr %3, align 4
  %21 = mul nsw i32 %19, %20
  %22 = srem i32 %18, %21
  %23 = icmp eq i32 %22, 0
  %24 = zext i1 %23 to i64
  %25 = select i1 %23, ptr @.str, ptr @.str.1
  %26 = call i32 (ptr, ...) @printf(ptr noundef %25)
  br label %27

27:                                               ; preds = %15
  %28 = load i32, ptr %5, align 4
  %29 = add nsw i32 %28, 1
  store i32 %29, ptr %5, align 4
  br label %9, !llvm.loop !13

30:                                               ; preds = %9
  %31 = call i32 (ptr, ...) @printf(ptr noundef @.str.2)
  store i32 0, ptr %6, align 4
  br label %32

32:                                               ; preds = %151, %30
  %33 = load i32, ptr %6, align 4
  %34 = load i32, ptr %3, align 4
  %35 = load i32, ptr %3, align 4
  %36 = mul nsw i32 %34, %35
  %37 = sub nsw i32 %36, 1
  %38 = icmp sle i32 %33, %37
  br i1 %38, label %39, label %154

39:                                               ; preds = %32
  store i32 0, ptr %7, align 4
  br label %40

40:                                               ; preds = %115, %39
  %41 = load i32, ptr %7, align 4
  %42 = load i32, ptr %3, align 4
  %43 = load i32, ptr %3, align 4
  %44 = mul nsw i32 %42, %43
  %45 = sub nsw i32 %44, 1
  %46 = icmp sle i32 %41, %45
  br i1 %46, label %47, label %118

47:                                               ; preds = %40
  %48 = load i32, ptr %7, align 4
  %49 = load i32, ptr %3, align 4
  %50 = srem i32 %48, %49
  %51 = icmp eq i32 %50, 0
  br i1 %51, label %52, label %83

52:                                               ; preds = %47
  %53 = load ptr, ptr %4, align 8
  %54 = load i32, ptr %7, align 4
  %55 = load i32, ptr %6, align 4
  %56 = load i32, ptr %3, align 4
  %57 = mul nsw i32 %55, %56
  %58 = load i32, ptr %3, align 4
  %59 = mul nsw i32 %57, %58
  %60 = add nsw i32 %54, %59
  %61 = sext i32 %60 to i64
  %62 = getelementptr inbounds i32, ptr %53, i64 %61
  %63 = load i32, ptr %62, align 4
  %64 = icmp sgt i32 %63, 0
  br i1 %64, label %65, label %80

65:                                               ; preds = %52
  %66 = load ptr, ptr %4, align 8
  %67 = load i32, ptr %7, align 4
  %68 = load i32, ptr %6, align 4
  %69 = load i32, ptr %3, align 4
  %70 = mul nsw i32 %68, %69
  %71 = load i32, ptr %3, align 4
  %72 = mul nsw i32 %70, %71
  %73 = add nsw i32 %67, %72
  %74 = sext i32 %73 to i64
  %75 = getelementptr inbounds i32, ptr %66, i64 %74
  %76 = load i32, ptr %75, align 4
  %77 = call signext i8 @toc(i32 noundef %76)
  %78 = sext i8 %77 to i32
  %79 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef %78)
  br label %82

80:                                               ; preds = %52
  %81 = call i32 (ptr, ...) @printf(ptr noundef @.str.4)
  br label %82

82:                                               ; preds = %80, %65
  br label %114

83:                                               ; preds = %47
  %84 = load ptr, ptr %4, align 8
  %85 = load i32, ptr %7, align 4
  %86 = load i32, ptr %6, align 4
  %87 = load i32, ptr %3, align 4
  %88 = mul nsw i32 %86, %87
  %89 = load i32, ptr %3, align 4
  %90 = mul nsw i32 %88, %89
  %91 = add nsw i32 %85, %90
  %92 = sext i32 %91 to i64
  %93 = getelementptr inbounds i32, ptr %84, i64 %92
  %94 = load i32, ptr %93, align 4
  %95 = icmp sgt i32 %94, 0
  br i1 %95, label %96, label %111

96:                                               ; preds = %83
  %97 = load ptr, ptr %4, align 8
  %98 = load i32, ptr %7, align 4
  %99 = load i32, ptr %6, align 4
  %100 = load i32, ptr %3, align 4
  %101 = mul nsw i32 %99, %100
  %102 = load i32, ptr %3, align 4
  %103 = mul nsw i32 %101, %102
  %104 = add nsw i32 %98, %103
  %105 = sext i32 %104 to i64
  %106 = getelementptr inbounds i32, ptr %97, i64 %105
  %107 = load i32, ptr %106, align 4
  %108 = call signext i8 @toc(i32 noundef %107)
  %109 = sext i8 %108 to i32
  %110 = call i32 (ptr, ...) @printf(ptr noundef @.str.5, i32 noundef %109)
  br label %113

111:                                              ; preds = %83
  %112 = call i32 (ptr, ...) @printf(ptr noundef @.str.6)
  br label %113

113:                                              ; preds = %111, %96
  br label %114

114:                                              ; preds = %113, %82
  br label %115

115:                                              ; preds = %114
  %116 = load i32, ptr %7, align 4
  %117 = add nsw i32 %116, 1
  store i32 %117, ptr %7, align 4
  br label %40, !llvm.loop !14

118:                                              ; preds = %40
  %119 = call i32 (ptr, ...) @printf(ptr noundef @.str.7)
  %120 = load i32, ptr %6, align 4
  %121 = load i32, ptr %3, align 4
  %122 = srem i32 %120, %121
  %123 = load i32, ptr %3, align 4
  %124 = sub nsw i32 %123, 1
  %125 = icmp eq i32 %122, %124
  br i1 %125, label %126, label %150

126:                                              ; preds = %118
  store i32 0, ptr %8, align 4
  br label %127

127:                                              ; preds = %145, %126
  %128 = load i32, ptr %8, align 4
  %129 = load i32, ptr %3, align 4
  %130 = load i32, ptr %3, align 4
  %131 = mul nsw i32 %129, %130
  %132 = icmp slt i32 %128, %131
  br i1 %132, label %133, label %148

133:                                              ; preds = %127
  %134 = load i32, ptr %3, align 4
  %135 = load i32, ptr %8, align 4
  %136 = mul nsw i32 %134, %135
  %137 = load i32, ptr %3, align 4
  %138 = load i32, ptr %3, align 4
  %139 = mul nsw i32 %137, %138
  %140 = srem i32 %136, %139
  %141 = icmp eq i32 %140, 0
  %142 = zext i1 %141 to i64
  %143 = select i1 %141, ptr @.str, ptr @.str.1
  %144 = call i32 (ptr, ...) @printf(ptr noundef %143)
  br label %145

145:                                              ; preds = %133
  %146 = load i32, ptr %8, align 4
  %147 = add nsw i32 %146, 1
  store i32 %147, ptr %8, align 4
  br label %127, !llvm.loop !15

148:                                              ; preds = %127
  %149 = call i32 (ptr, ...) @printf(ptr noundef @.str.2)
  br label %150

150:                                              ; preds = %148, %118
  br label %151

151:                                              ; preds = %150
  %152 = load i32, ptr %6, align 4
  %153 = add nsw i32 %152, 1
  store i32 %153, ptr %6, align 4
  br label %32, !llvm.loop !16

154:                                              ; preds = %32
  ret void
}

declare i32 @printf(ptr noundef, ...) #1

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @degree(i32 noundef %0, i32 noundef %1, ptr noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  store i32 %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  store ptr %2, ptr %6, align 8
  store i32 0, ptr %7, align 4
  br label %8

8:                                                ; preds = %36, %3
  %9 = load i32, ptr %5, align 4
  %10 = load i32, ptr %4, align 4
  %11 = load i32, ptr %4, align 4
  %12 = mul nsw i32 %10, %11
  %13 = load i32, ptr %4, align 4
  %14 = mul nsw i32 %12, %13
  %15 = load i32, ptr %4, align 4
  %16 = mul nsw i32 %14, %15
  %17 = load i32, ptr %4, align 4
  %18 = mul nsw i32 %16, %17
  %19 = load i32, ptr %4, align 4
  %20 = mul nsw i32 %18, %19
  %21 = load i32, ptr %4, align 4
  %22 = mul nsw i32 %20, %21
  %23 = load i32, ptr %4, align 4
  %24 = mul nsw i32 %22, %23
  %25 = icmp slt i32 %9, %24
  br i1 %25, label %26, label %46

26:                                               ; preds = %8
  %27 = load ptr, ptr %6, align 8
  %28 = load i32, ptr %5, align 4
  %29 = sext i32 %28 to i64
  %30 = getelementptr inbounds i8, ptr %27, i64 %29
  %31 = load i8, ptr %30, align 1
  %32 = trunc i8 %31 to i1
  %33 = zext i1 %32 to i32
  %34 = load i32, ptr %7, align 4
  %35 = add nsw i32 %34, %33
  store i32 %35, ptr %7, align 4
  br label %36

36:                                               ; preds = %26
  %37 = load i32, ptr %4, align 4
  %38 = load i32, ptr %4, align 4
  %39 = mul nsw i32 %37, %38
  %40 = load i32, ptr %4, align 4
  %41 = mul nsw i32 %39, %40
  %42 = load i32, ptr %4, align 4
  %43 = mul nsw i32 %41, %42
  %44 = load i32, ptr %5, align 4
  %45 = add nsw i32 %44, %43
  store i32 %45, ptr %5, align 4
  br label %8, !llvm.loop !17

46:                                               ; preds = %8
  %47 = load i32, ptr %7, align 4
  ret i32 %47
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define zeroext i1 @coloring(i32 noundef %0, i32 noundef %1, ptr noundef %2, ptr noundef %3) #0 {
  %5 = alloca i1, align 1
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca ptr, align 8
  %9 = alloca ptr, align 8
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  store i32 %0, ptr %6, align 4
  store i32 %1, ptr %7, align 4
  store ptr %2, ptr %8, align 8
  store ptr %3, ptr %9, align 8
  store i32 0, ptr %10, align 4
  br label %14

14:                                               ; preds = %124, %4
  %15 = load i32, ptr %10, align 4
  %16 = load i32, ptr %6, align 4
  %17 = load i32, ptr %6, align 4
  %18 = mul nsw i32 %16, %17
  %19 = load i32, ptr %6, align 4
  %20 = mul nsw i32 %18, %19
  %21 = load i32, ptr %6, align 4
  %22 = mul nsw i32 %20, %21
  %23 = icmp slt i32 %15, %22
  br i1 %23, label %24, label %127

24:                                               ; preds = %14
  %25 = load ptr, ptr %8, align 8
  %26 = load i32, ptr %10, align 4
  %27 = sext i32 %26 to i64
  %28 = getelementptr inbounds i32, ptr %25, i64 %27
  %29 = load i32, ptr %28, align 4
  %30 = icmp eq i32 %29, 0
  br i1 %30, label %31, label %123

31:                                               ; preds = %24
  store i32 1, ptr %11, align 4
  br label %32

32:                                               ; preds = %119, %31
  %33 = load i32, ptr %11, align 4
  %34 = load i32, ptr %7, align 4
  %35 = icmp sle i32 %33, %34
  br i1 %35, label %36, label %122

36:                                               ; preds = %32
  %37 = load i32, ptr %10, align 4
  store i32 %37, ptr %12, align 4
  br label %38

38:                                               ; preds = %89, %36
  %39 = load i32, ptr %12, align 4
  %40 = load i32, ptr %6, align 4
  %41 = load i32, ptr %6, align 4
  %42 = mul nsw i32 %40, %41
  %43 = load i32, ptr %6, align 4
  %44 = mul nsw i32 %42, %43
  %45 = load i32, ptr %6, align 4
  %46 = mul nsw i32 %44, %45
  %47 = load i32, ptr %6, align 4
  %48 = mul nsw i32 %46, %47
  %49 = load i32, ptr %6, align 4
  %50 = mul nsw i32 %48, %49
  %51 = load i32, ptr %6, align 4
  %52 = mul nsw i32 %50, %51
  %53 = load i32, ptr %6, align 4
  %54 = mul nsw i32 %52, %53
  %55 = icmp slt i32 %39, %54
  br i1 %55, label %56, label %99

56:                                               ; preds = %38
  %57 = load ptr, ptr %9, align 8
  %58 = load i32, ptr %12, align 4
  %59 = sext i32 %58 to i64
  %60 = getelementptr inbounds i8, ptr %57, i64 %59
  %61 = load i8, ptr %60, align 1
  %62 = trunc i8 %61 to i1
  br i1 %62, label %63, label %64

63:                                               ; preds = %56
  br label %64

64:                                               ; preds = %63, %56
  %65 = load ptr, ptr %9, align 8
  %66 = load i32, ptr %12, align 4
  %67 = sext i32 %66 to i64
  %68 = getelementptr inbounds i8, ptr %65, i64 %67
  %69 = load i8, ptr %68, align 1
  %70 = trunc i8 %69 to i1
  br i1 %70, label %71, label %88

71:                                               ; preds = %64
  %72 = load i32, ptr %11, align 4
  %73 = load ptr, ptr %8, align 8
  %74 = load i32, ptr %12, align 4
  %75 = load i32, ptr %6, align 4
  %76 = load i32, ptr %6, align 4
  %77 = mul nsw i32 %75, %76
  %78 = load i32, ptr %6, align 4
  %79 = mul nsw i32 %77, %78
  %80 = load i32, ptr %6, align 4
  %81 = mul nsw i32 %79, %80
  %82 = sdiv i32 %74, %81
  %83 = sext i32 %82 to i64
  %84 = getelementptr inbounds i32, ptr %73, i64 %83
  %85 = load i32, ptr %84, align 4
  %86 = icmp eq i32 %72, %85
  br i1 %86, label %87, label %88

87:                                               ; preds = %71
  br label %118

88:                                               ; preds = %71, %64
  br label %89

89:                                               ; preds = %88
  %90 = load i32, ptr %6, align 4
  %91 = load i32, ptr %6, align 4
  %92 = mul nsw i32 %90, %91
  %93 = load i32, ptr %6, align 4
  %94 = mul nsw i32 %92, %93
  %95 = load i32, ptr %6, align 4
  %96 = mul nsw i32 %94, %95
  %97 = load i32, ptr %12, align 4
  %98 = add nsw i32 %97, %96
  store i32 %98, ptr %12, align 4
  br label %38, !llvm.loop !18

99:                                               ; preds = %38
  %100 = load i32, ptr %11, align 4
  %101 = load ptr, ptr %8, align 8
  %102 = load i32, ptr %10, align 4
  %103 = sext i32 %102 to i64
  %104 = getelementptr inbounds i32, ptr %101, i64 %103
  store i32 %100, ptr %104, align 4
  %105 = load i32, ptr %6, align 4
  %106 = load ptr, ptr %8, align 8
  call void @print_sudoku(i32 noundef %105, ptr noundef %106)
  %107 = load i32, ptr %6, align 4
  %108 = load i32, ptr %7, align 4
  %109 = load ptr, ptr %8, align 8
  %110 = load ptr, ptr %9, align 8
  %111 = call zeroext i1 @coloring(i32 noundef %107, i32 noundef %108, ptr noundef %109, ptr noundef %110)
  br i1 %111, label %112, label %113

112:                                              ; preds = %99
  store i1 true, ptr %5, align 1
  br label %151

113:                                              ; preds = %99
  %114 = load ptr, ptr %8, align 8
  %115 = load i32, ptr %10, align 4
  %116 = sext i32 %115 to i64
  %117 = getelementptr inbounds i32, ptr %114, i64 %116
  store i32 0, ptr %117, align 4
  br label %118

118:                                              ; preds = %113, %87
  br label %119

119:                                              ; preds = %118
  %120 = load i32, ptr %11, align 4
  %121 = add nsw i32 %120, 1
  store i32 %121, ptr %11, align 4
  br label %32, !llvm.loop !19

122:                                              ; preds = %32
  br label %127

123:                                              ; preds = %24
  br label %124

124:                                              ; preds = %123
  %125 = load i32, ptr %10, align 4
  %126 = add nsw i32 %125, 1
  store i32 %126, ptr %10, align 4
  br label %14, !llvm.loop !20

127:                                              ; preds = %122, %14
  store i32 0, ptr %13, align 4
  br label %128

128:                                              ; preds = %147, %127
  %129 = load i32, ptr %13, align 4
  %130 = load i32, ptr %6, align 4
  %131 = load i32, ptr %6, align 4
  %132 = mul nsw i32 %130, %131
  %133 = load i32, ptr %6, align 4
  %134 = mul nsw i32 %132, %133
  %135 = load i32, ptr %6, align 4
  %136 = mul nsw i32 %134, %135
  %137 = icmp slt i32 %129, %136
  br i1 %137, label %138, label %150

138:                                              ; preds = %128
  %139 = load ptr, ptr %8, align 8
  %140 = load i32, ptr %13, align 4
  %141 = sext i32 %140 to i64
  %142 = getelementptr inbounds i32, ptr %139, i64 %141
  %143 = load i32, ptr %142, align 4
  %144 = icmp eq i32 %143, 0
  br i1 %144, label %145, label %146

145:                                              ; preds = %138
  store i1 false, ptr %5, align 1
  br label %151

146:                                              ; preds = %138
  br label %147

147:                                              ; preds = %146
  %148 = load i32, ptr %13, align 4
  %149 = add nsw i32 %148, 1
  store i32 %149, ptr %13, align 4
  br label %128, !llvm.loop !21

150:                                              ; preds = %128
  store i1 true, ptr %5, align 1
  br label %151

151:                                              ; preds = %150, %145, %112
  %152 = load i1, ptr %5, align 1
  ret i1 %152
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define zeroext i1 @test(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca ptr, align 8
  %4 = alloca i64, align 8
  %5 = alloca i64, align 8
  %6 = alloca i32, align 4
  %7 = alloca i8, align 1
  %8 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %9 = load i32, ptr %2, align 4
  %10 = load i32, ptr %2, align 4
  %11 = mul nsw i32 %9, %10
  %12 = load i32, ptr %2, align 4
  %13 = mul nsw i32 %11, %12
  %14 = load i32, ptr %2, align 4
  %15 = mul nsw i32 %13, %14
  %16 = zext i32 %15 to i64
  ;%17 = call ptr @llvm.stacksave()
  %17 = add i32 0, 0
  store i32 %17, ptr %3, align 8
  %18 = alloca i32, i64 %16, align 16
  store i64 %16, ptr %4, align 8
  %19 = load i32, ptr %2, align 4
  %20 = load i32, ptr %2, align 4
  %21 = mul nsw i32 %19, %20
  %22 = load i32, ptr %2, align 4
  %23 = mul nsw i32 %21, %22
  %24 = load i32, ptr %2, align 4
  %25 = mul nsw i32 %23, %24
  %26 = load i32, ptr %2, align 4
  %27 = mul nsw i32 %25, %26
  %28 = load i32, ptr %2, align 4
  %29 = mul nsw i32 %27, %28
  %30 = load i32, ptr %2, align 4
  %31 = mul nsw i32 %29, %30
  %32 = load i32, ptr %2, align 4
  %33 = mul nsw i32 %31, %32
  %34 = zext i32 %33 to i64
  %35 = alloca i8, i64 %34, align 16
  store i64 %34, ptr %5, align 8
  %36 = load i32, ptr %2, align 4
  call void @init_sudoku(i32 noundef %36, ptr noundef %18, ptr noundef %35)
  store i32 0, ptr %6, align 4
  br label %37

37:                                               ; preds = %88, %1
  %38 = load i32, ptr %6, align 4
  %39 = load i32, ptr %2, align 4
  %40 = load i32, ptr %2, align 4
  %41 = mul nsw i32 %39, %40
  %42 = load i32, ptr %2, align 4
  %43 = mul nsw i32 %41, %42
  %44 = load i32, ptr %2, align 4
  %45 = mul nsw i32 %43, %44
  %46 = icmp slt i32 %38, %45
  br i1 %46, label %47, label %91

47:                                               ; preds = %37
  %48 = call i32 @getchar()
  %49 = trunc i32 %48 to i8
  store i8 %49, ptr %7, align 1
  store i32 0, ptr %8, align 4
  %50 = load i8, ptr %7, align 1
  %51 = sext i8 %50 to i32
  %52 = icmp sle i32 49, %51
  br i1 %52, label %53, label %57

53:                                               ; preds = %47
  %54 = load i8, ptr %7, align 1
  %55 = sext i8 %54 to i32
  %56 = icmp sle i32 %55, 57
  br i1 %56, label %65, label %57

57:                                               ; preds = %53, %47
  %58 = load i8, ptr %7, align 1
  %59 = sext i8 %58 to i32
  %60 = icmp sle i32 97, %59
  br i1 %60, label %61, label %83

61:                                               ; preds = %57
  %62 = load i8, ptr %7, align 1
  %63 = sext i8 %62 to i32
  %64 = icmp sle i32 %63, 122
  br i1 %64, label %65, label %83

65:                                               ; preds = %61, %53
  %66 = load i8, ptr %7, align 1
  %67 = sext i8 %66 to i32
  %68 = icmp sle i32 49, %67
  br i1 %68, label %69, label %77

69:                                               ; preds = %65
  %70 = load i8, ptr %7, align 1
  %71 = sext i8 %70 to i32
  %72 = icmp sle i32 %71, 57
  br i1 %72, label %73, label %77

73:                                               ; preds = %69
  %74 = load i8, ptr %7, align 1
  %75 = sext i8 %74 to i32
  %76 = sub nsw i32 %75, 48
  store i32 %76, ptr %8, align 4
  br label %82

77:                                               ; preds = %69, %65
  %78 = load i8, ptr %7, align 1
  %79 = sext i8 %78 to i32
  %80 = sub nsw i32 %79, 97
  %81 = add nsw i32 %80, 10
  store i32 %81, ptr %8, align 4
  br label %82

82:                                               ; preds = %77, %73
  br label %83

83:                                               ; preds = %82, %61, %57
  %84 = load i32, ptr %8, align 4
  %85 = load i32, ptr %6, align 4
  %86 = sext i32 %85 to i64
  %87 = getelementptr inbounds i32, ptr %18, i64 %86
  store i32 %84, ptr %87, align 4
  br label %88

88:                                               ; preds = %83
  %89 = load i32, ptr %6, align 4
  %90 = add nsw i32 %89, 1
  store i32 %90, ptr %6, align 4
  br label %37, !llvm.loop !22

91:                                               ; preds = %37
  %92 = load i32, ptr %2, align 4
  call void @print_sudoku(i32 noundef %92, ptr noundef %18)
  %93 = load i32, ptr %2, align 4
  %94 = load i32, ptr %2, align 4
  %95 = load i32, ptr %2, align 4
  %96 = mul nsw i32 %94, %95
  %97 = call zeroext i1 @coloring(i32 noundef %93, i32 noundef %96, ptr noundef %18, ptr noundef %35)
  %98 = load ptr, ptr %3, align 8
  ;call void @llvm.stackrestore(ptr %98)
  ret i1 %97
}

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare ptr @llvm.stacksave() #2

declare i32 @getchar() #1

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.stackrestore(ptr) #2

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @main(i32 noundef %0, ptr noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca ptr, align 8
  store i32 0, ptr %3, align 4
  store i32 %0, ptr %4, align 4
  store ptr %1, ptr %5, align 8
  %6 = load ptr, ptr %5, align 8
  %7 = getelementptr inbounds ptr, ptr %6, i64 1
  %8 = load ptr, ptr %7, align 8
  %9 = call i32 @atoi(ptr noundef %8)
  %10 = call zeroext i1 @test(i32 noundef %9)
  %11 = xor i1 %10, true
  %12 = zext i1 %11 to i32
  ret i32 %12
}

declare i32 @atoi(ptr noundef) #1

attributes #0 = { noinline nounwind optnone ssp uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cmov,+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cmov,+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "tune-cpu"="generic" }
attributes #2 = { nocallback nofree nosync nounwind willreturn }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 2}
!3 = !{i32 7, !"frame-pointer", i32 2}
!4 = !{!"Homebrew clang version 17.0.6"}
!5 = distinct !{!5, !6}
!6 = !{!"llvm.loop.mustprogress"}
!7 = distinct !{!7, !6}
!8 = distinct !{!8, !6}
!9 = distinct !{!9, !6}
!10 = distinct !{!10, !6}
!11 = distinct !{!11, !6}
!12 = distinct !{!12, !6}
!13 = distinct !{!13, !6}
!14 = distinct !{!14, !6}
!15 = distinct !{!15, !6}
!16 = distinct !{!16, !6}
!17 = distinct !{!17, !6}
!18 = distinct !{!18, !6}
!19 = distinct !{!19, !6}
!20 = distinct !{!20, !6}
!21 = distinct !{!21, !6}
!22 = distinct !{!22, !6}
