# shell.nix
{ pkgs ? import <nixpkgs> {} }:

let
  targetPackage = pkgs.xrizer;
in
pkgs.mkShell {
  # direct build-time dependencies of targetPackage.
  buildInputs = targetPackage.buildInputs;

  # tools needed during build process, like compilers, CMake, etc.
  nativeBuildInputs = targetPackage.nativeBuildInputs;

  # extra tools (e.g., debuggers, profilers).
  packages = with pkgs; [
    gdb
    xorg.libX11 # was needed for build of some dep
    rustup # for jetbrains IDE to work with rust
  ];

  shellHook = ''
    echo "Welcome to the development shell for ${targetPackage.pname}!"
    # could start a build here right away or smth maybe, idk
  '';
}
