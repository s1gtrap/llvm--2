#!/usr/bin/env bash
#
for i in $(seq 0 $1); do
	j=$((2 ** $i))
	./tests/chain.py $j >"./tests/series$j.ll"
	echo "  |> t \"tests/series$j.ll\" [] (* ./tests/series.py $j *)"
	echo "  |> t \"tests/series$j.ll\" [ \"2\" ] (* ./tests/series.py $j *)"
	echo "  |> t \"tests/series$j.ll\" [ \"2\"; \"3\" ] (* ./tests/series.py $j *)"
	echo "  |> t \"tests/series$j.ll\" [ \"2\"; \"3\"; \"4\" ] (* ./tests/series.py $j *)"
done
