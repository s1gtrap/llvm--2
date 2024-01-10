#!/usr/bin/env bash
#
for i in $(seq $1); do
	j=$((2 ** $i))
	./tests/live.py $j >"./tests/live$j.ll"
	echo "  |> t \"tests/live$j.ll\" [] (* ./tests/live.py $j *)"
done
