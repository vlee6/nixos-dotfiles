let
  pkgs = import <nixpkgs> {};
in
  pkgs.mkShell {
    packages = [
      pkgs.python312
      pkgs.python312Packages.numpy
      pkgs.python312Packages.matplotlib
      pkgs.python312Packages.pandas
      pkgs.python312Packages.seaborn
      pkgs.python312Packages.sympy
    ];

    shellHook = ''
      if [ ! -d .venv ]; then
        python -m venv .venv
      fi
      source .venv/bin/activate
      pip install --upgrade pip
      pip install gradescope-utils==0.5.0
    '';
  }
