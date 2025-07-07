# added by me on 1/27/25 after struggling with ghostty for a bit
# Ghostty shell integration for Bash. This must be at the top of your bashrc!
if [ -n "${GHOSTTY_RESOURCES_DIR}" ]; then
    builtin source "${GHOSTTY_RESOURCES_DIR}/shell-integration/bash/ghostty.bash"
fi

export PS1="\[\033[92m\]\t\[\033[00m\] @\W $ "
# tried out new background color for timestamp
# export PS1="\[\e[47m\033[92m\]\t\[\033[00m\] @\W $ "
export CLICOLOR=1;
alias ls='ls -G'

eval "$(/opt/homebrew/bin/brew shellenv)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
. "$HOME/.cargo/env"
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh
chruby ruby-3.1.3

# Created by `pipx` on 2024-07-13 19:01:55
export PATH="$PATH:/Users/charlieluo/.local/bin"

# pyenv setup
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export PATH="/Users/charlieluo/.local/share/sentry-devenv/bin:$PATH"
