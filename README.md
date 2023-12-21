# llvm--2

## Dependencies

This has been using clang 17, available on Homebrew and AUR:
```bash
brew install llvm
-- or --
yay -S clang17
```
It might work for earlier releases as well.

Builds a subset of LLVM IR referred to as LLVM-- in our compilers cource.

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

Run the test suite for files/allocators only matching `filter` if specified:

```bash
dune exec tests -- [filter]
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
