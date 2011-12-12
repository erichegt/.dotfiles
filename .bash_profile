# git
function parse_git_dirty {
    [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}

function parse_git_branch {
    GIT_COLOR='\e[1;37m'
    if [[ $(parse_git_dirty) == '*' ]] ; then
        GIT_COLOR='\e[0;32m'
    fi
    GIT_BRANCH=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/")
    echo $GIT_BRANCH
}

#aliases:
alias rfjs="cd /Ricardo/Programming/projects/restfulie-javascript"
alias rfjss="rfjs;cd server/rest_in_practice/part_3/;script/server;"
alias 2do="cd /Ricardo/Programming/projects/gimme2dolist/;rvm 1.8.7-p299@gimme2dolist;prompt;"
alias sbp="source ~/.bash_profile"
alias kp="ps auxwww"
alias ss="/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine -background &"
alias tile="~/scripts/tile.sh"
alias firefox="/Applications/Firefox.app/Contents/MacOS/firefox-bin"

#rvm
if [ -s ~/.rvm/scripts/rvm ] ; then source ~/.rvm/scripts/rvm ; fi

if [ -f ~/.git-completion.bash ] ; then source ~/.git-completion.bash ; fi

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export PATH=/Users/ricardo/.gem/ruby/1.8/bin:/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:$PATH
#export PATH=/usr/share/java/Tools/dev/jruby-1.5.1/bin:$PATH
export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/usr/local/spidermonkey/lib

WHITE="\[\033[1;37m\]" 
BRIGHTGREEN="\[\033[1;32m\]" 
GREEN="\[\033[0;32m\]" 
CYAN="\[\033[0;36m\]" 
GRAY="\[\033[0;37m\]"
#export PS1="${WHITE}\u@\h ${GREEN}\W${WHITE} ${CYAN}$(rvm-prompt i v p g) ${WHITE}$(parse_git_branch)${GRAY}$ "

#PS1='[\u@\h] [\[\033[0;36m\]$(rvm-prompt i v p g)\[\033[0m\]] \[\033[1;33m\]\w\a\[\033[0m\]$(__git_ps1 " \[\033[1;32m\](%s)\[\033[0m\]")\n\$ ' 
PS1='[\u@\h] [\[\033[0;36m\]$(rvm-prompt i v p g)\[\033[0m\]] \[\033[1;33m\]\w\a\[\033[0m\] $(parse_git_branch)\n\$ ' 
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

#pair script:
export PATH=~/.dotfiles/scripts/pair/:$PATH

#scripts:
export PATH=~/.dotfiles/scripts/:$PATH
