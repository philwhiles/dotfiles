eval "$(/opt/homebrew/bin/brew shellenv)"

export EDITOR=mvim
export GIT_EDITOR=mvim
set -o vi
set -o notify
#export PAGER=/usr/local/bin/vimpager
#alias less=$PAGER
#alias more=$PAGER


# trim the shell persistent history to 50k lines every time bash is launched
#tail -50000 ~/.persistent_history | tee ~/.persistent_history > /dev/null
source ~/Development/thirdparty/pureline/pureline ~/.pureline.conf

log_bash_persistent_history()
{
  [[
    $(history 1) =~ ^\ *[0-9]+\ +(.*)$
  ]]
  local command_part="${BASH_REMATCH[1]}"
  if [ "$command_part" != "$PERSISTENT_HISTORY_LAST" ]
  then
    echo "$command_part" >> ~/.persistent_history
    export PERSISTENT_HISTORY_LAST="$command_part"
  fi
  
}
function _update_ps1() {
    log_bash_persistent_history
}

#if [ "$TERM" != "linux" ]; then
#    PROMPT_COMMAND="_update_ps1"
#fi

man() {
    env \
        LESS_TERMCAP_mb=$'\e[1;31m' \
        LESS_TERMCAP_md=$'\e[1;36m' \
        LESS_TERMCAP_me=$'\e[0m' \
        LESS_TERMCAP_se=$'\e[0m' \
        LESS_TERMCAP_so=$'\e[1;40;92m' \
        LESS_TERMCAP_ue=$'\e[0m' \
        LESS_TERMCAP_us=$'\e[1;32m' \
            man "$@"
}

export LSCOLORS="GxfxcxdxbxegedabagGxGx"
export FZF_PREVIEW_COMMAND="bat -p --color always"


export PATH=$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

#export GO_HOME=/usr/local/go
#export PATH=$PATH:$GO_HOME/bin
#export PATH=$PATH:$(go env GOPATH)/bin
#export GOPATH=$(go env GOPATH)

#export UNITY=/Users/philwhiles/development/workspaces/eclipse/unity

#export NEO4J_HOME=/Users/philwhiles/development/thirdparty/java/neo4j-community-3.4.4
#export PATH=$PATH:$NEO4J_HOME/bin

export PATH=$HOME/bin:$PATH

#export VERTX_HOME=/Users/philwhiles/development/thirdparty/java/vertx-3.3.3
#export PATH=$PATH:$VERTX_HOME/bin

#export SCALA_HOME=/Users/philwhiles/development/thirdparty/java/scala-2.12.6
#export PATH=$PATH:$SCALA_HOME/bin

#export MYSQL_HOME=/usr/local/mysql
#export PATH=$PATH:$MYSQL_HOME/bin

export ANT_HOME=/Users/philwhiles/development/thirdparty/java/apache-ant-1.9.6
export PATH=$PATH:$ANT_HOME/bin

#export CASSANDRA_HOME=/Users/philwhiles/development/thirdparty/java/apache-cassandra-3.10
#export PATH=$PATH:$CASSANDRA_HOME/bin

#export SPARK_HOME=/Users/philwhiles/development/thirdparty/java/spark-2.3.0-bin-hadoop2.7
#export PATH=$PATH:$SPARK_HOME/bin
#export PATH=$PATH:$SPARK_HOME/sbin
#export GOOGLE_APPLICATION_CREDENTIALS=~/.ssh/census-rh-dev-6857a52a4435.json

#export HADOOP_HOME=/Users/philwhiles/development/thirdparty/java/hadoop-2.7.1
#export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native
#export HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib"
#export HADOOP_PREFIX=$HADOOP_HOME
#export PATH=$PATH:$HADOOP_HOME/bin
#xport PATH=$PATH:$HADOOP_HOME/sbin

#export PIG_HOME=/Users/philwhiles/development/thirdparty/java/pig-0.15.0
#export PIG_CLASSPATH=$PATH:$HADOOP_HOME/conf/
#export PATH=$PATH:$PIG_HOME/bin

#export SPRING_BOOT_HOME=/Users/philwhiles/development/thirdparty/java/spring-1.2.3.RELEASE
#export PATH=$PATH:$SPRING_BOOT_HOME/bin

#export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_25.jdk/Contents/Home
#export TOMCAT_HOME=/Users/philwhiles/development/thirdparty/java/apache-tomcat-8.0.18
#export PATH=$PATH:$TOMCAT_HOME
#export PATH=$PATH:$JAVA_HOME/bin
#export ECLIPSE_HOME=~/apps/eclipse/eclipse-luna
#export PATH=$PATH:$ECLIPSE_HOME/bin
export PATH=$PATH:~/bin
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
# extended globbing
shopt -s extglob
# Use case-insensitive filename globbing
shopt -s nocaseglob
#
#
# Maximum number of history lines in memory
export HISTSIZE=50000
# Maximum number of history lines on disk
export HISTFILESIZE=50000
# Ignore duplicate lines
export HISTCONTROL=ignoredups:erasedups
# Make bash append rather than overwrite the history on disk
shopt -s histappend
#

# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
shopt -s cdspell


alias jh='dayone2 new "$@" --journal Home 2>/dev/null 1>/dev/null'
alias jw='dayone2 new "$@" --journal Work 2>/dev/null 1>/dev/null'
alias jd='dayone2 new "$@" --journal DevOps 2>/dev/null 1>/dev/null'
alias jj='dayone2 new "$@" --journal Java 2>/dev/null 1>/dev/null'
alias jb='dayone2 new "$@" --journal Bash 2>/dev/null 1>/dev/null'
alias jt='dayone2 new "$@" --journal Todo 2>/dev/null 1>/dev/null'
alias jf='dayone2 new "$@" --journal Finance 2>/dev/null 1>/dev/null'

alias gbi='gcloud beta interactive'
# If this shell is interactive, turn on programmable completion enhancements.
alias ls='ls -hFG'
# Default to human readable figures
alias ll='ls -l'
alias la='ls -altr'
alias l='ls -CF'
#alias h='history | less +G'
alias h='history'
alias df='df -h'
alias du='du -h'
alias grep='grep --color=always -R'


## hideallfiles - disable finder to see all hidden files
function hideallfiles(){
    defaults write com.apple.finder AppleShowAllFiles -bool NO
    killall Finder
}
## showallfiles - enable finder to see all hidden files
function showallfiles(){
    defaults write com.apple.finder AppleShowAllFiles -bool YES
    killall Finder
}

# Any completions you add in ~/.bash_completion are sourced last.
#case $- in
#   *i*) [[ -f /etc/bash_completion ]] && . /etc/bash_completion ;;
#esac
#case $- in
#   *i*) [[ -f /usr/local/etc/bash_completion.d ]] && . /usr/local/etc/bash_completion.d ;;
#esac
#export PS1="\e[0;32m[\t] [\!] $\e[m "


## cdm - mkdir and immed cd to it
cdm ()
{
  mkdir -p $@ ; cd $@
}

## cdl - cd to the given dir and immed ls
cdl ()
{
    cd $@ && ls
}

pb ()
{
  $@ | pbcopy
}

cd_func ()
{
  local x2 the_new_dir adir index
  local -i cnt

  if [[ $1 == "--" ]]; then
      dirs -v | rev | column -t | rev | sed "s/\([0-9]*\) \(.*\)/\2 \1/"
      return 0
  fi

  the_new_dir=$1
  [[ -z $1 ]] && the_new_dir=$HOME

  if [[ ${the_new_dir:0:1} == '-' ]]; then
      index=${the_new_dir:1}
      [[ -z $index ]] && index=1
      adir=$(dirs +$index)
      [[ -z $adir ]] && return 1
      the_new_dir=$adir
  fi

  [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"

  pushd "${the_new_dir}" > /dev/null
  [[ $? -ne 0 ]] && return 1
  the_new_dir=$(pwd)

  popd -n +11 2>/dev/null 1>/dev/null

  for ((cnt=1; cnt<= 10; cnt++)); do
      x2=$(dirs +${cnt} 2>/dev/null)
      [[ $? -ne 0 ]] && return 0
      [[ ${x2:0:1} == '~' ]] && x2="${HOME}${x2:1}"
      if [[ "${x2}" == "${the_new_dir}" ]]; then
          popd -n +$cnt 2>/dev/null 1>/dev/null
          cnt=cnt-1
      fi
  done
  nom

  return 0
}

alias cd=cd_func

## up - cd .. as far as the given dir
up ()
{
    if [[ $1 > 1 ]]; then
        local my_path=".."
        for i in `seq $(($1-1))`; do
            my_path+="/.."
        done
        cd $my_path
    else
        cd ..
    fi
}

grr ()
{
  echo ""$@
}

#vi ()
#{
#  if [ -z $@ ]; then
#    mvim 2>&1 &
#  else
#    mvim --remote-silent $@  2>&1 &
#  fi
#}

alias vi='mvim'

## trash - move a file to macOS trash can
trash () {
  mv $@ ~/.Trash
}

## deps - easy maven dependencie graph
deps ()
{
  mvn dependency:tree | mvim -
}

## b - bookmark ie b 2, then cd somewhere else. 2 will return to the dir you were in prev
b() { alias $1=cd\ $PWD; }

## setjdk to a given version
function setjdk() {
  if [ $# -ne 0 ]; then
   removeFromPath '/System/Library/Frameworks/JavaVM.framework/Home/bin'
   if [ -n "${JAVA_HOME+x}" ]; then
    removeFromPath $JAVA_HOME
   fi
   export JAVA_HOME=`/usr/libexec/java_home -v $@`
   export PATH=$JAVA_HOME/bin:$PATH
  fi
}

function removeFromPath() {
  export PATH=$PATH:$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")
}

## cl - copy last command executed in shell to clipboard
function cl() {
  fc -ln "$1" "$1" | sed '1s/^[[:space:]]*//' | tr '\n' ' ' | pbcopy
}
#setjdk 1.7.0_75
#setjdk 1.8.0_191
#setjdk 9
#setjdk 10
setjdk 16
alias f='frettler'
source <(~/bin/frettler completion)
complete -F _frettler_completions f
setjdk 16

#alias j11="export JAVA_HOME=`/usr/libexec/java_home -v 11`; java -version"
#alias j10="export JAVA_HOME=`/usr/libexec/java_home -v 10`; java -version"
#alias j9="export JAVA_HOME=`/usr/libexec/java_home -v 9`; java -version"
#alias j8="export JAVA_HOME=`/usr/libexec/java_home -v 1.8`; java -version"
#alias j7="export JAVA_HOME=`/usr/libexec/java_home -v 1.7`; java -version"

#start a simple http server sharing current dir contents
alias webshare='python -m SimpleHTTPServer'

#export PATH=$PATH:"$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/philwhiles/Development/thirdparty/gcloud-sdk/path.bash.inc' ]; then . '/Users/philwhiles/Development/thirdparty/gcloud-sdk/path.bash.inc'; fi

# enable shell command completion for gcloud.
if [ -f '/Users/philwhiles/Development/thirdparty/gcloud-sdk/completion.bash.inc' ]; then . '/Users/philwhiles/Development/thirdparty/gcloud-sdk/completion.bash.inc'; fi

source <(~/bin/gcp completion)
# enable shell command completion for kubectl.
source <(kubectl completion bash)
alias k='kubectl'
complete -F __start_kubectl k

complete -C '/usr/local/bin/aws_completer' aws

# credit to: https://github.com/cloudfoundry/homebrew-tap/blob/master/cf-cli.rb
_fly_compl() {
    # All arguments except the first one
    args=("${COMP_WORDS[@]:1:$COMP_CWORD}")
    # Only split on newlines
    local IFS=$'\n'
    # Call completion (note that the first element of COMP_WORDS is
    # the executable itself)
    COMPREPLY=($(GO_FLAGS_COMPLETION=1 ${COMP_WORDS[0]} "${args[@]}"))
    return 0
}

complete -F _fly_compl fly

# enable shell command completion for brew installed cmds
export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"
if type brew &>/dev/null; then
  for COMPLETION in $(brew --prefix)/etc/bash_completion.d/*
  do
    [[ -f $COMPLETION ]] && source "$COMPLETION"
  done
  if [[ -f $(brew --prefix)/etc/profile.d/bash_completion.sh ]];
  then
    source "$(brew --prefix)/etc/profile.d/bash_completion.sh"
  fi
fi

# For some reason my brew bash completions and git do not mesh so I had to resort to the following
source ~/.git-completion.bash

# FZF needs to come after the completions shananighans above
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

## fgv - fuzzy grep then edit selection in vim at line and col of match
fgv() {
  [ $# -eq 0 ] && return
  local out cols
  if out=$(rg --vimgrep "$@" 2>/dev/null | fzf); then
    cols=(${out//:/ })
    mvim ${cols[0]} +"normal! ${cols[1]}zz"
  fi
}

## viz - fzf then vim
viz() {
  mvim $(fzf)
}

## cdz - cd to selected directory 
cdz() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

## fcda - fcd including hidden directories
fcda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

## fph - search global persistent history
fph() {
  cat ~/.persistent_history|fzf
}

fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}



## fbr - checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
fbr() {
  is_in_git_repo || return

  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

## fco - checkout git branch/tag
fco() {
  is_in_git_repo || return

  local tags branches target
  tags=$(
    git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
  branches=$(
    git branch --all | grep -v HEAD             |
    sed "s/.* //"    | sed "s#remotes/[^/]*/##" |
    sort -u          | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
    (echo "$tags"; echo "$branches") |
    fzf-tmux -l30 -- --no-hscroll --ansi +m -d "\t" -n 2) || return
  git checkout $(echo "$target" | awk '{print $2}')
}


## fco_preview - checkout git branch/tag, with a preview showing the commits between the tag/branch and HEAD
fco_preview() {
  is_in_git_repo || return

  local tags branches target
  tags=$(
git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}') || return
  branches=$(
git branch --all | grep -v HEAD |
sed "s/.* //" | sed "s#remotes/[^/]*/##" |
sort -u | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}') || return
  target=$(
(echo "$tags"; echo "$branches") |
    fzf --no-hscroll --no-multi --delimiter="\t" -n 2 \
        --ansi --preview="git log -200 --pretty=format:%s $(echo {+2..} |  sed 's/$/../' )" ) || return
  git checkout $(echo "$target" | awk '{print $2}')
}

## fcoc - checkout git commit
fcoc() {
  is_in_git_repo || return

  local commits commit
  commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}

## gitlog - git commit browser
gitlog() {
  is_in_git_repo || return

  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
--preview="$_viewGitLogLine" \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}
alias glNoGraph='git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" "$@"'
_gitLogLineToHash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
_viewGitLogLine="$_gitLogLineToHash | xargs -I % sh -c 'git show --color=always % | diff-so-fancy'"

## gitlogview - checkout git commit with previews
gitlogview() {
  is_in_git_repo || return

  local commit
  commit=$( glNoGraph |
    fzf --no-sort --reverse --tiebreak=index --no-multi \
        --ansi --preview="$_viewGitLogLine" ) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}

## fshow_preview - git commit browser with previews
fshow_preview() {
  is_in_git_repo || return

    glNoGraph |
        fzf --no-sort --reverse --tiebreak=index --no-multi \
            --ansi --preview="$_viewGitLogLine" \
                --header "enter to view, alt-y to copy hash" \
                --bind "enter:execute:$_viewGitLogLine   | less -R" \
                --bind "alt-y:execute:$_gitLogLineToHash | xclip"
}

#Compare against master branch with git-stack

## fcs - get git commit sha
# example usage: git rebase -i `fcs`
fcs() {
  is_in_git_repo || return

  local commits commit
  commits=$(git log --color=always --pretty=oneline --abbrev-commit --reverse) &&
  commit=$(echo "$commits" | fzf --tac +s +m -e --ansi --reverse) &&
  echo -n $(echo "$commit" | sed "s/ .*//")
}

## fstash - easier way to deal with stashes
# type fstash to get a list of your stashes
# enter shows you the contents of the stash
# ctrl-d shows a diff of the stash against your current HEAD
# ctrl-b checks the stash out as a branch, for easier merging
fstash() {
  local out q k sha
  while out=$(
    git stash list --pretty="%C(yellow)%h %>(14)%Cgreen%cr %C(blue)%gs" |
    fzf --ansi --no-sort --query="$q" --print-query \
        --expect=ctrl-d,ctrl-b);
  do
    mapfile -t out <<< "$out"
    q="${out[0]}"
    k="${out[1]}"
    sha="${out[-1]}"
    sha="${sha%% *}"
    [[ -z "$sha" ]] && continue
    if [[ "$k" == 'ctrl-d' ]]; then
      git diff $sha
    elif [[ "$k" == 'ctrl-b' ]]; then
      git stash branch "stash-$sha" $sha
      break;
    else
      git stash show -p $sha
    fi
  done
}

#Create a gitignore file from gitignore.io:

#https://gist.github.com/phha/cb4f4bb07519dc494609792fb918e167

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

## fgst - pick files from `git status -s` 
fgst() {
  is_in_git_repo || return

  local cmd="${FZF_CTRL_T_COMMAND:-"command git status -s"}"

  eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS" fzf -m "$@" | while read -r item; do
    echo "$item" | awk '{print $2}'
  done
  echo
}

## fda Select a docker container to start and attach to
function fda() {
  local cid
  cid=$(docker ps -a | sed 1d | fzf -1 -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker start "$cid" && docker attach "$cid"
}
## fds Select a running docker container to stop
function fds() {
  local cid
  cid=$(docker ps | sed 1d | fzf -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker stop "$cid"
}

## fkill - kill processes - list only the ones you can kill. Modified the earlier script.
fkill() {
    local pid 
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi  

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi  
}


## peek - fzf files with bat preview
peek() {
  fzf --preview="bat -p --color always -H {2} --style=header,grid {}"
}

## grepz [text]- ripgrep fuzzy with preview
grepz() {
  rg --vimgrep $1 | fzf --delimiter=':' \
    --bind "ctrl-v:execute:vi {}" \
    --nth=1 --preview='bat -p --color always -H {2} --line-range={2}: --style=header,grid {1}'
}

alias tree='tree -C'

complete -C /usr/local/Cellar/tfenv/0.6.0/versions/0.11.11/terraform terraform

bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"



#source /opt/intel/openvino/bin/setupvars.sh > /dev/null
