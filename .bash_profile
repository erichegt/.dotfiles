# git
GIT_COLOR='\e[0;37m'
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
function parse_git_branch {
  echo $(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/")
}

function to_branch {
    if [ $1 ] ; then to_branch=$1 ; else to_branch="master" ; fi;
    echo $to_branch
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

if [ -f ~/.git-completion.bash ] ; then source ~/.git-completion.bash ; fi

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export PATH=/Users/ricardo/.gem/ruby/1.8/bin:/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:$PATH
#export PATH=/usr/share/java/Tools/dev/jruby-1.5.1/bin:$PATH
export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/usr/local/spidermonkey/lib

function current_ruby {
  #current_ruby=$(rvm-prompt i v p g)
  #if [[ $current_ruby == "" ]]; then
  #  current_ruby=$(ruby -e "v = %x(ruby -v).split(' '); puts \"#{v[0]}-#{v[1]} (non-rvm)\"")
  #fi
  #echo $current_ruby
  ruby -v | ruby -e 'puts "rubái #{gets.chop.split(" ")[1]}"'
}


PS1="[\u@\h] [\e[0;30m$(current_ruby)\e[m] \e[0;33m\w\a\e[m $(parse_git_branch)\n\$ " 

#pair script:
export PATH=~/.dotfiles/scripts/pair/:$PATH

#scripts:
export PATH=~/.dotfiles/scripts/:$PATH
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
