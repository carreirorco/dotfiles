[[ $- != *i* ]] && return

# Append to the history file, don't overwrite it
shopt -s histappend
# Save multi-line commands as one command
shopt -s cmdhist
# Append cd command when a directory's name is typed
shopt -s autocd
# autocorrect minor spelling errors in directory name (both)
shopt -s dirspell
shopt -s cdspell

HISTSIZE=500000
HISTFILESIZE=100000

# Avoid duplicate entries
HISTCONTROL="erasedups:ignoreboth"

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history"

# Useful timestamp format
HISTTIMEFORMAT='%F %T '

case "$TERM" in
    xterm|xterm-color|*-256color) color_prompt=yes;;
esac

export PS1="\[\033[38;5;1m\][\[$(tput sgr0)\]\[\033[38;5;40m\]\u\[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;1m\]@\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;40m\]\h\[$(tput sgr0)\]\[\033[38;5;1m\]]\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput bold)\]\w\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;1m\]\\$\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"

alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias mkdir='mkdir -pv '


#
# Aliases for ssh connection
#
alias ssh-ecca01='ssh root@ecca01 -p2297'
alias ssh-ecca02='ssh root@ecca02 -p2297'
alias ssh-ecva01='ssh root@ecva01 -p2297'
alias ssh-ecsp='ssh root@ecsp -p2297'
alias ssh-upgrade='ssh root@upgrade -p2297'
alias ssh-files='ssh root@arcafiles -p2297'
alias ssh-elasticv112='ssh root@elasticv112 -p2297'
alias arca-ssh='ssh -p 2297 -l root '


alias digital_ocean_list_only_edirectory='doctl compute droplet list --format Name,PublicIPv4,Tags --no-header | grep -E "[^,]edirectory$"'
#
# Pacman Alias
#
alias install="sudo pacman -S --noconfirm "
alias updatey="sudo pacman -Syu --noconfirm"
alias upgrade="yaourt -Syua";
alias remove="sudo pacman -Rs"
alias cleanpacman="pacman -Qtdq > /dev/null && sudo pacman -Rns \$(pacman -Qtdq | sed -e ':a;N;$!ba;s/\n/ /g')";
alias optimizepacman="sudo sudo pacman -Sc && sudo pacman-optimize && cleanpacman";
alias cleanmemory="sync && echo 3 | sudo tee /proc/sys/vm/drop_caches";


#
# Another things
# 
alias anon='cd /opt/tor && ./start-tor-browser.desktop && cd -'
alias music-download='youtube-dl -citx --audio-format=mp3 "$@"'
alias video-download='youtube-dl -cit --default-search "$@"'
alias suspend='i3lock -c 000000 && systemctl suspend'


#
# Explain commands
#
explain () {
  if [ "$#" -eq 0 ]; then
    while read  -p "Command: " cmd; do
      curl -Gs "https://www.mankier.com/api/explain/?cols="$(tput cols) --data-urlencode "q=$cmd"
    done
    echo "Bye!"
  elif [ "$#" -eq 1 ]; then
    curl -Gs "https://www.mankier.com/api/explain/?cols="$(tput cols) --data-urlencode "q=$1"
  else
    echo "Usage"
    echo "explain                  interactive mode."
    echo "explain 'cmd -o | ...'   one quoted command to explain it."
  fi
}


#
# My Functions
#
function new_post(){ 
	> ~/Projects/carreirorco.github.io/_posts/$(date +%Y-%m-%d)-"$1".md
}

new_pass(){
	if [[ -z "$1" ]] ; then i=16 ; else i=$1 ; fi
	a=$(cat /dev/urandom | tr -dc '[a-zA-Z0-9_]*&%@' | head -c $i)
	echo "$a"
}

ssh_create_config(){
	echo -e "Host *\n    StrictHostKeyChecking no" > ~/.ssh/config && chmod 400 ~/.ssh/config
}

translate(){
	gawk -f <(curl -Ls git.io/translate) -- -shell
}

synclient TapButton1=1 TapButton2=2 TapButton3=3

export BASHSRC_PATH=$HOME/bashsrc
export PATH=$PATH:$BASHSRC_PATH/src
export PATH=$PATH:$BASHSRC_PATH/bin
