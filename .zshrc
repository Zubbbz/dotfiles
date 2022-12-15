# Created by newuser for 5.9
export WINIT_X11_SCALE_FACTOR=1

eval "$(starship init zsh)"

# ssh shit
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent`
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
  ssh-add /home/nathan/.ssh/zubbbztas
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l > /dev/null || ssh-add

# tmux ftw (I don't want tmux in the vscode terminal tho)
CURRENT_TERMINAL=$(ps -p $PPID -o comm=)
# echo $CURRENT_TERMINAL
if [[ -z "$TMUX" && $CURRENT_TERMINAL != "code" ]]; then
  tmux attach || tmux new-session -s main
fi

# fix fucking ass bindings
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[5~" beginning-of-history
bindkey "\e[6~" end-of-history
bindkey "\e[7~" beginning-of-line
bindkey "\e[3~" delete-char
bindkey "\e[2~" quoted-insert
bindkey "\e[5C" forward-word
bindkey "\e[5D" backward-word
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word
bindkey "\e[8~" end-of-line
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line
