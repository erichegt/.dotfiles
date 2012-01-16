# git
function parse_git_dirty {
    git_dirty=$(git status 2> /dev/null | tail -n1)
    if [[ $git_dirty != "" && $git_dirty != "nothing to commit (working directory clean)" ]]; then
      echo "*"
    fi
}

function current_branch_name {
    current_branch_name="$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1/")"
    echo $current_branch_name
}

function to_branch {
    if [ $1 ] ; then to_branch=$1 ; else to_branch="master" ; fi;
    echo $to_branch
}

function parse_git_branch {
    GIT_COLOR='\e[1;37m'
    if [[ $(parse_git_dirty) == '*' ]] ; then
        GIT_COLOR='\e[0;32m'
    fi
    GIT_BRANCH="$(current_branch_name)$(parse_git_dirty)"
    if [[ $GIT_BRANCH != "" ]]; then
      GIT_BRANCH="[$GIT_BRANCH]"
    fi
    echo $GIT_BRANCH
}

function rebasing_like_a_boss {
    current_branch=$(current_branch_name)
    to_branch=$(to_branch)

    if [[ $current_branch == 'master' ]]; then
      git pull && git push
    else
      git co $to_branch && git pull && git rebase $current_branch && git pull && git push && git co $current_branch && git rebase $to_branch
    fi
}

function pulando_like_a_boss {
    current_branch=$(current_branch_name)
    to_branch=$(to_branch)
    git co $to_branch && git pull && git co $current_branch && git rebase $to_branch
}

alias gitgo="rebasing_like_a_boss"
alias gitpull="pulando_like_a_boss"

#aliases:
alias sbp="source ~/.bash_profile"
alias kp="ps auxwww"
alias ss="/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine -background &"
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

function current_ruby {
  current_ruby=$(rvm-prompt i v p g)
  if [[ $current_ruby == "" ]]; then
    current_ruby=$(ruby -e "v = %x(ruby -v).split(' '); puts \"#{v[0]}-#{v[1]} (non-rvm)\"")
  fi
  echo $current_ruby
}

PS1='[\u@\h] [\[\033[0;36m\]$(current_ruby)\[\033[0m\]] \[\033[1;33m\]\w\a\[\033[0m\] $(parse_git_branch)\n\$ ' 
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

#pair script:
export PATH=~/.dotfiles/scripts/pair/:$PATH

#scripts:
export PATH=~/.dotfiles/scripts/:$PATH
