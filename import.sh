#!/usr/bin/env bash

for f in $(find tigertests -name '*.ll'); do
	TESTDIR=$(dirname $f)
	TESTBASE=$(basename $f .ll)
	TESTCODEFILE="$TESTDIR/$TESTBASE.exp-exit"
	TESTSTDOUTFILE="$TESTDIR/$TESTBASE.exp-stdout"
	TESTSTDERRFILE="$TESTDIR/$TESTBASE.exp-stderr"

	printf "(\"$f\", [\"tiger.c\"], [], ["

	if [ -f $TESTCODEFILE ]; then
		EXPECTED_EXIT=$(<$TESTCODEFILE)
		echo " Exit $EXPECTED_EXIT; "
	fi

	if [ -f $TESTSTDOUTFILE ]; then
		IFS= read -r -s -d '' EXPECTED_STDOUT <$TESTSTDOUTFILE
		echo " Stdout \"$EXPECTED_STDOUT\"; "
	fi

	if [ -f $TESTSTDERRFILE ]; then
		IFS= read -r -s -d '' EXPECTED_STDERR <$TESTSTDERRFILE
		echo " Stderr \"$EXPECTED_STDERR\"; "
	fi
	echo "]);"

done
