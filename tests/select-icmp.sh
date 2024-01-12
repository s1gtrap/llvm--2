#!/usr/bin/env bash

for cnd in eq ne slt sle sgt sge ult ule ugt uge; do
	for ty in 8 16 32 64; do
		echo "  |> t \"tests/icmpi${ty}${cnd}.ll\" [] (* ./tests/select-icmp.py $cnd i$ty *)"

		./tests/select-icmp.py $cnd "i$ty" >"tests/icmpi${ty}${cnd}.ll"
	done
done
