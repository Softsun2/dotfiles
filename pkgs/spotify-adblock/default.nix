{ lib , rustPlatform , fetchFromGitHub }:

rustPlatform.buildRustPackage rec {
  pname = "spotify-adblock";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "abba23";
    repo = pname;
    rev = "9ba383b7b41c25c960e91732590ec45be0ff4e73";
    sha256 = "sha256-n/JAbpyr9H8fu5pjc5YvCwXXWTweTzkdZE0uAtuNu88=";
  };

  cargoHash = "sha256-2cifA/MRwimeedWfhbnmFucz02W8+b6BTc94wFNW/50=";

  meta = {
    homepage = "https://github.com/abba23/spotify-adblock";
    description = "Spotify adblocker";
    license = lib.licenses.unfree;
    maintainer = lib.maintainers.softsun2;
  };
}