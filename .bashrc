# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples



##################################
### git branch functions
# check https://github.com/magicmonty/bash-git-prompt
# http://stackoverflow.com/questions/2657935/checking-for-a-dirty-index-or-untracked-files-with-git
# https://github.com/jimeh/git-aware-prompt/blob/master/prompt.sh


#############################
function find_git_branch() {
  # Based on: http://stackoverflow.com/a/13003854/170413
  local branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  if [[ ! -z "$branch" ]]; then
    if [[ "$branch" == "HEAD" ]]; then
      branch='detached'
    fi
    git_branch="${branch}"
  else
    git_branch=""
  fi
  echo $git_branch
}


#############################                
function get_git_commid() {
    ### add current commit hash 
    commitid=`git rev-parse --short HEAD 2> /dev/null`                    
    echo "(${commitid})"
}

#############################                
function parse_git() {
    
    ### first check to see if we are in a git branch
    git_str=$(find_git_branch)    
    if [[ ! -z "$git_str" ]]; then        
        ### now check for git dirty state        
        git_str="$(git_com_diff)${git_str}$(find_git_dirty)"
        
        ### add git stats if applicable
        git_str="${git_str}$(find_git_stats)"  
        
        ### add final closing bracket
        git_str="(${git_str})"  
        
        ### add short commitid string
        #git_str="${git_str}$(get_git_commid)"
                            
        ### Final echo that PS prompt sees 
        echo $git_str
    else
        echo ""    
    fi    
}


#############################
function find_git_dirty() {
    gdirtstr=$(git status 2> /dev/null | tail -n1 | sed 's/,//' | awk '{print $1, $2, $3}')
    if [[ ${gdirtstr} == "nothing to commit" ]]
          then
          dirty_state=""            
    elif [[ ${gdirtstr} == "" ]]
          then
          dirty_state=""
    else
          #dirty_state='\[\033[01;38;5;221m\]*'
          dirty_state=""
    fi     
    echo $dirty_state
}

#############################
function git_com_diff() {
    ### Check how far git branch is relative to origin
    gbranchrel=`git status 2> /dev/null | grep "Your branch is"`
    gup=`echo $gbranchrel 2> /dev/null | grep ahead`
    gdown=`echo $gbranchrel 2> /dev/null | grep behind`
    grelN=`echo $gbranchrel | sed -nr 's/.*by ([0-9]+) commit?[a-z]./\1/p'`
  
    ### uniode symbols at : http://panmental.de/symbols/
    gupdown=""
    if [[ $gup != "" ]]; then              
          gupdown="${grelN}↑"
    fi
    
    if [[ $gdown != "" ]]; then              
          gupdown="${grelN}↓"
    fi    
    echo $gupdown
}    



#############################
function find_git_stats() {                   	     
      ##########################################                    
      gporcelain=`git status --porcelain 2> /dev/null`                  
      untrN=`echo $gporcelain | tr ' ' '\n' | grep -w '??' | wc -l` # untracked
      addN=`echo $gporcelain | tr ' ' '\n' | grep -w '^A' | wc -l`  # added            
      modN=`echo $gporcelain | tr ' ' '\n' | grep -w '^M' | wc -l`  # modified                          
      commN=`echo $gporcelain | tr ' ' '\n' | grep -w '^AM' | wc -l`  # added & modified?                 
      delN=`echo $gporcelain | tr ' ' '\n' | grep -w '^D' | wc -l`  # deleted                

      ### Build up visible legend & git stats depending on what is appropriate
      
      gitlegend=""
      gitstats_str=""
      if [[ $untrN != "0" ]]; then
            gitlegend="${gitlegend}${TEAL}u"
            gitstats_str="${gitstats_str}${TEAL}${untrN}"                
      fi
      
      if [[ $addN != "0" ]]; then
            gitlegend="${gitlegend}${LBLUE}a"
            gitstats_str="${gitstats_str}${LBLUE}${addN}"                
      fi        
      
      if [[ $modN != "0" ]]; then
            gitlegend="${gitlegend}${MAGENTA}m"
            gitstats_str="${gitstats_str}${MAGENTA}${modN}"                
      fi                      

      if [[ $commN != "0" ]]; then
            gitlegend="${gitlegend}${HIGreen}c"
            gitstats_str="${gitstats_str}${HIGreen}${commN}"                
      fi       
      
      if [[ $delN != "0" ]]; then
            gitlegend="${gitlegend}${RED}d"
            gitstats_str="${gitstats_str}${RED}${delN}"                
      fi 
      
      ### add "/" charcaters between numbers - WIP
      #gitstats_str=`echo $gitstats_str > /dev/null | sed "s/${gitlegend}/&{gitlegend}\//g"` # | sed 's/\/$//'`
      gitlegend="${gitlegend}${SLATE}: "
      
      
      ### removes the ":" between gitlegend and gitstats_str
      if [[ $gitstats_str == "" ]]; then
            joined_gitstats=""
      else
            joined_gitstats=" ${gitlegend}${gitstats_str}"      
      fi  	             
      echo "${gupdown}${gbranchstr}${dirty_state}${joined_gitstats}"                    	     
}
     




# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(parse_git)\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias git='LANG=en_GB git'


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


