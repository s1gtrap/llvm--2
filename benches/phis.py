#!/usr/bin/env python3

import sys

n = int(sys.argv[1])
phis = int(sys.argv[2])
j = 0


def phi(ops, ty="i32"):
    return "phi " + ty + " " + ", ".join([f"[{op}, {lbl}]" for op, lbl in ops])


print("@.str = global [4 x i8] c\"%d\\0A\\00\"")
print("declare i32 @printf(i8*, ...)")
print()
print("define i32 @main() {")
print("0:")
for i in range(0, phis):
    print(f"  %{i + 1} = add i32 {j}, {j + 1}")
    j += 2

print(f"  br label %{phis + 1}")
print(f"{phis + 1}:")
print(f"  %{phis + 2} =",
      phi([("0", "%0"), (f"%{phis * 3 + 3}", f"%{phis + 1}")]))

for i in range(0, phis):
    print(f"  %{i + phis + 3} =",
          phi([(f"%{i + 1}", "%0"), (f"%{i + phis + 3}", f"%{phis + 1}")]))

for i in range(0, phis):
    print(f"  ;call void @printf (i8* @.str, i32 %{i + phis + 3})")


for i in range(0, phis):
    print(f"  %{i + 2*phis + 3} = add i32 %{i + phis + 3}, %{2*phis + 2 - i}")


for i in range(0, phis):
    print(f"  ;call void @printf (i8* @.str, i32 %{i + 2*phis + 3})")

print(f"  %{phis * 3 + 3} = add i32 %{phis + 2}, 1")
print(f"  %{phis * 3 + 4} = icmp eq i32 %{phis * 3 + 3}, {n}")
print(f"  br i1 %{phis * 3 + 4}, label %{phis * 3 + 5}, label %{phis + 1}")
print(f"{phis * 3 + 5}:")
print("  ret i32 0")
print("}")
