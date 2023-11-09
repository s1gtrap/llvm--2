ifeq (bench,$(firstword $(MAKECMDGOALS)))
  RUN := $(word 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  RUN_ARGS := $(wordlist 3,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(RUN_ARGS):;@:)
endif

all:

%-clang: benches/%.ll
	clang -O0 -target x86_64-unknown-darwin $^ tiger.c -o $@

%-simp: benches/%.ll
	dune exec llvm__2 -- $^ -a briggs -o $@ -c tiger.c

%-greedy: benches/%.ll
	dune exec llvm__2 -- $^ -a greedy -o $@ -c tiger.c

bench: $(RUN)
	/usr/bin/time -al ./$(RUN) $(RUN_ARGS)

clean:
	rm -rf fib fib-clang

.PHONY: bench clean
