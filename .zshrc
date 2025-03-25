# load modules

zmodload zsh/complist
autoload -U compinit && compinit
autoload -U colors && colors

zstyle ':completion:*' menu select
zstyle ':completion:*' special-dirs true # force . and .. to show in cmp menu
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} ma=0\;33 # colorize cmp menu
zstyle ':completion:*' squeeze-slashes false # explicit disable to allow /*/ expansion

# main opts
setopt append_history inc_append_history share_history # better history
setopt auto_param_slash # when a dir is completed, add a / instead of a trailing space
setopt globdots # include dotfiles
setopt extended_glob # match ~ # ^
setopt interactive_comments # allow comments in shell
stty stop undef # disable accidental ctrl s

# history opts
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE="$HOME/.zsh_history" # move histfile to cache
HISTCONTROL=ignoreboth # consecutive duplicates & commands starting with space are not saved

bindkey "^[[1;5C" forward-word #make Ctrl+Right work
bindkey "^[[1;5D" backward-word #make Ctrl+Left work
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char

export PATH="$PATH:$HOME/bin"
export MANPAGER="less -R --use-color -Dd+r -Du+b" # colored man pages
[[ $(uname -a | grep Darwin) ]] || source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PROMPT="%B%F{red}[%F{yellow}%n%F{green}@%F{blue}%m %F{magenta}%~%F{red}]%F{white}%% %b%f"

