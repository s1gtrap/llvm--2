declare void @print_integer(i64)
declare i64 @read_integer()

define i64 @dolphin_main () {
 %m150 = alloca i1
 %l147 = alloca i1
 %k144 = alloca i1
 %j141 = alloca i1
 %i138 = alloca i1
 %h135 = alloca i1
 %g132 = alloca i1
 %f129 = alloca i1
 %e126 = alloca i64
 %d123 = alloca i64
 %c120 = alloca i64
 %b117 = alloca i64
 %a114 = alloca i64
 %tmp113 = add i64 5, 5
 store i64 %tmp113, i64* %a114
 %tmp116 = sub i64 15, 5
 store i64 %tmp116, i64* %b117
 %tmp119 = mul i64 5, 2
 store i64 %tmp119, i64* %c120
 %tmp122 = sdiv i64 20, 2
 store i64 %tmp122, i64* %d123
 %tmp125 = srem i64 110, 100
 store i64 %tmp125, i64* %e126
 %tmp128 = icmp slt i64 5, 10
 store i1 %tmp128, i1* %f129
 %tmp131 = icmp sle i64 5, 10
 store i1 %tmp131, i1* %g132
 %tmp134 = icmp sgt i64 5, 10
 store i1 %tmp134, i1* %h135
 %tmp137 = icmp sge i64 5, 10
 store i1 %tmp137, i1* %i138
 %tmp140 = icmp eq i64 5, 10
 store i1 %tmp140, i1* %j141
 %tmp143 = icmp ne i64 5, 10
 store i1 %tmp143, i1* %k144
 %tmp146 = icmp eq i64 1, 0
 store i1 %tmp146, i1* %l147
 %tmp149 = icmp ne i64 1, 0
 store i1 %tmp149, i1* %m150
 %temp152 = load i64, i64* %a114
 call void @print_integer (i64 %temp152)
 %temp155 = load i64, i64* %b117
 call void @print_integer (i64 %temp155)
 %temp158 = load i64, i64* %c120
 call void @print_integer (i64 %temp158)
 %temp161 = load i64, i64* %d123
 call void @print_integer (i64 %temp161)
 %temp164 = load i64, i64* %e126
 call void @print_integer (i64 %temp164)
 ret i64 0
}

