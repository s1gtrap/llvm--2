#!/usr/bin/env python3

from enum import Enum
import sys

class Bop(Enum):
    ADD = 1
    SUB = 2
    MUL = 3
    SHL = 4
    LSHR = 5
    ASHR = 6
    AND = 7
    OR = 8
    XOR = 9
    SDIV = 10
    SREM = 11
    UDIV = 12
    UREM = 13

    def __str__(self):
        match self:
            case Bop.ADD:
                return "+"
            case Bop.SUB:
                return "-"
            case Bop.MUL:
                return "*"
            case Bop.SHL:
                return "<<"
            case Bop.LSHR:
                return ">>"
            case Bop.ASHR:
                return "ashr"
            case Bop.AND:
                return "&"
            case Bop.OR:
                return "|"
            case Bop.XOR:
                return "^"
            case Bop.SDIV:
                return "/"
            case Bop.SREM:
                return "%"
            case Bop.UDIV:
                return "udiv"
            case Bop.UREM:
                return "urem"

    def apply(self, t1, o1, t2, o2):
        match self:
            case Bop.ADD:
                return (o1 + o2)
            case Bop.SUB:
                return (o1 - o2)
            case Bop.MUL:
                return (o1 * o2)
            case Bop.SHL:
                return (o1 << o2)
            case Bop.LSHR:
                return (o1 >> o2) # FIXME
            case Bop.ASHR:
                return (o1 >> o2) # FIXME
            case Bop.AND:
                return (o1 & o2)
            case Bop.OR:
                return (o1 | o2)
            case Bop.XOR:
                return (o1 ^ o2)
            case Bop.SDIV:
                return (o1 / o2) # FIXME
            case Bop.SREM:
                return (o1 % o2) # FIXME
            case Bop.UDIV:
                return (o1 / o2) # FIXME
            case Bop.UREM:
                return (o1 % o2) # FIXME

class Cnd(Enum):
    EQ = 1
    NE = 2
    SLT = 3
    SLE = 4
    SGT = 5
    SGE = 6
    ULT = 7
    ULE = 8
    UGT = 9
    UGE = 10

    def __str__(self):
        match self:
            case Cnd.EQ:
                return "eq"
            case Cnd.NE:
                return "ne"
            case Cnd.SLT:
                return "slt"
            case Cnd.SLE:
                return "sle"
            case Cnd.SGT:
                return "sgt"
            case Cnd.SGE:
                return "sge"
            case Cnd.ULT:
                return "ult"
            case Cnd.ULE:
                return "ule"
            case Cnd.UGT:
                return "ugt"
            case Cnd.UGE:
                return "uge"



class Ty(Enum):
    I8 = 1
    I16 = 2
    I32 = 3
    I64 = 4

    def __str__(self):
        match self:
            case Ty.I8:
                return "%hhd"
            case Ty.I16:
                return "%hd"
            case Ty.I32:
                return "%ld"
            case Ty.I64:
                return "%lld"

    def size(self):
        match self:
            case Ty.I8:
                return 8
            case Ty.I16:
                return 16
            case Ty.I32:
                return 32
            case Ty.I64:
                return 64
            case other:
                return 9

    def umax(self):
        return 2 ** self.size() - 1

    def smax(self):
        return 2 ** (self.size() - 1) - 1


bop = Bop[sys.argv[1].upper()]
ty1 = Ty[sys.argv[2].upper()]
ty2 = ty1 # Ty[sys.argv[3].upper()]

def eqstr(ty1, bop, ty2, cnd):
    str = f"{ty1} {bop} {ty2} {cnd} {ty1}"
    return f"global [{len(str) + 2} x i8] c\"{str}\\0A\\00\""

def assertbop(ty1, op1, bop, ty2, op2):
    op3 = bop.apply(ty1, op1, ty2, op2) & ty1.umax()
    return f" call void @assert ({ty1.name.lower()} {op1}, {ty2.name.lower()} {op2}, {ty1.name.lower()} {op3})"

print("@.str =", eqstr(ty1, bop, ty2, "!="))
print("@.str.1 =", eqstr(ty1, bop, ty2, "=="))
print()
print("declare i32 @printf(i8*, ...)")
print()
print(f"define void @assert ({ty1.name.lower()} %0, {ty2.name.lower()} %1, {ty1.name.lower()} %2) {{")
print(f" %4 = {bop.name.lower()} {ty1.name.lower()} %0, %1")
print(f" %5 = icmp eq {ty1.name.lower()} %2, %4")
print(f" %6 = select i1 %5, i8* @.str.1, i8* @.str")
print(f" call i32 (i8*, ...) @printf (i8* %6, {ty1.name.lower()} %0, {ty2.name.lower()} %1, {ty1.name.lower()} %2)")
print(f" ret void")
print(f"}}")
print()
print(f"define i32 @main (i32 %0, i8* %1) {{")
print(assertbop(ty1, 0, bop, ty2, 0))
print(assertbop(ty1, 1, bop, ty2, 0))
print(assertbop(ty1, 0, bop, ty2, 1))
print(assertbop(ty1, 1, bop, ty2, 1))
print(assertbop(ty1, 1, bop, ty2, 2))
print(assertbop(ty1, 1, bop, ty2, 2))
for i in range(1, ty1.size()):
    for j in range(i, ty2.size()):
        print(assertbop(ty1, 2 ** i - 1, bop, ty2, 2 ** j - 1))
print(f" ret i32 0")
print(f"}}")
