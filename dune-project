(lang dune 3.9)

(name llvm__2)

(using menhir 2.0)

(generate_opam_files true)

(source
 (github username/reponame))

(authors "Author Name")

(maintainers "Maintainer Name")

(license LICENSE)

(documentation https://url/to/documentation)

(package
 (name llvm__2)
 (synopsis "A short synopsis")
 (description "A longer description")
 (depends ocaml dune ocamlgraph)
 (tags
  (topics "to describe" your project)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
