#mac colorized terminal output
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

#rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# git
if [ -f ~/.git-completion.bash ] ; then source ~/.git-completion.bash ; fi

function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
}

#aliases:
alias sbp="source ~/.bash_profile"
alias kp="ps auxwww"
alias ss="open /System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app"

alias firefox="open /Applications/Firefox.app"
alias chrome="open /Applications/Google\ Chrome.app"
alias please="bundle exec rake"
export PATH=/Users/ricardo/.gem/ruby/1.8/bin:/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:$PATH
export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/usr/local/spidermonkey/lib:/usr/local/mysql/lib/

function current_ruby {
  #current_ruby=$(rvm-prompt i v p g)
  #if [[ $current_ruby == "" ]]; then
  #  current_ruby=$(ruby -e "v = %x(ruby -v).split(' '); puts \"#{v[0]}-#{v[1]} (non-rvm)\"")
  #fi
  #echo $current_ruby
  ruby -v | ruby -e 'puts "rubái #{gets.chop.split(" ")[1]}"'
}

#pair script:
export PATH=~/.dotfiles/scripts/pair/:$PATH

#scripts:
export PATH=~/.dotfiles/scripts/:$PATH

PS1="[\u@\h] [\e[0;30m$(current_ruby)\e[m] \e[0;33m\w\a\e[m $(parse_git_branch)\n\$ " 
