{
  stdenv,
  lib,
  fetchurl,
  file,
  unzip,
  findutils,
  gnutar,
  gnugrep,
  coreutils,
  autoPatchelfHook ? null,
  zlib ? null,
  openssl ? null,
  libgcc ? null,
  stdenvNoCC ? null,
  glibc ? null,
}: let
  pname = "codex";
  version = "0.22.0";
  tag = "rust-v${version}";

  system = stdenv.hostPlatform.system;

  realNameInside = "";
  binaryName = "codex";

  assets = {
    x86_64-linux = {
      url = "https://github.com/openai/codex/releases/download/${tag}/codex-x86_64-unknown-linux-gnu.tar.gz";
      sha256 = "sha256-ubzJzN7RjeMxuFUT57MIImiZwVd8yNM8cA001nYIXtY=";
    };
    aarch64-linux = {
      url = "https://github.com/openai/codex/releases/download/${tag}/codex-aarch64-unknown-linux-gnu.tar.gz";
      sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
    };
    x86_64-darwin = {
      url = "https://github.com/openai/codex/releases/download/${tag}/codex-x86_64-apple-darwin.tar.gz";
      sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
    };
    aarch64-darwin = {
      url = "https://github.com/openai/codex/releases/download/${tag}/codex-aarch64-apple-darwin.tar.gz";
      sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
    };
  };

  asset = assets.${system} or (throw "Unsupported system: ${system}");
  isLinux = stdenv.isLinux;
in
  stdenv.mkDerivation {
    inherit pname version;

    src = fetchurl {inherit (asset) url sha256;};

    dontUnpack = true;

    nativeBuildInputs =
      [file unzip findutils gnutar gnugrep coreutils]
      ++ lib.optionals isLinux [autoPatchelfHook];

    buildInputs = lib.optionals isLinux [
      zlib
      openssl
      libgcc # provides libgcc_s.so.1
      stdenv.cc.cc # provides libstdc++.so.6
      glibc
    ];

    installPhase = ''
      runHook preInstall
      mkdir -p "$out/bin"

      kind=$(file -b "$src")
      workdir=$(mktemp -d)

      if echo "$kind" | grep -qiE 'gzip|xz|tar'; then
        (cd "$workdir" && tar -xf "$src")
      elif echo "$kind" | grep -qi 'zip'; then
        (cd "$workdir" && unzip -q "$src")
      else
        # Raw executable asset; just install and rename to ${binaryName}
        install -Dm755 "$src" "$out/bin/${binaryName}"
        runHook postInstall
        exit 0
      fi

      candidate=""

      # 1) If you set realNameInside, use it.
      if [ -n "${realNameInside}" ]; then
        candidate="$(find "$workdir" -type f -name "${realNameInside}" | head -n1 || true)"
      fi

      # 2) Prefer under bin/ or names starting with "codex"
      if [ -z "$candidate" ]; then
        candidate="$(find "$workdir" -type f \( -path "*/bin/*" -o -name "codex*" \) | head -n1 || true)"
      fi

      # 3) Fall back to first ELF/Mach-O (works even if exec bit got lost in a zip)
      if [ -z "$candidate" ]; then
        find "$workdir" -type f -print0 | while IFS= read -r -d $'\0' f; do
          if file -b "$f" | grep -qiE 'ELF|Mach-O'; then
            candidate="$f"
            break
          fi
        done
      fi

      if [ -z "$candidate" ]; then
        echo "ERROR: Couldn't find an executable in the asset." >&2
        echo "Hint: set realNameInside to the filename inside the archive." >&2
        exit 1
      fi

      chmod +x "$candidate" || true
      install -Dm755 "$candidate" "$out/bin/${binaryName}"

      runHook postInstall
    '';

    meta = {
      description = "Packaged ${pname} ${version} from GitHub releases (prebuilt binary)";
      homepage = "https://github.com/openai/codex";
      platforms = builtins.attrNames assets;
    };
  }
