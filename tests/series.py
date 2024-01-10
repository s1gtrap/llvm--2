#!/usr/bin/env python3

import sys

n = int(sys.argv[1])

print("define i32 @main (i32 %0, i8* %1) {")
print(f"  %3 = add i32 %0, 1")
for i in range(0, n):
    print(f"  %{i + 4} = add i32 %0, %{i + 3}")
print(f"  ret i32 %{n + 3}")
print("}")
