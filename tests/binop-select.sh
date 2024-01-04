#!/usr/bin/env bash

for bop in add sub; do
	for ty in i8 i16 i32 i64; do
		./tests/binop-select.py $bop $ty >"tests/${bop}${ty}.ll"
	done
done
