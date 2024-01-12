declare void @abort()

define i32 @test1 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = sdiv i32 %3, -10
 %5 = icmp eq i32 %4, 2
 %6 = zext i1 %5 to i32
 ret i32 %6
}

define i32 @test2 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = sdiv i32 %3, -10
 %5 = icmp eq i32 %4, 0
 %6 = zext i1 %5 to i32
 ret i32 %6
}

define i32 @test3 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = sdiv i32 %3, -10
 %5 = icmp ne i32 %4, 2
 %6 = zext i1 %5 to i32
 ret i32 %6
}

define i32 @test4 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = sdiv i32 %3, -10
 %5 = icmp ne i32 %4, 0
 %6 = zext i1 %5 to i32
 ret i32 %6
}

define i32 @test5 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = sdiv i32 %3, -10
 %5 = icmp slt i32 %4, 2
 %6 = zext i1 %5 to i32
 ret i32 %6
}

define i32 @test6 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = sdiv i32 %3, -10
 %5 = icmp slt i32 %4, 0
 %6 = zext i1 %5 to i32
 ret i32 %6
}

define i32 @test7 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = sdiv i32 %3, -10
 %5 = icmp sle i32 %4, 2
 %6 = zext i1 %5 to i32
 ret i32 %6
}

define i32 @test8 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = sdiv i32 %3, -10
 %5 = icmp sle i32 %4, 0
 %6 = zext i1 %5 to i32
 ret i32 %6
}

define i32 @test9 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = sdiv i32 %3, -10
 %5 = icmp sgt i32 %4, 2
 %6 = zext i1 %5 to i32
 ret i32 %6
}

define i32 @test10 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = sdiv i32 %3, -10
 %5 = icmp sgt i32 %4, 0
 %6 = zext i1 %5 to i32
 ret i32 %6
}

define i32 @test11 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = sdiv i32 %3, -10
 %5 = icmp sge i32 %4, 2
 %6 = zext i1 %5 to i32
 ret i32 %6
}

define i32 @test12 (i32 %0) {
 %2 = alloca i32
 store i32 %0, i32* %2
 %3 = load i32, i32* %2
 %4 = sdiv i32 %3, -10
 %5 = icmp sge i32 %4, 0
 %6 = zext i1 %5 to i32
 ret i32 %6
}

define i32 @main () {
 %1 = alloca i32
 store i32 0, i32* %1
 %2 = call i32 @test1 (i32 -30)
 %3 = icmp ne i32 %2, 0
 br i1 %3, label %4, label %5
4:
 call void @abort ()
 unreachable
5:
 %6 = call i32 @test1 (i32 -29)
 %7 = icmp ne i32 %6, 1
 br i1 %7, label %8, label %9
8:
 call void @abort ()
 unreachable
9:
 %10 = call i32 @test1 (i32 -20)
 %11 = icmp ne i32 %10, 1
 br i1 %11, label %12, label %13
12:
 call void @abort ()
 unreachable
13:
 %14 = call i32 @test1 (i32 -19)
 %15 = icmp ne i32 %14, 0
 br i1 %15, label %16, label %17
16:
 call void @abort ()
 unreachable
17:
 %18 = call i32 @test2 (i32 0)
 %19 = icmp ne i32 %18, 1
 br i1 %19, label %20, label %21
20:
 call void @abort ()
 unreachable
21:
 %22 = call i32 @test2 (i32 9)
 %23 = icmp ne i32 %22, 1
 br i1 %23, label %24, label %25
24:
 call void @abort ()
 unreachable
25:
 %26 = call i32 @test2 (i32 10)
 %27 = icmp ne i32 %26, 0
 br i1 %27, label %28, label %29
28:
 call void @abort ()
 unreachable
29:
 %30 = call i32 @test2 (i32 -1)
 %31 = icmp ne i32 %30, 1
 br i1 %31, label %32, label %33
32:
 call void @abort ()
 unreachable
33:
 %34 = call i32 @test2 (i32 -9)
 %35 = icmp ne i32 %34, 1
 br i1 %35, label %36, label %37
36:
 call void @abort ()
 unreachable
37:
 %38 = call i32 @test2 (i32 -10)
 %39 = icmp ne i32 %38, 0
 br i1 %39, label %40, label %41
40:
 call void @abort ()
 unreachable
41:
 %42 = call i32 @test3 (i32 -30)
 %43 = icmp ne i32 %42, 1
 br i1 %43, label %44, label %45
44:
 call void @abort ()
 unreachable
45:
 %46 = call i32 @test3 (i32 -29)
 %47 = icmp ne i32 %46, 0
 br i1 %47, label %48, label %49
48:
 call void @abort ()
 unreachable
49:
 %50 = call i32 @test3 (i32 -20)
 %51 = icmp ne i32 %50, 0
 br i1 %51, label %52, label %53
52:
 call void @abort ()
 unreachable
53:
 %54 = call i32 @test3 (i32 -19)
 %55 = icmp ne i32 %54, 1
 br i1 %55, label %56, label %57
56:
 call void @abort ()
 unreachable
57:
 %58 = call i32 @test4 (i32 0)
 %59 = icmp ne i32 %58, 0
 br i1 %59, label %60, label %61
60:
 call void @abort ()
 unreachable
61:
 %62 = call i32 @test4 (i32 9)
 %63 = icmp ne i32 %62, 0
 br i1 %63, label %64, label %65
64:
 call void @abort ()
 unreachable
65:
 %66 = call i32 @test4 (i32 10)
 %67 = icmp ne i32 %66, 1
 br i1 %67, label %68, label %69
68:
 call void @abort ()
 unreachable
69:
 %70 = call i32 @test4 (i32 -1)
 %71 = icmp ne i32 %70, 0
 br i1 %71, label %72, label %73
72:
 call void @abort ()
 unreachable
73:
 %74 = call i32 @test4 (i32 -9)
 %75 = icmp ne i32 %74, 0
 br i1 %75, label %76, label %77
76:
 call void @abort ()
 unreachable
77:
 %78 = call i32 @test4 (i32 -10)
 %79 = icmp ne i32 %78, 1
 br i1 %79, label %80, label %81
80:
 call void @abort ()
 unreachable
81:
 %82 = call i32 @test5 (i32 -30)
 %83 = icmp ne i32 %82, 0
 br i1 %83, label %84, label %85
84:
 call void @abort ()
 unreachable
85:
 %86 = call i32 @test5 (i32 -29)
 %87 = icmp ne i32 %86, 0
 br i1 %87, label %88, label %89
88:
 call void @abort ()
 unreachable
89:
 %90 = call i32 @test5 (i32 -20)
 %91 = icmp ne i32 %90, 0
 br i1 %91, label %92, label %93
92:
 call void @abort ()
 unreachable
93:
 %94 = call i32 @test5 (i32 -19)
 %95 = icmp ne i32 %94, 1
 br i1 %95, label %96, label %97
96:
 call void @abort ()
 unreachable
97:
 %98 = call i32 @test6 (i32 0)
 %99 = icmp ne i32 %98, 0
 br i1 %99, label %100, label %101
100:
 call void @abort ()
 unreachable
101:
 %102 = call i32 @test6 (i32 9)
 %103 = icmp ne i32 %102, 0
 br i1 %103, label %104, label %105
104:
 call void @abort ()
 unreachable
105:
 %106 = call i32 @test6 (i32 10)
 %107 = icmp ne i32 %106, 1
 br i1 %107, label %108, label %109
108:
 call void @abort ()
 unreachable
109:
 %110 = call i32 @test6 (i32 -1)
 %111 = icmp ne i32 %110, 0
 br i1 %111, label %112, label %113
112:
 call void @abort ()
 unreachable
113:
 %114 = call i32 @test6 (i32 -9)
 %115 = icmp ne i32 %114, 0
 br i1 %115, label %116, label %117
116:
 call void @abort ()
 unreachable
117:
 %118 = call i32 @test6 (i32 -10)
 %119 = icmp ne i32 %118, 0
 br i1 %119, label %120, label %121
120:
 call void @abort ()
 unreachable
121:
 %122 = call i32 @test7 (i32 -30)
 %123 = icmp ne i32 %122, 0
 br i1 %123, label %124, label %125
124:
 call void @abort ()
 unreachable
125:
 %126 = call i32 @test7 (i32 -29)
 %127 = icmp ne i32 %126, 1
 br i1 %127, label %128, label %129
128:
 call void @abort ()
 unreachable
129:
 %130 = call i32 @test7 (i32 -20)
 %131 = icmp ne i32 %130, 1
 br i1 %131, label %132, label %133
132:
 call void @abort ()
 unreachable
133:
 %134 = call i32 @test7 (i32 -19)
 %135 = icmp ne i32 %134, 1
 br i1 %135, label %136, label %137
136:
 call void @abort ()
 unreachable
137:
 %138 = call i32 @test8 (i32 0)
 %139 = icmp ne i32 %138, 1
 br i1 %139, label %140, label %141
140:
 call void @abort ()
 unreachable
141:
 %142 = call i32 @test8 (i32 9)
 %143 = icmp ne i32 %142, 1
 br i1 %143, label %144, label %145
144:
 call void @abort ()
 unreachable
145:
 %146 = call i32 @test8 (i32 10)
 %147 = icmp ne i32 %146, 1
 br i1 %147, label %148, label %149
148:
 call void @abort ()
 unreachable
149:
 %150 = call i32 @test8 (i32 -1)
 %151 = icmp ne i32 %150, 1
 br i1 %151, label %152, label %153
152:
 call void @abort ()
 unreachable
153:
 %154 = call i32 @test8 (i32 -9)
 %155 = icmp ne i32 %154, 1
 br i1 %155, label %156, label %157
156:
 call void @abort ()
 unreachable
157:
 %158 = call i32 @test8 (i32 -10)
 %159 = icmp ne i32 %158, 0
 br i1 %159, label %160, label %161
160:
 call void @abort ()
 unreachable
161:
 %162 = call i32 @test9 (i32 -30)
 %163 = icmp ne i32 %162, 1
 br i1 %163, label %164, label %165
164:
 call void @abort ()
 unreachable
165:
 %166 = call i32 @test9 (i32 -29)
 %167 = icmp ne i32 %166, 0
 br i1 %167, label %168, label %169
168:
 call void @abort ()
 unreachable
169:
 %170 = call i32 @test9 (i32 -20)
 %171 = icmp ne i32 %170, 0
 br i1 %171, label %172, label %173
172:
 call void @abort ()
 unreachable
173:
 %174 = call i32 @test9 (i32 -19)
 %175 = icmp ne i32 %174, 0
 br i1 %175, label %176, label %177
176:
 call void @abort ()
 unreachable
177:
 %178 = call i32 @test10 (i32 0)
 %179 = icmp ne i32 %178, 0
 br i1 %179, label %180, label %181
180:
 call void @abort ()
 unreachable
181:
 %182 = call i32 @test10 (i32 9)
 %183 = icmp ne i32 %182, 0
 br i1 %183, label %184, label %185
184:
 call void @abort ()
 unreachable
185:
 %186 = call i32 @test10 (i32 10)
 %187 = icmp ne i32 %186, 0
 br i1 %187, label %188, label %189
188:
 call void @abort ()
 unreachable
189:
 %190 = call i32 @test10 (i32 -1)
 %191 = icmp ne i32 %190, 0
 br i1 %191, label %192, label %193
192:
 call void @abort ()
 unreachable
193:
 %194 = call i32 @test10 (i32 -9)
 %195 = icmp ne i32 %194, 0
 br i1 %195, label %196, label %197
196:
 call void @abort ()
 unreachable
197:
 %198 = call i32 @test10 (i32 -10)
 %199 = icmp ne i32 %198, 1
 br i1 %199, label %200, label %201
200:
 call void @abort ()
 unreachable
201:
 %202 = call i32 @test11 (i32 -30)
 %203 = icmp ne i32 %202, 1
 br i1 %203, label %204, label %205
204:
 call void @abort ()
 unreachable
205:
 %206 = call i32 @test11 (i32 -29)
 %207 = icmp ne i32 %206, 1
 br i1 %207, label %208, label %209
208:
 call void @abort ()
 unreachable
209:
 %210 = call i32 @test11 (i32 -20)
 %211 = icmp ne i32 %210, 1
 br i1 %211, label %212, label %213
212:
 call void @abort ()
 unreachable
213:
 %214 = call i32 @test11 (i32 -19)
 %215 = icmp ne i32 %214, 0
 br i1 %215, label %216, label %217
216:
 call void @abort ()
 unreachable
217:
 %218 = call i32 @test12 (i32 0)
 %219 = icmp ne i32 %218, 1
 br i1 %219, label %220, label %221
220:
 call void @abort ()
 unreachable
221:
 %222 = call i32 @test12 (i32 9)
 %223 = icmp ne i32 %222, 1
 br i1 %223, label %224, label %225
224:
 call void @abort ()
 unreachable
225:
 %226 = call i32 @test12 (i32 10)
 %227 = icmp ne i32 %226, 0
 br i1 %227, label %228, label %229
228:
 call void @abort ()
 unreachable
229:
 %230 = call i32 @test12 (i32 -1)
 %231 = icmp ne i32 %230, 1
 br i1 %231, label %232, label %233
232:
 call void @abort ()
 unreachable
233:
 %234 = call i32 @test12 (i32 -9)
 %235 = icmp ne i32 %234, 1
 br i1 %235, label %236, label %237
236:
 call void @abort ()
 unreachable
237:
 %238 = call i32 @test12 (i32 -10)
 %239 = icmp ne i32 %238, 1
 br i1 %239, label %240, label %241
240:
 call void @abort ()
 unreachable
241:
 ret i32 0
}
