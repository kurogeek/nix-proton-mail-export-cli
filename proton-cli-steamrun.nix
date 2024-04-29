{ stdenv
, steam-run
, writeScriptBin
, makeWrapper
, fetchurl
, ... }: 
# stdenv.mkDerivation rec {
#   name = "vizr-proton-cli";
#   src = fetchurl {
#     url = "https://proton.me/download/export-tool/proton-mail-export-cli-linux_x86_64.tar.gz";
#     hash = "sha256-8Lm2Nbw1LgFjEtTyBJRwhYEXPbd9wJHKZE1GISDwlfI=";
#   };
#   sourceRoot = ".";

#   nativeBuildInputs = [ makeWrapper ];

#   installPhase = ''
#     mkdir -p $out/bin
#     ls -al
#     cp -av $out/proton-mail-export-cli $out/bin/.proton-mail-export-cli-unwrapped

#     makeWrapper ${steam-run}/bin/steam-run $out/bin/proton-mail-export-cli
#   '';
# }
let
  proton-cli = stdenv.mkDerivation rec {
    name = "proton-mail-export-cli";
    src = fetchurl {
      url = "https://proton.me/download/export-tool/proton-mail-export-cli-linux_x86_64.tar.gz";
      hash = "sha256-8Lm2Nbw1LgFjEtTyBJRwhYEXPbd9wJHKZE1GISDwlfI=";
    };
    sourceRoot = ".";
    nativeBuildInputs = [ makeWrapper ];
    installPhase = ''
      cp -R . $out/
      
      ls -al

      ln -s /tmp/ $out/logs
    '';
    preFixup = ''
      wrapProgram $out/${name}
    '';
  };
in

writeScriptBin "vizr-proton-cli" ''
  exec ${steam-run}/bin/steam-run ${proton-cli}/proton-mail-export-cli "$@"
''