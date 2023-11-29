################
# Requirements #
################
# + Git        #
# + Ruby + Gem #
# + Dev tools  #
################

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

if [[ -x $(which brew) ]]; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
else
  echo "homebrew not installed"
fi


#####################
# Prezto Zsh Prompt #
#####################

# init prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
else
  if [[ -x "$(which git)" ]]; then
    echo "installing zprezto..."
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
    rm "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zlogin" && ln -s "$HOME/.zlogin" "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zlogin"
    rm "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zlogout" && ln -s "$HOME/.zlogout" "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zlogout"
    rm "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zpreztorc" && ln -s "$HOME/.zpreztorc" "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zpreztorc"
    rm "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zprofile" && ln -s "$HOME/.zprofile" "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zprofile"
    rm "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zshenv" && ln -s "$HOME/.zshenv" "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zshenv"
    rm "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zshrc" && ln -s "$HOME/.zshrc" "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zshrc"
  else
    echo "zprezto not installed -- missing git"
  fi
fi


###########
# Sources #
###########

# z
if [[ -x $(which brew) ]]; then
  if [ -s "$(brew --prefix)/etc/profile.d/z.sh" ]; then
    source "$(brew --prefix)/etc/profile.d/z.sh"
  else
    echo "z not installed"
  fi
else
  echo "brew not found -- skipped z"
fi

# asdf
if [[ -x $(which brew) ]]; then
  if [ -s "$(brew --prefix asdf)/libexec/asdf.sh" ]; then
    . "$(brew --prefix asdf)/libexec/asdf.sh"
  else
    echo "asdf not installed"
  fi
else
  echo "brew not found -- skipped asdf"
fi

# asdf-direnv
if [ -s "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc" ]; then
  source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"
else
  echo "asdf-direnv not installed"
fi

# load .zshrc.nogit if found
if [ -s $HOME/.zshrc.nogit ]; then
  source $HOME/.zshrc.nogit
fi

# colorls autocomplete
if [ -x "$(which gem)" ]; then
  if [ -s "$(gem which colorls)" ]; then
    source $(dirname $(gem which colorls))/tab_complete.sh
  else
    echo "colorls not installed"
  fi
else
  echo "gem not installed"
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
# Exports #
###########

# set default editor
export EDITOR=nvim

#################
# Run this last #
#################

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
