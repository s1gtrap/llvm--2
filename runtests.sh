#!/usr/bin/env bash

RED='\033[0;31m'
GREEN='\033[1;32m'
MUTED='\033[1;30m'
NC='\033[0m'

COUNT=0
PASSES=0
for f in $(find "${1:-tests}" -name '*.ll'); do
	COUNT=$((COUNT + 1))
	TESTDIR=$(dirname $f)
	TESTBASE=$(basename $f .ll)
	TESTCODEFILE="$TESTDIR/$TESTBASE.exp-exit"
	TESTSTDOUTFILE="$TESTDIR/$TESTBASE.exp-stdout"
	TESTSTDERRFILE="$TESTDIR/$TESTBASE.exp-stderr"
	TESTFILE=$("${2:-./buildx86.sh}" $f | tail -n1 | awk '{print $NF}')

	printf "$f ... "

	if [ -z "$TESTFILE" ]; then
		printf "${RED}failed!${NC} [$PASSES/$COUNT] ${MUTED}[ build ]${NC}\n"
		continue
	fi

	{
		IFS= read -r -s -d '' CAPTURED_STDERR
		IFS= read -r -s -d '' CAPTURED_EXIT
		IFS= read -r -s -d '' CAPTURED_STDOUT
	} < <((printf '\0%s\n\0' "$(
		timeout 5 $TESTFILE
		printf '\0%d' "${?}" 1>&2
	)" 1>&2) 2>&1)

	ASSERTS=0
	FAILURE=0

	if [ -f $TESTCODEFILE ]; then
		EXPECTED_EXIT=$(<$TESTCODEFILE)
		ASSERTS=$((ASSERTS | 1))
		if [ "$CAPTURED_EXIT" -ne "$EXPECTED_EXIT" ]; then
			FAILURE=$((FAILURE | 1))
		fi
	fi

	if [ -f $TESTSTDOUTFILE ]; then
		IFS= read -r -s -d '' EXPECTED_STDOUT <$TESTSTDOUTFILE
		ASSERTS=$((ASSERTS | 2))
		if [ "$CAPTURED_STDOUT" != "$EXPECTED_STDOUT" ]; then
			FAILURE=$((FAILURE | 2))
		fi
	fi

	if [ -f $TESTSTDERRFILE ]; then
		IFS= read -r -s -d '' EXPECTED_STDERR <$TESTSTDERRFILE
		ASSERTS=$((ASSERTS | 4))
		if [ "$CAPTURED_STDERR" != "$EXPECTED_STDERR" ]; then
			FAILURE=$((FAILURE | 4))
		fi
	fi

	if [ "$FAILURE" -eq "0" ]; then
		PASSES=$((PASSES + 1))
		printf "${GREEN}ok!${NC} [$PASSES/$COUNT] ${MUTED}[ build "
	else
		printf "${RED}failed!${NC} [$PASSES/$COUNT] ${MUTED}[ build "
	fi

	if [ $((ASSERTS & 1)) -eq 1 ]; then
		printf "exit "
	fi
	if [ $((ASSERTS & 2)) -eq 2 ]; then
		printf "stdout "
	fi
	if [ $((ASSERTS & 4)) -eq 4 ]; then
		printf "stderr "
	fi
	printf "]${NC}\n"

	if [ "$FAILURE" -ne "0" ]; then
		if [ $((FAILURE & 1)) -eq 1 ]; then
			echo "    exit code $CAPTURED_EXIT != $EXPECTED_EXIT"
		fi
		if [ $((FAILURE & 2)) -eq 2 ]; then
			printf "    stdout %q != %q\n" "${CAPTURED_STDOUT:0:100}" "${EXPECTED_STDOUT:0:100}"
		fi
		if [ $((FAILURE & 4)) -eq 4 ]; then
			printf "    stderr %q != %q\n" "${CAPTURED_STDERR:0:100}" "${EXPECTED_STDERR:0:100}"
		fi
	fi
done
