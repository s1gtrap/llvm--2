#!/bin/sh
X86OUTDIR=_build/x86/
mkdir -p $X86OUTDIR
FILE=$(basename $1)
#TEMPFILE=`mktemp $X86OUTDIR$FILE.XXXXXXXX`
TEMPFILE=$X86OUTDIR$FILE
TEMPFILEX86=$TEMPFILE.s
# mv $TEMPFILE $TEMPFILEX86
_build/install/default/bin/llvm__2 -p prog -o x86 $1 >$TEMPFILEX86
if [ $? -ne 0 ]; then
	exit $?
fi
echo "ASM file generated at $TEMPFILEX86"
clang runtime.c $TEMPFILEX86 -o $TEMPFILE.out
echo "Out file generated at $TEMPFILE.out"
