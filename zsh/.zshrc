# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
# 環境変数
export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# 直前のコマンドの重複を削除
setopt hist_ignore_dups
# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups
# 同時に起動したzshの間でヒストリを共有
setopt share_history

# Ctrl+R で過去のコマンド履歴から選択して実行
function peco-select-history() {
    local tac
    if command -v tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N peco-select-history
bindkey '^r' peco-select-history

# プロンプト設定の初期化
autoload -U promptinit; promptinit
autoload -Uz colors; colors
autoload -Uz vcs_info
autoload -Uz is-at-least

# VCS（Version Control System）の設定開始
zstyle ":vcs_info:*" enable git
zstyle ":vcs_info:*" formats "(%s)-[%b]"
zstyle ":vcs_info:*" actionformats "(%s)-[%b|%a]"
zstyle ":vcs_info:(svn|bzr):*" branchformat "%b:r%r"
zstyle ":vcs_info:bzr:*" use-simple true

zstyle ":vcs_info:*" max-exports 6

# Git特有の設定
zstyle ":vcs_info:git:*" check-for-changes true # 未コミットの変更をチェック
zstyle ":vcs_info:git:*" stagedstr "<S>"
zstyle ":vcs_info:git:*" unstagedstr "<U>"
zstyle ":vcs_info:git:*" formats "(%b) %c%u"
zstyle ":vcs_info:git:*" actionformats "(%s)-[%b|%a] %c%u"

# プロンプトにVCS情報を表示する関数
function vcs_prompt_info() {
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && echo -n " %{$fg[yellow]%}$vcs_info_msg_0_%f"
}
# VCS設定終了

# プロンプト設定
PROMPT="%F{blue}%~%f"
PROMPT+="\$(vcs_prompt_info)
"
PROMPT+="%% "
# 右プロンプト
RPROMPT=""

# Kubernetesクラスター情報の表示のためのkube-ps1スクリプトのロード
source "/opt/homebrew/opt/kube-ps1/share/kube-ps1.sh"
# プロンプトにKubernetesクラスター情報を含む
PS1='$(kube_ps1)'$PS1

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

#=============================
# Homebrew
#=============================
# openssl
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/openssl@3/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@3/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@3/lib/pkgconfig"

export LIBRARY_PATH=$LIBRARY_PATH:$(brew --prefix zstd)/lib

# Git
export PATH="/usr/local/bin/git:$PATH"

# papassh
export PATH=$PATH:~/ghq/git.pepabo.com/tech/pepassh

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# go
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

#=============================
# alias
#=============================
alias gcd='cd $(ghq list --full-path --exact| peco)' # ghq

alias vi='nvim'
alias vim='nvim'

alias rm='rm -i'

alias g='git'
alias d='docker'
alias dc='docker compose'

alias k='kubectl'

alias t='terraform'

# krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# ssh
ssh-add /Users/harukin/.ssh/id_rsa
ssh-add /Users/harukin/.ssh/id_rsa_pb-deployer
ssh-add /Users/harukin/.ssh/harukin.pem

# ghe token
export GHE_USER=harukin
export GHE_TOKEN=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

. /opt/homebrew/opt/asdf/libexec/asdf.sh

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
