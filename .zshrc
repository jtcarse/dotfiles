##########
# iTerm2 #
##########

# set iterm2 vars for status bar
function iterm2_print_user_vars() {
  iterm2_set_user_var python_version $(asdf current python | awk '{ print $2 }' || echo -n 'None')
  iterm2_set_user_var node_version $(asdf current nodejs | awk '{ print $2 }' || echo -n 'None')
  iterm2_set_user_var ruby_version $(asdf current ruby | awk '{ print $2 }' || echo -n 'None')
  iterm2_set_user_var golang_version $(asdf current golang | awk '{ print $2 }' || echo -n 'None')
}


############
# Homebrew #
############

FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"


#####################
# Prezto Zsh Prompt #
#####################

# init prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
else
  echo "zprezto not installed"
fi


###########
# Aliases #
###########

# kubernetes
alias k="kubectl "
alias klx="kubectl config get-contexts"
alias knx='f() { [ "$1" ] && kubectl config set-context --current --namespace $1 || kubectl config view --minify | grep namespace | cut -d" " -f6 ; } ; f'
alias kcx='f() { [ "$1" ] && kubectl config use-context $1 || kubectl config current-context ; } ; f'
alias kdx='f() { [ "$1" ] && kubectl config delete-context $1 || echo "error: missing argument <context>" ; } ; f'
alias kpf='f() { [ $# -eq 2 ] && kubectl port-forward svc/$1 $2 || echo "usage: kpf <svc> <port>" ; } ; f'

# misc
alias dot='git --git-dir=$HOME/.dot/ --work-tree=$HOME'
alias vim="nvim"
alias docker-prune="docker system prune --all --force --volumes"
alias ls="colorls --group-directories-first"
alias h="$HOME"
alias tf="terraform"
alias t="tmux"


###########
# Sources #
###########

# colorls autocomplete
if [ -x $(which gem) ]; then
  if [ -s $(gem which colorls) ]; then
    source $(dirname $(gem which colorls))/tab_complete.sh
  else
    echo "colorls not installed"
  fi
else
  echo "gem not installed"
fi

# z
if [ -s "$(brew --prefix)/etc/profile.d/z.sh" ]; then
  source "$(brew --prefix)/etc/profile.d/z.sh"
else
  echo "z not installed"
fi

# asdf
if [ -s "$(brew --prefix asdf)/libexec/asdf.sh" ]; then
  . "$(brew --prefix asdf)/libexec/asdf.sh"
else
  echo "asdf not installed"
fi

# asdf-direnv
if [ -s "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc" ]; then
  source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"
else
  echo "asdf-direnv not installed"
fi

# load .zshrc.nogit
if [ -s $HOME/.zshrc.nogit ]; then
  source $HOME/.zshrc.nogit
else
  echo "no .zshrc.nogit found"
fi


###########
# Exports #
###########

# set default editor
export EDITOR=nvim

#################
# Run this last #
#################

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
