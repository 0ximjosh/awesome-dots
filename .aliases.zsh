alias ghs="git rev-list --objects --all --missing=print |
  git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' |
  sed -n 's/^blob //p' |
  sort --numeric-sort --key=2 |
  cut -c 1-12,41- |
  $(command -v gnumfmt || echo numfmt) --field=2 --to=iec-i --suffix=B --padding=7 --round=nearest"

alias gw="cat $HOME/.gitweek 2>/dev/null"
alias gwc="rm -f $HOME/.gitweek || true"

alias grep='() { $(whence -p grep) --color=auto $@ }'
alias ls="eza --long --icons -F"
alias la="eza --long --icons -aF"
alias lst="eza --long --tree -aF -I node_modules\|.git --git-ignore"
alias lsta="eza --long --tree -aF"

alias dc="docker compose"
alias dcd="docker compose -f docker-compose.dev.yml"
alias dcdu="docker compose -f docker-compose.dev.yml up -d"
alias dcdl="docker compose -f docker-compose.dev.yml logs -f"
alias dcu="docker compose up -d"
alias dcl="docker compose logs -f"

alias rm='rm -v'
alias wgup="wg-quick up wg0"
alias k="kubectl"
