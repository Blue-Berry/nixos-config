{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule {
  pname = "wuzapi";
  version = "0-unstable-2026-07-17";

  src = fetchFromGitHub {
    owner = "asternic";
    repo = "wuzapi";
    rev = "70642149a0e8a81d49caa640f557217e03e09729";
    hash = "sha256-WiXB+FxCDCNctjZg7bmA6HriEBgthia0NP2qVROUGwQ=";
  };

  vendorHash = "sha256-nR7MwvGIJl1MGIZDGxE9vCoeUxzKpDGZn3fUEXECZ7I=";

  meta = {
    description = "RESTful API and stdio json-rpc bridge for WhatsApp, using whatsmeow";
    homepage = "https://github.com/asternic/wuzapi";
    license = lib.licenses.mit;
    mainProgram = "wuzapi";
    platforms = lib.platforms.unix;
  };
}
