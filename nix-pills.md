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



# Chapter 2. Install (Nix) on Your Running System

Installing Nix is just like installing a package manager, it will not drastically change your system.

Again note that all derivations in the Nix store refer to other derivations in the Nix store. The store is self-contained.

Nix is obviously preinstalled on NixOS systems.


# The beginnings of the Nix store

Bootstrapping software will be copied to a fresh Nix store. You'll se bash, coreutils, the C compiler toolchain, Nix itself, and other software. You may notice that the Nix store can contain not only directories but also files (still in hash-name form).


# The Nix database

The Nix database is initialized after the Nix store is copied. The database lives in `/nix/var/nix/db`. The database uses sqlite to track dependencies between derivations.


# The first profiles

A profile in Nix is a concept for implementing rollbacks. Profiles compose components spread among multiple paths under a new unified path. Profiles are made up of versioned generations, when a profile is changed a new generation is created.

Generations can be switched and rolled back automatically.

Taking a closer look at a profile:
```nix
$ ls -l ~/.nix-profile/
bin -> /nix/store/ig31y9gfpp8pf3szdd7d4sf29zr7igbr-nix-2.1.3/bin
[...]
manifest.nix -> /nix/store/q8b5238akq07lj9gfb3qb5ycq4dxxiwm-env-manifest.nix
[...]
share -> /nix/store/ig31y9gfpp8pf3szdd7d4sf29zr7igbr-nix-2.1.3/share
```
The process of "installing" the derivation in the profile basically reproduces the hierarchy of the derivation in the profile by means of symbolic links.

TODO: sanity check this
The `bin` directory only points to `nix-2.1.3` because only one program has been installed in this example.

`~/.nix-profile` is a symbolic link to `/nix/var/nix/profiles/default` as well as a symbolic link to `/nix/var/nix/profiles/default/default-1-link` as this profile is the first generation of the `deafault` profile.

`default-1-link` is a symbolic link to to the Nix store "user-enviroment" derivation, the unified path.


# Nixpkgs expressions

**Nix expressions** are used to describe packages and how to build them. `Nixpkgs` is the repository containing all of the expressions.

A second profile is installed for **channels**. `~/.nix-defexpr/channels` points to `/nix/var/nix/profiles/per-user/nix/channels` which points to `channels-1-link` which points to a Nix store directory containing the downloaded Nix expressions.

**Channels** are sets of packages and expressions available for download. Similar to Debian stable and unstable, there's a stable and unstable channel.

Note: **Nix expressions** will be covered later.
