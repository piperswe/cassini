ssh-add -K

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export VENDOR="$HOME/vendor"
source "$VENDOR/antigen/antigen.zsh"

antigen use oh-my-zsh

antigen bundle git
antigen bundle zsh-users/zsh-syntax-highlighting

antigen theme romkatv/powerlevel10k

antigen apply

alias kroot="kubectl --context=root"
alias kdev="kubectl --context=dev"
alias kstage="kubectl --context=stage"
alias kprod="kubectl --context=prod"
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'

zsh-commit() {
	git commit --no-verify --author=".zshrc <https://github.com/piperswe/cassini/blob/master/.zshrc>" -m "$1" -m "Co-authored-by: $(git config user.name) <$(git config user.email)>"
}

UNWRAPPED_BREW="/usr/local/bin/brew"
brew() {
	"${UNWRAPPED_BREW}" "${@}"
	"${UNWRAPPED_BREW}" bundle dump --file=~/Brewfile --force
	pushd ~
	git add Brewfile
	zsh-commit "brew ${*}"
	git push
	popd
}

UNWRAPPED_MAS="/usr/local/bin/mas"
mas() {
	if [[ "x$1" = "xuninstall" ]]
	then
		sudo "${UNWRAPPED_MAS}" "${@}"
	else
		"${UNWRAPPED_MAS}" "${@}"
	fi
	"${UNWRAPPED_BREW}" bundle dump --file=~/Brewfile --force
	pushd ~
	git add Brewfile
	zsh-commit "mas ${*}"
	git push
	popd
}

export PATH="/usr/local/opt/coreutils/libexec/gnubin:/usr/local/opt/ruby/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/ruby/lib"
export CPPFLAGS="-I/usr/local/opt/ruby/include"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export LADDER_LOG_LEVEL=warn
