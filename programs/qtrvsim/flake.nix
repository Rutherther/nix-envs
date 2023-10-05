{
  description = "QtMips package";


  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-23.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, flake-utils, nixpkgs }: 
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      system = "${system}";
    };
    riscPkgs = import nixpkgs {
      crossSystem.config = "riscv64-none-elf";
      system = "${system}";
    };
  in {
    packages.${system} = {
      qtrvsim = pkgs.qtrvsim;
      default = self.packages.${system}.qtrvsim;
    };

    devShells.${system}.default = riscPkgs.mkShell {
      packages = [
        pkgs.qtrvsim
      ];

      buildInputs = [
        riscPkgs.buildPackages.binutils
        riscPkgs.buildPackages.gcc
      ];
    };
  };
}
