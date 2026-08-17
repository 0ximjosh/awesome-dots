#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: update.sh [--no-rebuild] [--host HOST]

Update flake inputs (and nix channels, if any are configured), then rebuild
the NixOS system.

Options:
  --no-rebuild   Update inputs/channels only
  --host HOST    NixOS flake attribute to rebuild (default: mira)
  -h, --help     Show this help
EOF
}

root="$(cd -- "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd -- "$root"

rebuild=1
host="mira"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --no-rebuild)
      rebuild=0
      shift
      ;;
    --host)
      host="${2:?--host requires a hostname}"
      shift 2
      ;;
    --host=*)
      host="${1#--host=}"
      shift
      ;;
    -h | --help)
      usage
      exit 0
      ;;
    *)
      echo "error: unknown argument: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

nix_cmd=(nix --extra-experimental-features "nix-command flakes")

echo "==> Updating nvim flake inputs"
"${nix_cmd[@]}" flake update --flake "$root/nvim"

echo "==> Updating system flake inputs"
"${nix_cmd[@]}" flake update

if command -v nix-channel >/dev/null && [[ -n "$(nix-channel --list 2>/dev/null || true)" ]]; then
  echo "==> Updating nix channels"
  sudo nix-channel --update
else
  echo "==> No nix channels configured, skipping"
fi

if [[ "$rebuild" -eq 1 ]]; then
  echo "==> Rebuilding NixOS ($host)"
  sudo nixos-rebuild switch --flake "$root#$host"
else
  echo "==> Skipping rebuild"
fi
