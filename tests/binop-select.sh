#!/usr/bin/env bash

for bop in add sub mul and or xor; do
	for ty in i8 i16 i32 i64; do
		echo "  |> t \"tests/${bop}${ty}.ll\" [] (* ./tests/binop-select.py $bop $ty *)"

		./tests/binop-select.py $bop $ty >"tests/${bop}${ty}.ll"
	done
done
