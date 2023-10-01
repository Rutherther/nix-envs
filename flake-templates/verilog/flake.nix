{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-23.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, flake-utils, nixpkgs }: let
  in flake-utils.lib.eachDefaultSystem
      (system:
        let pkgs = import nixpkgs {
              inherit system;
              config.allowUnfree = true;
            };
            verilog-toolchain = with pkgs; symlinkJoin {
              name = "verilog-toolchain";
              meta.mainProgram = "verilog";
              paths = [
                verilog
                verilator
                gtkwave
              ];
            };
        in rec {

          packages.verilog = verilog-toolchain;
          packages.verilog-lsp = pkgs.svls;
          packages.default = packages.verilog;

          devShells.default = pkgs.mkShell {
            name = "verilog-project";

            nativeBuildInputs = [
              packages.verilog
            ];

            packages = with pkgs; [
              # lsp
              packages.verilog-lsp
            ];
          };
        }
      );
}
