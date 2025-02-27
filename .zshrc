echo '====================='
echo sourcing .zshrc

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

export EDITOR="/usr/local/bin/subl --wait"
export VISUAL="$EDITOR"

export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1
export HOMEBREW_GITHUB_API_TOKEN_=539ebfe1f10a686d45c3fcd381287321326411cf

export MANPAGER="sh -c 'col -bx | bat -l man -p'"

export PKG_CONFIG_PATH=/usr/local/opt/openssl/lib/pkgconfig

# must be set before loading OMZP::brew
BREW_LOCATION=/usr/local/Homebrew/bin/brew

# must be set before loading OMZL::history.zsh
HIST_STAMPS="yyyy-mm-dd"

# must be set before loading OMZP::pj
PROJECT_PATH_BASE=~/Developer/
PROJECT_PATHS=($PROJECT_PATH_BASE `ls -1d $PROJECT_PATH_BASE*/`)

#### From zplug-based zshrc
#
echo 'sourcing .zshrc -> OMZ libraries'

zi snippet OMZL::async_prompt.zsh
zi snippet OMZL::completion.zsh
zi snippet OMZL::directories.zsh
zi snippet OMZL::functions.zsh
zi snippet OMZL::git.zsh
zi snippet OMZL::grep.zsh
zi snippet OMZL::history.zsh
zi snippet OMZL::key-bindings.zsh
zi snippet OMZL::misc.zsh
zi snippet OMZL::nvm.zsh
zi snippet OMZL::prompt_info_functions.zsh
zi snippet OMZL::spectrum.zsh
# zi snippet OMZL::termsupport.zsh
zi snippet OMZL::theme-and-appearance.zsh

echo 'sourcing .zshrc -> OMZ plugins'

zi snippet OMZP::aws
zi snippet OMZP::brew
zi snippet OMZP::bundler
zi snippet OMZP::command-not-found
zi snippet OMZP::common-aliases
zi snippet OMZP::cp
zi snippet OMZP::extract
zi snippet OMZP::fzf
zi snippet OMZP::git
zi snippet OMZP::git-extras
zi snippet OMZP::git-flow-avh
zi snippet OMZP::github
zi snippet OMZP::gitignore
zi snippet OMZP::heroku
zi snippet OMZP::perms
zi snippet OMZP::pj
zi snippet OMZP::postgres
zi snippet OMZP::rails
zi snippet OMZP::rvm
zi snippet OMZP::sublime
# zi snippet OMZP::tmux
zi snippet OMZP::tmuxinator
zi snippet OMZP::web-search

# Add in zsh plugins
# zi load wfxr/forgit
zi load Tarrasch/zsh-autoenv

zi light aloxaf/fzf-tab  # Replace zsh's default completion selection menu with fzf!
zi light zsh-users/zsh-completions
zi light zsh-users/zsh-autosuggestions


echo 'sourcing .zshrc -> local zsh config'

# Local config
zi ice pick'zsh/aliases.zsh' multisrc'zsh/*.zsh'
zi load banzera/tilde

########
# Load completions
autoload -Uz compinit && compinit

zi cdreplay -q

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# force zsh not to show completion menu, which allows fzf-tab
# to capture the unambiguous prefix
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always $realpath'


# Shell integrations
# eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"
## ruby version managers
# eval "$(asdf init)"
# eval "$(frum init)"
# eval "$(mise activate zsh)"
echo "sourcing rvm: .rvm/scripts/rvm"
. ~/.rvm/scripts/rvm

