{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }@inputs:
  let 
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
  in
  {
    packages.${system} = {
      default = pkgs.callPackage ./proton-cli.nix {};
      proton-cli = pkgs.callPackage ./proton-cli-steamrun.nix {};
    };
  };
  
}