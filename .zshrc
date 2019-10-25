export VENDOR="$HOME/vendor"
source "$VENDOR/antigen/antigen.zsh"

antigen use oh-my-zsh

antigen bundle git
antigen bundle zsh-users/zsh-syntax-highlighting

antigen apply
ssh-add -K

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

export PATH="/usr/local/opt/ruby/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/ruby/lib"
export CPPFLAGS="-I/usr/local/opt/ruby/include"
