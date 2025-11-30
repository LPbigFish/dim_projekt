{
  description = "A reproducible development environment for LaTeX and Typst";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          name = "latex-typst-env";

          buildInputs = with pkgs; [
            # --- LaTeX Tools ---
            # scheme-full includes essentially everything. 
            # If disk space is an issue, switch to 'scheme-medium' or 'scheme-small'
            texlive.combined.scheme-full
            tex-fmt
            
            # Additional LaTeX utilities (often included in scheme-full, but explicit is safe)
            biber

            # --- Typst Tools ---
            typst       # The core compiler
            typstyle    # Code formatter for Typst
          ];
        };
      }
    );
}
