# Chapter 1. Why You Should Give it a Try

## Introduction

Nix is a purely functional package manager and deployment system. NixOS is a real world example of using Nix for building a whole operating system.


## Rationale (Nix Pills)

Explain some of the Nix magic concisely. Complementary to the manuals and wiki. I (softsun2) am summarizing these learning modules for reference as I learn Nix.


## Not being purely functional

Most package managers mutate the global state of the system. This makes it difficult to install multiple versions of the same package. Inconveniences include handling binary names, library collisions, using containers, using independent virtual enviroments, etc...


## Being purely functional

Nix makes no assumptions about the global state of the sytem.

The core of a Nix system is the Nix store, usually installed under `/nix/store`, and some tools that manipulate the store.

Note: In Nix there is a notion of a *derivation* rather than a package, the two are seperate but similar.

Derivations/packages are stored in the Nix store as follows: `/nix/store/hash-name` where the hash uniquely identifies the derivation, and the name is the name of the derivation.

For example, a bash derivation: `/nix/store/s4zia7hhqkin1di0f187b79sa2srhv6k-bash-4.2-p45/` is the directory in the Nix store containing `bin/bash`. This means there's no `/bin/bash`, just a build output of bash in the store. Nix adds these binaries to your `PATH` to use from a shell.

The store contains all packages (differentiating by version as well). All the packages in the Nix store are immutable. Packages are built against dependencies also found in the Nix store. This means avoiding the aforementioned inconveniences of non-functional package managers.


## Caveats

Immutable packages lead to some drawbacks. Since packages are immutable, libraries cannot be upgraded in-place. This means applications will have to be recompiled against the upgraded libraries (different path in Nix store).

The pure functional model leads to some drawbacks as well. It can be difficult to compose applications at runtime. Applications such as firefox look in global paths (that do not exist in Nix) for plugins. This is solved with wrapping to produce a firefox derivation that points to plugins in the Nix store.

Note: There is no notion of upgrade/downgrade scripts. In Nix you switch to the other software with it's own stack of dependencies.


## Conclusion 1

Nix lets you declare reproducible builds flexibly.

Nix falls short when working with dynamic composition at runtime and replacing low level libraries.



# Chapter 2. Install on Your Running System