#!/usr/bin/env bash

function atoi() {
	if [ $1 = '64' ]; then
		echo "@strtoll"
	else
		echo "@strtol"
	fi
}

function atou() {
	if [ $1 = '64' ]; then
		echo "@strtoull"
	else
		echo "@strtoul"
	fi
}

function umax() {
	if [ $1 = '64' ]; then
		echo "18446744073709551615"
	else
		echo $((2 ** $ty - 1))
	fi
}

function umin() {
	if [ $1 = '64' ]; then
		echo "-18446744073709551616"
	else
		echo $((-(2 ** $ty)))
	fi
}

for cnd in eq ne slt sle sgt sge ult ule ugt uge; do
	for ty in 8 16 32 64; do
		umax=$(umax $ty)
		smax=$((2 ** ($ty - 1) - 1))
		umin=$(umin $ty)
		smin=$((2 ** ($ty - 1) - 1))
		echo "  |> t \"tests/icmpi${ty}${cnd}.ll\" [ \"0\"; \"0\" ] (* ./tests/select-icmp.py $cnd i$ty $(atoi $ty) *)"
		echo "  |> t \"tests/icmpi${ty}${cnd}.ll\" [ \"1\"; \"0\" ] (* ./tests/select-icmp.py $cnd i$ty $(atoi $ty) *)"
		echo "  |> t \"tests/icmpi${ty}${cnd}.ll\" [ \"0\"; \"1\" ] (* ./tests/select-icmp.py $cnd i$ty $(atoi $ty) *)"
		echo "  |> t \"tests/icmpi${ty}${cnd}.ll\" [ \"1\"; \"1\" ] (* ./tests/select-icmp.py $cnd i$ty $(atoi $ty) *)"
		echo "  |> t \"tests/icmpi${ty}${cnd}.ll\" [ \"0\"; \"0\" ] (* ./tests/select-icmp.py $cnd i$ty $(atoi $ty) *)"
		echo "  |> t \"tests/icmpi${ty}${cnd}.ll\" [ \"1\"; \"0\" ] (* ./tests/select-icmp.py $cnd i$ty $(atoi $ty) *)"
		echo "  |> t \"tests/icmpi${ty}${cnd}.ll\" [ \"0\"; \"1\" ] (* ./tests/select-icmp.py $cnd i$ty $(atoi $ty) *)"
		echo "  |> t \"tests/icmpi${ty}${cnd}.ll\" [ \"1\"; \"1\" ] (* ./tests/select-icmp.py $cnd i$ty $(atoi $ty) *)"
		echo "  |> t \"tests/icmpi${ty}${cnd}.ll\" [ \"$umax\"; \"$umax\" ] (* ./tests/select-icmp.py $cnd i$ty $(atoi $ty) *)"
		echo "  |> t \"tests/icmpi${ty}${cnd}.ll\" [ \"$smax\"; \"$umax\" ] (* ./tests/select-icmp.py $cnd i$ty $(atoi $ty) *)"
		echo "  |> t \"tests/icmpi${ty}${cnd}.ll\" [ \"$umax\"; \"$smax\" ] (* ./tests/select-icmp.py $cnd i$ty $(atoi $ty) *)"
		echo "  |> t \"tests/icmpi${ty}${cnd}.ll\" [ \"$smax\"; \"$smax\" ] (* ./tests/select-icmp.py $cnd i$ty $(atoi $ty) *)"
		echo "  |> t \"tests/icmpi${ty}${cnd}.ll\" [ \"$umin\"; \"$umin\" ] (* ./tests/select-icmp.py $cnd i$ty $(atoi $ty) *)"
		echo "  |> t \"tests/icmpi${ty}${cnd}.ll\" [ \"$smin\"; \"$umin\" ] (* ./tests/select-icmp.py $cnd i$ty $(atoi $ty) *)"
		echo "  |> t \"tests/icmpi${ty}${cnd}.ll\" [ \"$umin\"; \"$smin\" ] (* ./tests/select-icmp.py $cnd i$ty $(atoi $ty) *)"
		echo "  |> t \"tests/icmpi${ty}${cnd}.ll\" [ \"$smin\"; \"$smin\" ] (* ./tests/select-icmp.py $cnd i$ty $(atoi $ty) *)"

		./tests/select-icmp.py $cnd "i$ty" $(atoi $ty) >"tests/icmpi${ty}${cnd}.ll"

		echo "  |> t \"tests/icmpu${ty}${cnd}.ll\" [ \"0\"; \"0\" ] (* ./tests/select-icmp.py $cnd i$ty $(atou $ty) *)"
		echo "  |> t \"tests/icmpu${ty}${cnd}.ll\" [ \"1\"; \"0\" ] (* ./tests/select-icmp.py $cnd i$ty $(atou $ty) *)"
		echo "  |> t \"tests/icmpu${ty}${cnd}.ll\" [ \"0\"; \"1\" ] (* ./tests/select-icmp.py $cnd i$ty $(atou $ty) *)"
		echo "  |> t \"tests/icmpu${ty}${cnd}.ll\" [ \"1\"; \"1\" ] (* ./tests/select-icmp.py $cnd i$ty $(atou $ty) *)"
		echo "  |> t \"tests/icmpu${ty}${cnd}.ll\" [ \"$umax\"; \"$umax\" ] (* ./tests/select-icmp.py $cnd i$ty $(atou $ty) *)"
		echo "  |> t \"tests/icmpu${ty}${cnd}.ll\" [ \"$smax\"; \"$umax\" ] (* ./tests/select-icmp.py $cnd i$ty $(atou $ty) *)"
		echo "  |> t \"tests/icmpu${ty}${cnd}.ll\" [ \"$umax\"; \"$smax\" ] (* ./tests/select-icmp.py $cnd i$ty $(atou $ty) *)"
		echo "  |> t \"tests/icmpu${ty}${cnd}.ll\" [ \"$smax\"; \"$smax\" ] (* ./tests/select-icmp.py $cnd i$ty $(atou $ty) *)"
		echo "  |> t \"tests/icmpu${ty}${cnd}.ll\" [ \"$umin\"; \"$umin\" ] (* ./tests/select-icmp.py $cnd i$ty $(atou $ty) *)"
		echo "  |> t \"tests/icmpu${ty}${cnd}.ll\" [ \"$smin\"; \"$umin\" ] (* ./tests/select-icmp.py $cnd i$ty $(atou $ty) *)"
		echo "  |> t \"tests/icmpu${ty}${cnd}.ll\" [ \"$umin\"; \"$smin\" ] (* ./tests/select-icmp.py $cnd i$ty $(atou $ty) *)"
		echo "  |> t \"tests/icmpu${ty}${cnd}.ll\" [ \"$smin\"; \"$smin\" ] (* ./tests/select-icmp.py $cnd i$ty $(atou $ty) *)"

		./tests/select-icmp.py $cnd "i$ty" $(atou $ty) >"tests/icmpu${ty}${cnd}.ll"
	done
done
