setopt PROMPT_SUBST
if [[ $IN_NIX_SHELL == 1 ]]; then
  PROMPT='%F{green}☕ [%n@%m:%~]%f$ '
else
  PROMPT='%F{blue}[%n@%m:%~]%f$ '
fi
fastfetch

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'  # Gray suggestions
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)  # Customize highlighters

# History substring search settings (optional)
bindkey '^R' history-substring-search-up
bindkey '^S' history-substring-search-down
export EDITOR='nvim'
alias imgtotext='grim -g "$(slurp)" - | tesseract stdin stdout'
alias build="nix build --no-link -f '<nixpkgs/nixos>' config.system.build.toplevel && sudo nixos-rebuild switch"
alias dev="nix develop -c $SHELL"
npkg() {
  local CFG="/etc/nixos/configuration.nix"
  case $1 in
    add)
      sudo awk -v pkg="$2" '
        BEGIN { inside = 0 }
        /packages = with import <nixpkgs>/ { inside = 1 }
        inside && /^\s*];/ {
          print "  " pkg
          inside = 0
        }
        { print }
      ' "$CFG" | sudo tee "$CFG" > /dev/null
      ;;
    remove)
      sudo awk -v pkg="$2" '
        BEGIN { inside = 0 }
        /packages = with import <nixpkgs>/ { inside = 1 }
        inside && /^\s*];/ { inside = 0 }
        inside && $1 == pkg { next }
        { print }
      ' "$CFG" | sudo tee "$CFG" > /dev/null
      ;;
    list)
      awk '
        BEGIN { inside = 0 }
        /packages = with import <nixpkgs>/ { inside = 1; next }
        inside && /^\s*];/ { exit }
        inside { print $1 }
      ' "$CFG"
      ;;
    apply)
      sudo nixos-rebuild switch
      ;;
    search)
      nix search nixpkgs "$2"
      ;;
    *)
      echo "Usage: npkg {add|remove|list|apply|search} <pkg>"
      ;;
  esac
}

