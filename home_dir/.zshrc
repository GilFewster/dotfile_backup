# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# oh-my-zsh path.
export ZSH="/Users/gilfewster/.oh-my-zsh"

DEFAULT_USER=`whoami`

# Precede a command with a single space
# to prevent it from being saved in the
# shell history.
setopt HIST_IGNORE_SPACE
source $ZSH/oh-my-zsh.sh


############################################################
######## // Node/Python/Ruby/etc version managers ##########
############################################################

# -------FNM  Fast Node Manager------- #
export PATH="/Users/gilfewster/Library/Caches/fnm_multishells/95141_1709978079208/bin":$PATH
export FNM_NODE_DIST_MIRROR="https://nodejs.org/dist"
export FNM_LOGLEVEL="info"
export FNM_COREPACK_ENABLED="false"
export FNM_MULTISHELL_PATH="/Users/gilfewster/Library/Caches/fnm_multishells/95141_1709978079208"
export FNM_VERSION_FILE_STRATEGY="local"
export FNM_RESOLVE_ENGINES="false"
export FNM_ARCH="x64"
export FNM_DIR="/Users/gilfewster/Library/Application Support/fnm"
rehash
eval "$(fnm env --use-on-cd)"

# -------DirEnv------- #
eval "$(direnv hook zsh)"

###########################################################
#                         Antigen                         #
# Plugin manager - https://github.com/zsh-users/antigen   #
############################################################

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

# Syntax highlighting bundle
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

# load theme
antigen theme romkatv/powerlevel10k

# Tell Antigen that you're done.
antigen apply

export EDITOR='nvim'
COMPLETION_WAITING_DOTS="true"

########################
#       ALIASES        #
########################
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


##### iterm 2 shell integration ? ######
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

##########################
#           GO           #
##########################

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

eval $(thefuck --alias)

export PATH="/usr/local/sbin:$PATH"
