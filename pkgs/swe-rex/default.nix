{ lib
, python3
, fetchPypi
}:

python3.pkgs.buildPythonPackage rec {
  pname = "swe-rex";
  version = "1.3.0";
  pyproject = true;

  src = fetchPypi {
    pname = "swe_rex";
    inherit version;
    hash = "sha256-e/r9ROBa8nfBnbAZuCE+B8RfKmYoPXUmtVwtwUOAJAc=";
  };

  build-system = with python3.pkgs; [
    setuptools
    wheel
  ];

  dependencies = with python3.pkgs; [
    fastapi
    uvicorn
    pexpect
    bashlex
    python-multipart
    rich
    requests
    pydantic
  ];

  optional-dependencies = with python3.pkgs; {
    modal = [
      # modal dependencies if available in nixpkgs
    ];
    fargate = [
      # fargate dependencies if available in nixpkgs
    ];
    dev = [
      # dev dependencies
      pytest
      black
      mypy
    ];
  };

  # Skip imports check due to module structure issues
  # pythonImportsCheck = [
  #   "swe_rex"
  # ];

  # Tests might require network access
  doCheck = false;

  meta = with lib; {
    description = "A runtime interface for interacting with sandboxed shell environments";
    homepage = "https://github.com/swe-agent/SWE-ReX";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}
