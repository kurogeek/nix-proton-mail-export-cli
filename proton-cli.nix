{ stdenv
, steam-run
, writeScriptBin
, makeWrapper
, fetchurl
, buildFHSUserEnv
, ... }: 
let
  proton-cli = stdenv.mkDerivation rec {
    name = "proton-mail-export-cli";
    src = fetchurl {
      url = "https://proton.me/download/export-tool/proton-mail-export-cli-linux_x86_64.tar.gz";
      hash = "sha256-SXcCk7Noz64XsbRdEVsn0aszR3uK8SgkoBxji7bjqLs=";
    };
    sourceRoot = ".";
    nativeBuildInputs = [ stdenv.cc.cc ];
    installPhase = ''
      cp -R . $out/
      
      ln -s /tmp/ $out/logs
    '';
  };
in

buildFHSUserEnv {
  name = "proton-mail-export-cli";
  targetPkgs = pkgs: [ proton-cli ];
  multiPkgs = pkgs: [ ];
  runScript = "${proton-cli}/proton-mail-export-cli";
}

