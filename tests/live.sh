#!/usr/bin/env bash
#
for i in $(seq 0 $1); do
	j=$((2 ** $i))
	./tests/live.py $j >"./tests/live$j.ll"
	echo "  |> t \"tests/live$j.ll\" [] (* ./tests/live.py $j *)"
	echo "  |> t \"tests/live$j.ll\" [ \"2\" ] (* ./tests/live.py $j *)"
	echo "  |> t \"tests/live$j.ll\" [ \"2\"; \"3\" ] (* ./tests/live.py $j *)"
	echo "  |> t \"tests/live$j.ll\" [ \"2\"; \"3\"; \"4\" ] (* ./tests/live.py $j *)"
done
