#!/usr/bin/env bash

for exp in $(seq 0 10); do
	#./benches/phis.py "$1" "$((2 ** $exp))" >"./benches/phis$((2 ** $exp)).ll"
	./benches/phis.py "$1" "$exp" >"./benches/phis$exp.ll"
done
