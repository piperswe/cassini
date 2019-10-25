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

UNWRAPPED_BREW="/usr/local/bin/brew"
brew() {
	"${UNWRAPPED_BREW}" "${@}"
	"${UNWRAPPED_BREW}" bundle dump --file=~/Brewfile --force
	pushd ~
	git add Brewfile
	git commit -m "brew ${*}"
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
	git commit -m "mas ${*}"
	git push
	popd
}
