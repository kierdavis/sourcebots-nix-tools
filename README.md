# sourcebots-nix-tools

Nix expressions and other utilities for doing SourceBots development on NixOS/Nix-based systems.

General organisation:

* `boards`: firmware and tooling for the embedded boards used in the robotics kit
* `build-support`: Nix language utils used by other parts of the repo
* `lib`: libraries used for development
* `sw`: software that runs on the Raspberry Pi in the robotics kit
* `tools`: programs used for development

Usage:

  git clone git@github.com:kierdavis/sourcebots-nix-tools.git
  cd sourcebots-nix-tools
  nix-build -A PACKAGE

See the top-level `default.nix` for a list of packages.
