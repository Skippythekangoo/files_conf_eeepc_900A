#!/bin/bash # based on a function found in bashtstyle-ng 5.0b1
# Original author Christopher Roy Bratusek (http://www.nanolx.org)
# Last arranged by ayoli (http://ayozone.org) 2008-02-04 17:16:43 +0100 CET 

function pre_prompt {
newPWD="${PWD}"
user="whoami"
host=$(echo -n $HOSTNAME | sed -e "s/[\.].*//")
datenow=$(date "+%a, %d %b %y")
let promptsize=$(echo -n "┌($user@$host ddd., DD mmm YY)(${PWD})┐" \
                 | wc -c | tr -d " ")
let fillsize=${COLUMNS}-${promptsize}
fill=""
while [ "$fillsize" -gt "0" ] 
do 
    fill="${fill}─"
	let fillsize=${fillsize}-1
done
if [ "$fillsize" -lt "0" ]
then
    let cutt=3-${fillsize}
    newPWD="...$(echo -n $PWD | sed -e "s/\(^.\{$cutt\}\)\(.*\)/\2/")"
fi

}

PROMPT_COMMAND=pre_prompt

# Couleurs
export black="\[\033[0;38;5;0m\]"
export red="\[\033[0;38;5;1m\]"
export orange="\[\033[0;38;5;130m\]"
export green="\[\033[0;38;5;2m\]" export yellow="\[\033[0;38;5;3m\]" export blue="\[\033[0;38;5;4m\]" export bblue="\[\033[0;38;5;12m\]"
export magenta="\[\033[0;38;5;55m\]"
export cyan="\[\033[0;38;5;6m\]"
export white="\[\033[0;38;5;7m\]"
export coldblue="\[\033[0;38;5;33m\]"
export smoothblue="\[\033[0;38;5;111m\]"
export iceblue="\[\033[0;38;5;45m\]"
export turqoise="\[\033[0;38;5;50m\]"
export smoothgreen="\[\033[0;38;5;42m\]"

# Cool extreme éditeur de texte
export EDITOR="/usr/bin/vim"

case "$TERM" in 
 xterm) 
    PS1="$cyan┌─($orange\u@\h \$(date \"+%a, %d %b %y\")$cyan)─\${fill}─($orange\$newPWD\
$cyan)─┐\n$cyan└─($orange\$(date \"+%H:%M\") \$$cyan)─>$white"
    ;;
screen)
    PS1="$bblue┌─($orange\u@\h \$(date \"+%a, %d %b %y\")$bblue)─\${fill}─($orange\$newPWD\
#$bblue)─┐\n$bblue└─($orange\$(date \"+%H:%M\") \$$bblue)─>$green "
    ;;
    *)
    PS1="┌─(\u@\h \$(date \"+%a, %d %b %y\"))─\${fill}─(\$newPWD\)─┐\n└─(\$(date \"+%H:%M\") \#)─> " ;; esac

# bash_history settings: size and no duplicates and no lines w/ lead spaces
# Permet de ne pas mettre de doublons dans l'history de bash
export HISTCONTROL="ignoreboth"
export HISTSIZE=1024

# aliases
############################################# 

# enable color support of ls and also add handy aliases eval `dircolors -b` 
alias ls='ls --color=auto'
alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'

# some more ls aliases
alias ll='ls -lhX'
alias la='ls -A'
alias ldir='ls -lhA |grep ^d'
alias lfiles='ls -lhA |grep ^-'
alias l='ls -CF'

# To see something coming into ls output: lss
alias lss='ls -lrt | grep $1'

# To check a process is running in a box with a heavy load: pss
alias pss='ps -ef | grep $1'

# usefull alias to browse your filesystem for heavy usage quickly
alias ducks='ls -A | grep -v -e '\''^\.\.$'\'' | xargs -i du -ks {} | sort -rn | head -16 | awk '\''{print $2}'\'' | xargs -i du -hs {}'

# cool colors for manpages
#alias man="TERMINFO=~/.terminfo TERM=mostlike LESS=C PAGER=less man"

# Cool exiting vim like
alias :q='exit'

# Synergys, partage clavier ecran
#alias synergy_stk='synergys --restart --daemon --log .synergys.log --address 192.168.0.2'
alias stk_synergy='synergys --restart --log .synergys.log --address 192.168.0.2'

# Affiche la date du jour YYmmdd
alias stk_today='date +%Y%m%d'
# Affiche la date du jour et l'heure
alias stk_now='date +%Y%m%d_%H%M%S'
# Re-source le bashrc
alias stk_rebashrc='source $HOME/.bashrc'

# Recherche les fichiers installés avec pacman avec une recherche de description "pacman -Qs"
stk_search_package_files() {
    pacman -Qs $1 | cut -d '/' -f 2 | cut -d ' ' -f 1 | pacman -Ql -
}

# efface le fichier /var/lib/pacman/db.lck
alias stk_rm_pacman='rm /var/lib/pacman/db.lck'

# Affiche la taille de la racine
alias stk_df_root='df -h | grep sda7'

# ssh autocompletion, voir $HOME/.ssh/config
# http://www.kopfpit.de/wordpress/2013/12/18/ssh-config-and-auto-completion/
function _ssh_completion() {
    perl -ne 'print "$1 " if /^Host (.+)$/' ~/.ssh/config
}
complete -W "$(_ssh_completion)" ssh

stk_help_commands() {
    echo ":q                  ### Cool exiting vim like."
    echo "ducks               ### Usefull alias to browse your filesystem for heavy usage quickly."
    echo "lss                 ### To see something coming into ls output."
    echo "pss                 ### To check a process is running in a box with a heavy load."
    echo "dir                 ### List files with vertical format like 'ls'."
    echo "vdir                ### List files with long format."
    echo "ll                  ### List files with -lhX options."
    echo "la                  ### List files with -A option."
	echo "ldir                ### Affiche seulement les repertoires."
    echo "lfile               ### Affiche seulement les fichiers."
    echo "l                   ### List files with -CF options."
    echo "stk_synergy         ### Execute synergy."
    echo "stk_today           ### Affiche la date du jour \"à l'anglaise\""
    echo "stk_now             ### Affiche la date et l'heure"
    echo "search_package_file ### Recherche les fichiers installés avec pacman avec une recherche de description \"pacman -Qs\""
    echo "stk_rm_pacman       ### Supprime le fichier /var/lib/pacman/db.lck quand pacman renvoit le message d'erreur \"Pacman est actuellement utilisé, veuillez patienter\""
}

# this, if it's already enabled in /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
# Completion après les commandes 'sudo' et 'man'
complete -cf sudo
complete -cf man

# CDPATH initialisation
CDPATH=.:~:/media/store:/media/sites

# PATH initialisation
HOME_BIN=$HOME/bin
HOME_BASH=$HOME_BIN/bash
HOME_PERL=$HOME_BIN/perl
HOME_PYTHON=$HOME_BIN/python
HOME_RUBY=$HOME_BIN/ruby
PATH=$HOME_BIN:$HOME_BASH:$HOME_BASH/9box:$HOME_BASH/aircrack:$HOME_BASH/chkbd:$HOME_BASH/chroot:$HOME_BASH/dialog:$HOME_BASH/meteo:$HOME_BASH/mpd:$HOME_BASH/pacman:$HOME_BASH/serveur:$HOME_BASH/svg2png:$HOME_BASH/utils:$HOME_PERL:$HOME_PYTHON:$HOME_RUBY:/opt/android-sdk/tools:/opt/android-sdk/platform-tools:/opt/ryzomi:$PATH

# MANPAGER
export MANPAGER="/bin/sh -c \"sed -e 's/.$(echo -e '\010')//g' | vim -R -c 'set ft=man nomod nolist nonumber mouse=a' -c 'map q :q<CR>' -c 'map <SPACE> <C-D>' -c 'map b <C-U>' -\""

WINEDEBUG=-all
