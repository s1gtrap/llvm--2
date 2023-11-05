ifeq (bench,$(firstword $(MAKECMDGOALS)))
  RUN := $(word 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  RUN_ARGS := $(wordlist 3,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(RUN_ARGS):;@:)
endif

all:

%-clang: benches/%.ll
	clang -O0 -target x86_64-unknown-darwin $^ -o $@

%: benches/%.ll
	dune exec llvm__2 -- $^ -a greedy -o $@

bench: $(RUN)
	/usr/bin/time -al ./$(RUN) $(RUN_ARGS)

clean:
	rm -rf fib fib-clang

.PHONY: bench clean
