# llvm--2

## Dependencies

This has been using clang 16, available on Homebrew and AUR:
```bash
brew install llvm@16
-- or --
yay -S clang16
```
It might work for earlier releases as well.

Builds a subset of LLVM IR referred to as LLVM-- in our compilers cource.

```bash
$ opam --version
2.1.5
$ dune --version
3.11.1
$ ocaml --version
The OCaml toplevel, version 4.14.1
```

## Build

Built with OCaml 4.14.1

```bash
opam switch create 4.14.1
eval $(opam env --switch=4.14.1)
opam install dune ocamlgraph stdio ppx_inline_test landmarks-ppx menhir -y
```

## Usage

To build one or more `.ll` files seperately:

```bash
dune exec build -- [options] file...
```

## Testing

Run the test suite for files matching `filter` if specified:


## Benchmarks

Run the benchmarks for all files matching optional filter with n repetitions.

```bash
dune exec tests -- [-f filter] [-n number of repetitions]
```

## Profiling

Profiling is done with [LexiFi/landmarks](https://github.com/LexiFi/landmarks).

### Install

To run on M1:

```bash
opam pin landmarks https://github.com/LexiFi/landmarks.git#b0c753c
opam pin landmarks-ppx https://github.com/LexiFi/landmarks.git#b0c753c
```

### Example Usage

```bash
OCAML_LANDMARKS=format=json,output=profile.json  dune exec build -- tests/sha256.ll -a greedy -t lva
```
