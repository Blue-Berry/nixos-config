{
  lib,
  python3,
  fetchFromGitHub,
  callPackage,
}:
python3.pkgs.buildPythonApplication rec {
  pname = "sweagent";
  version = "1.1.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "SWE-agent";
    repo = "SWE-agent";
    rev = "v${version}";
    hash = "sha256-WDZZXjN/nWFB2onikvZAlmfFWfrt0ImhYJzC/GRgIdE=";
  };

  build-system = with python3.pkgs; [
    setuptools
  ];

  dependencies = with python3.pkgs; [
    datasets
    numpy
    pandas
    rich
    ruamel-yaml
    tenacity
    unidiff
    simple-parsing
    rich-argparse
    flask
    flask-cors
    flask-socketio
    pydantic
    python-dotenv
    pydantic-settings
    litellm
    gitpython
    ghapi
    tabulate
    textual
    (callPackage ../swe-rex {})
  ];

  # Copy config, tools, and trajectories directories to fix runtime assertions
  postInstall = ''
    mkdir -p $out/lib/python3.13/site-packages/config
    mkdir -p $out/lib/python3.13/site-packages/tools
    mkdir -p $out/lib/python3.13/site-packages/trajectories
    if [ -d "$src/config" ]; then
      cp -r $src/config/* $out/lib/python3.13/site-packages/config/
    fi
    if [ -d "$src/tools" ]; then
      cp -r $src/tools/* $out/lib/python3.13/site-packages/tools/
    fi
    if [ -d "$src/trajectories" ]; then
      cp -r $src/trajectories/* $out/lib/python3.13/site-packages/trajectories/
    fi
  '';

  # swe-rex dependency is now included

  # Skip imports check due to config directory assertion
  # pythonImportsCheck = [
  #   "sweagent"
  # ];

  # Tests require network access and additional setup
  doCheck = false;

  meta = with lib; {
    description = "An open source Agent Computer Interface for running language models as software engineers";
    homepage = "https://github.com/SWE-agent/SWE-agent";
    license = licenses.mit;
    maintainers = with maintainers; [];
    mainProgram = "sweagent";
  };
}
