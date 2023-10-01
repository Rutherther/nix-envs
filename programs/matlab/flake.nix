{
  description = "Matlab.";

  inputs = {
    nix-matlab = {
      url = "gitlab:doronbehar/nix-matlab";
    };
  };
  outputs = { self, nixpkgs, nix-matlab }:
  let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {
    packages.x86_64-linux.matlab = nix-matlab.packages.x86_64-linux.matlab;
    packages.x86_64-linux.matlab-mlint = nix-matlab.packages.x86_64-linux.matlab-mlint;
    packages.x86_64-linux.matlab-mex = nix-matlab.packages.x86_64-linux.matlab-mex;
    packages.x86_64-linux.octave = pkgs.octaveFull;
    packages.x86_64-linux.default = self.packages.x86_64-linux.matlab;

    devShells.x86_64-linux.default = pkgs.mkShell {
      buildInputs = (with nix-matlab.packages.x86_64-linux; [
        matlab
        matlab-mlint
        matlab-mex
        pkgs.octaveFull
      ]);
      shellHook = nix-matlab.shellHooksCommon;
    };
  };
}
