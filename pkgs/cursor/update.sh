#!/usr/bin/env nix-shell
#!nix-shell -i bash -p curl jq nix
# shellcheck shell=bash
set -euo pipefail

cd -- "$(dirname "${BASH_SOURCE[0]}")"

UA="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
API="https://www.cursor.com/api/download"

prefetch_hash() {
  local url="$1"
  nix --extra-experimental-features "nix-command flakes" store prefetch-file --json --hash-type sha256 "$url" \
    | jq -r ".hash"
}

sources="{}"
version=""
commit=""

for pair in x86_64-linux:linux-x64 aarch64-linux:linux-arm64; do
  sys="${pair%%:*}"
  plat="${pair##*:}"
  meta="$(curl -fsSL -A "$UA" "${API}?platform=${plat}&releaseTrack=stable")"
  url="$(jq -r ".downloadUrl" <<<"$meta")"
  plat_version="$(jq -r ".version" <<<"$meta")"
  plat_commit="$(jq -r ".commitSha" <<<"$meta")"

  if [[ -z "$url" || "$url" == "null" ]]; then
    echo "error: no downloadUrl for $sys" >&2
    exit 1
  fi

  if [[ -z "$version" ]]; then
    version="$plat_version"
    commit="$plat_commit"
  elif [[ "$plat_version" != "$version" ]]; then
    echo "error: version mismatch ($sys is $plat_version, expected $version)" >&2
    exit 1
  fi

  echo "prefetching $sys ($plat_version)" >&2
  echo "  $url" >&2
  hash="$(prefetch_hash "$url")"
  sources="$(jq -n --argjson src "$sources" --arg sys "$sys" --arg url "$url" --arg hash "$hash" \
    '$src + {($sys): {url: $url, hash: $hash}}')"
done

jq -n --arg version "$version" --arg commitSha "$commit" --argjson sources "$sources" \
  '{version: $version, commitSha: $commitSha, sources: $sources}' >sources.json

echo "Pinned Cursor $version ($commit) in sources.json"
