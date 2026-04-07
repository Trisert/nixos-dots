{
  config,
  pkgs,
  ...
}:

{
  programs.bash = {
    enable = true;
    shellAliases = {
      n = "nvim";
    };
    initExtra = ''
      unpack() {
        if [ -z "$1" ]; then
          echo "Usage: unpack <file>"
          return 1
        fi

        local file="$1"
        if [ ! -f "$file" ]; then
          echo "Error: '$file' not found"
          return 1
        fi

          ensure_cmd() {
          local cmd="$1"
          if ! command -v "$cmd" &>/dev/null; then
            echo "Installing $cmd..."
            nix profile add "nixpkgs#$cmd"
          fi
        }

        case "$file" in
          *.tar.bz2|*.tbz2)
            ensure_cmd bzip2
            tar xjf "$file"
            ;;
          *.tar.gz|*.tgz)
            ensure_cmd gzip
            tar xzf "$file"
            ;;
          *.tar.xz|*.txz)
            ensure_cmd xz
            tar xJf "$file"
            ;;
          *.tar.zst)
            ensure_cmd zstd
            tar --zstd -xf "$file"
            ;;
          *.tar)
            tar xf "$file"
            ;;
          *.bz2)
            ensure_cmd bzip2
            bzip2 -d "$file"
            ;;
          *.gz)
            ensure_cmd gzip
            gzip -d "$file"
            ;;
          *.xz)
            ensure_cmd xz
            xz -d "$file"
            ;;
          *.zst)
            ensure_cmd zstd
            zstd -d "$file"
            ;;
          *.zip)
            ensure_cmd unzip
            unzip "$file"
            ;;
          *.rar)
            ensure_cmd unrar
            unrar x "$file"
            ;;
          *.7z)
            ensure_cmd _7zz
            7zz x "$file"
            ;;
          *.p7z)
            ensure_cmd _7zz
            7zz x "$file"
            ;;
          *.lzma)
            ensure_cmd lzma
            lzma -d "$file"
            ;;
          *.lz)
            ensure_cmd lzip
            lzip -d "$file"
            ;;
          *.lz4)
            ensure_cmd lz4
            lz4 -d "$file"
            ;;
          *.Z)
            ensure_cmd uncompress
            uncompress "$file"
            ;;
          *)
            echo "Unsupported format: $file"
            return 1
            ;;
        esac

        echo "Extracted '$file'"
      }
    '';
  };

  programs.starship = {
    enable = true;
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };
}
