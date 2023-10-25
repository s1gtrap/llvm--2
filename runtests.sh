#!/usr/bin/env bash

RED='\033[0;31m'
GREEN='\033[1;32m'
NC='\033[0m'

for f in $(find tests -name '*.ll'); do
	dir=$(dirname $f)
	exp=$(basename $f .ll)
	codefile="$dir/$exp.exp-exit"
	stdoutfile="$dir/$exp.exp-stdout"
	g=$(./compile.sh $f | tail -n1 | awk '{print $NF}')
	printf "$f ... "
	{
		IFS= read -r -s -d '' CAPTURED_STDERR
		IFS= read -r -s -d '' CAPTURED_EXIT
		IFS= read -r -s -d '' CAPTURED_STDOUT
	} < <((printf '\0%s\n\0' "$(
		$g
		printf '\0%d' "${?}" 1>&2
	)" 1>&2) 2>&1)

	FAILURE=0

	if [ -f $codefile ]; then
		EXPECTED_EXIT=$(<$codefile)
		if [ "$CAPTURED_EXIT" -ne "$EXPECTED_EXIT" ]; then
			FAILURE=$((FAILURE | 1))
		fi
	fi

	if [ -f $stdoutfile ]; then
		IFS= read -r -s -d '' EXPECTED_STDOUT <$stdoutfile
		if [ "$CAPTURED_STDOUT" != "$EXPECTED_STDOUT" ]; then
			FAILURE=$((FAILURE | 2))
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
	fi
done
