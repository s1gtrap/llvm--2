#!/usr/bin/env python3

from enum import Enum
import sys

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
                return "i8"
            case Ty.I16:
                return "i16"
            case Ty.I32:
                return "i32"
            case Ty.I64:
                return "i64"

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


cnd = Cnd[sys.argv[1].upper()]
ty = Ty[sys.argv[2].upper()]

def eqstr(ty1, bop, ty2, cnd):
    str = f"{ty1} {bop} {ty2} {cnd} {ty1}"
    l = len(str.encode('utf-8').decode('unicode_escape'))
    return f"global [{l + 2} x i8] c\"{str}\\0A\\00\""

def assertbop(ty1, op1, bop, ty2, op2):
    if op2 == 0 and (bop == Bop.SDIV or bop == Bop.UDIV or bop == Bop.SREM or bop == Bop.UREM):
        return ""
    op3 = bop.apply(ty1, op1, ty2, op2) & ty1.umax()
    return f" call void @assert ({ty1.name.lower()} {op1}, {ty2.name.lower()} {op2}, {ty1.name.lower()} {op3})\n"

def atoi(ty, i, base=10):
    match ty:
        case Ty.I64:
            return f"call i64 @strtoull(i8* {i}, i8** null, i32 {base})"
        case other:
            raise ValueError("TODO")

print("declare i64 @strtoull (i8*, i8**, i32)")
print()
print("define i1 @main (i32 %0, i8* %1) {")
print(f"  %3 = getelementptr i8*, i8** %1, i64 1")
print(f"  %4 = load i8*, i8** %3")
print("  %5 =", atoi(ty, "%4"))
print(f"  %6 = getelementptr i8*, i8** %1, i64 2")
print(f"  %7 = load i8*, i8** %6")
print("  %8 =", atoi(ty, "%7"))
print(f"  %9 = icmp {cnd} {ty} %5, %8")
print("  ret i1 %9")
print("}")
