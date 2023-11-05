%: tests/%.ll
	clang -O0 -target x86_64-unknown-darwin $^ -o $@
