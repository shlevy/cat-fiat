let pkgs = import <nixpkgs> {};
    fiat = pkgs.callPackage ./fiat.nix {};
in pkgs.nixBufferBuilders.withPackages [ pkgs.coq fiat ]
