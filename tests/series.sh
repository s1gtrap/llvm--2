#!/usr/bin/env bash
#
for i in $(seq $1); do
	j=$((2 ** $i))
	./tests/chain.py $j >"./tests/series$j.ll"
	echo "  |> t \"tests/series$j.ll\" [] (* ./tests/series-select.py $j *)"
done
