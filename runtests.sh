#!/usr/bin/env bash

RED='\033[0;31m'
GREEN='\033[1;32m'
NC='\033[0m'

for f in $(find tests -name '*.ll'); do
	TESTDIR=$(dirname $f)
	TESTBASE=$(basename $f .ll)
	TESTCODEFILE="$TESTDIR/$TESTBASE.exp-exit"
	TESTSTDOUTFILE="$TESTDIR/$TESTBASE.exp-stdout"
	TESTSTDERRFILE="$TESTDIR/$TESTBASE.exp-stderr"
	TESTFILE=$(./buildx86.sh $f | tail -n1 | awk '{print $NF}')

	printf "$f ... "

	if [ -z "$TESTFILE" ]; then
		printf "${RED}failed!${NC}\n"
		continue
	fi

	{
		IFS= read -r -s -d '' CAPTURED_STDERR
		IFS= read -r -s -d '' CAPTURED_EXIT
		IFS= read -r -s -d '' CAPTURED_STDOUT
	} < <((printf '\0%s\n\0' "$(
		$TESTFILE
		printf '\0%d' "${?}" 1>&2
	)" 1>&2) 2>&1)

	FAILURE=0

	if [ -f $TESTCODEFILE ]; then
		EXPECTED_EXIT=$(<$TESTCODEFILE)
		if [ "$CAPTURED_EXIT" -ne "$EXPECTED_EXIT" ]; then
			FAILURE=$((FAILURE | 1))
		fi
	fi

	if [ -f $TESTSTDOUTFILE ]; then
		IFS= read -r -s -d '' EXPECTED_STDOUT <$TESTSTDOUTFILE
		if [ "$CAPTURED_STDOUT" != "$EXPECTED_STDOUT" ]; then
			FAILURE=$((FAILURE | 2))
		fi
	fi

	if [ -f $TESTSTDERRFILE ]; then
		IFS= read -r -s -d '' EXPECTED_STDERR <$TESTSTDERRFILE
		if [ "$CAPTURED_STDERR" != "$EXPECTED_STDERR" ]; then
			FAILURE=$((FAILURE | 4))
		fi
	fi

	if [ "$FAILURE" -eq "0" ]; then
		printf "${GREEN}ok!${NC}\n"
	else
		printf "${RED}failed!${NC}\n"
		if [ $((FAILURE & 1)) -eq 1 ]; then
			echo "    exit code $CAPTURED_EXIT != $EXPECTED_EXIT"
		fi
		if [ $((FAILURE & 2)) -eq 2 ]; then
			echo "    stdout '$CAPTURED_STDOUT' != '$EXPECTED_STDOUT'"
		fi
		if [ $((FAILURE & 4)) -eq 4 ]; then
			echo "    stdout '$CAPTURED_STDERR' != '$EXPECTED_STDERR'"
		fi
	fi
done
