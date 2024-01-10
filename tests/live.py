#!/usr/bin/env python3

import sys

n = int(sys.argv[1])

print("define i32 @main (i32 %0, i8* %1) {")
print(f"  %3 = add i32 %0, 1")
for i in range(0, n):
    print(f"  %{i + 4} = add i32 %{i + 3}, {i + 2}")
for i in range(0, n + 1):
    print(f"  %{n + i + 4} = add i32 %{(n - i) + 3}, {i + n + 2}")
print(f"  ret i32 %{n*2 + 4}")
print("}")
