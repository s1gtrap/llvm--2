# llvm--2

Builds a subset of LLVM IR referred to as LLVM-- in our compilers cource.

## Build

Built with OCaml 5.1.0.

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
