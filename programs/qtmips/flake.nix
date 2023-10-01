{
  description = "QtMips package";


  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-23.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, flake-utils, nixpkgs }: 
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    qtmips = pkgs.libsForQt5.callPackage ./qtmips-pkg.nix {  };
    mipsPkgs = import nixpkgs {
      crossSystem.config = "mips-elf";
      system = "${system}";
    };
  in {
    packages.${system} = {
      QtMips = qtmips;
      default = self.packages.${system}.QtMips;
    };

    devShells.${system}.default = pkgs.mkShell {
      packages = [
        qtmips
      ];

      buildInputs = [
        mipsPkgs.buildPackages.binutils
        mipsPkgs.buildPackages.gcc
      ];
    };
  };
}
