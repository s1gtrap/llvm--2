#!/usr/bin/env bash

for f in $(find tests -name '*.ll'); do
	dir=$(dirname $f)
	exp=$(basename $f .ll)
	codef="$dir/$exp.exp-exit"
	g=$(./tigerx86.sh $f | tail -n1 | awk '{print $NF}')
	$g
	code=$?
	printf "$f ... "
	if [ -f $codef ]; then
		expcode=$(cat "$codef")
		if [ "$code" -eq "$expcode" ]; then
			echo "ok!"
		else
			echo "failed! $code != $expcode"
		fi
	fi
done
