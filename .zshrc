# 環境変数
export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

# 直前のコマンドの重複を削除
setopt hist_ignore_dups

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# 同時に起動したzshの間でヒストリを共有
setopt share_history

# 補完機能を有効にする
autoload -Uz compinit
compinit -u
if [ -e /usr/local/share/zsh-completions ]; then
  fpath=(/usr/local/share/zsh-completions $fpath)
fi

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# 補完候補を詰めて表示
setopt list_packed

# 補完候補一覧をカラー表示
autoload colors
zstyle ':completion:*' list-colors ''

# コマンドのスペルを訂正
setopt correct
# ビープ音を鳴らさない
setopt no_beep

# ディレクトリスタック
DIRSTACKSIZE=100
setopt AUTO_PUSHD

# cd不要かつ移動後自動でls
setopt auto_cd
function chpwd() { ls }

# ctl + D でのログアウト防止
setopt IGNOREEOF

# https://git.pepabo.com/colorme/ops/issues/5742
export PATH="/opt/homebrew/opt/openssl@1.1/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/openssl@1.1/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@1.1/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@1.1/lib/pkgconfig"

# フォント
# https://github.com/lxbrtsch/Menlo-for-Powerline/blob/master/Menlo%20for%20Powerline.ttf

#=============================
# Homebrew
#=============================
# Git
export PATH="/usr/local/bin/git:$PATH"

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - zsh)"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# go
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

# tfenv
export PATH="$HOME/.tfenv/bin:$PATH"
eval "$(tfenv init - zsh)"

#=============================
# git 色付け
#=============================
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{magenta}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{yellow}+"
zstyle ':vcs_info:*' formats "%F{cyan}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }

# プロンプトカスタマイズ
PROMPT='
[%B%F{red}%n@%m%f%b:%F{green}%~%f]%F{cyan}$vcs_info_msg_0_%f
%F{yellow}$%f '


#=============================
# alias
#=============================
alias gcd='cd $(ghq list --full-path --exact| peco)' # ghq

alias vi='nvim'
alias vim='nvim'

alias ls='ls -G'
alias ll='ls -l'
alias l='ls -la'
alias so='source'
alias mkdir='mkdir -p'

alias dc='docker compose'
alias k='kubectl'
alias tf='terraform'

alias so='source'
alias mkdir='mkdir -p'

alias g='git'

alias be='bundle exec'
alias bi='bundle install --path vendor/bundler'
alias re='rbenv exec'
alias rv='rbenv versions'
