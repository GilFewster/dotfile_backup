# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/gilfewster/.oh-my-zsh"

DEFAULT_USER=`whoami`

# Precede a command with a single space 
# to prevent it from being saved in the 
# shell history.
setopt HIST_IGNORE_SPACE
source $ZSH/oh-my-zsh.sh
# source ~/.zsh_theme
###########################################################
#                         Antigen                         #
# Plugin manager - https://github.com/zsh-users/antigen   #
# ###########################################################

source /Users/gilfewster/antigen.zsh

ANTIGEN_LOG=/Users/gilfewster/antigen.log
# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle dirhistory
antigen bundle extract
antigen bundle osx
antigen bundle node
antigen bundle npm
antigen bundle python
antigen bundle z
#antigen bundle tmuxinator

# # Syntax highlighting bundle.
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

# # load theme
antigen theme romkatv/powerlevel10k

# # Tell Antigen that you're done.
antigen apply

export EDITOR='nvim'

###################################
#             PyEnv               #
###################################
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/dev
eval "$(pyenv init -)"

# Setup auto-activation for pyenv-virtualenv
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi


COMPLETION_WAITING_DOTS="true"

# ALIASES
# See ~/.zsh_aliases 
. ~/.zsh_aliases


###################################
#          THEME SETTINGS         #
#                                 #
#     >>> TO CUSTOMISE THEME  <<  #
#     >>> run `p10k configure`<<  #
###################################

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Override Some Defaults
POWERLEVEL9K_MODE='nerdfont-complete'
# POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
# POWERLEVEL9K_SHORTEN_DELIMITER="..."
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_to_last"
POWERLEVEL9K_HIDE_BRANCH_ICON=true
POWERLEVEL9K_STATUS_HIDE_SIGNAME=true
# POWERLEVEL9K_DIR_FOREGROUND="grey19"
# POWERLEVEL9K_DIR_BACKGROUND="grey89"
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status dir_writable)

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true


##########################
#          RBENV         #
##########################

eval "$(rbenv init -)"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

##########################
#           GO           #
##########################

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

#########################
#        DIRENV         #
#########################
eval "$(direnv hook zsh)"

#########################
#          NVM          #
#########################
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
PATH=$(pyenv root)/shims:$PATH

#########################
#         NNN           #
#########################

n ()
{
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # To cd on quit only on ^G, either remove the "export" as in:
    #    NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    #    (or, to a custom path: NNN_TMPFILE=/tmp/.lastd)
    # or, export NNN_TMPFILE after nnn invocation
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}
