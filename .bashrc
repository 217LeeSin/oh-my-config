# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

#if [ -f ~/.bashrc ]; then
#	. ~/.bashrc
#fi

#############################
function find_git_branch() {
  local branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  if [[ ! -z "$branch" ]]; then
    if [[ "$branch" == "HEAD" ]]; then
      branch='detached'
    fi
    git_branch="${TXTCOL}${branch}"
  else
    git_branch=""
  fi
  echo $git_branch
}


#############################                
function get_git_commid() {
    ### add current commit hash 
    commitid=`git rev-parse --short HEAD 2> /dev/null`                    
    echo "${commitid}"
}

#############################                
function parse_git() {
    
    ### first check to see if we are in a git branch
    git_str=$(find_git_branch)    
    if [[ ! -z "$git_str" ]]; then        
        ### now check for git dirty state        
        git_str="$(git_com_diff) ${git_str}$(find_git_dirty)"
        
        ### add git stats if applicable
        git_str="${git_str}$(find_git_stats)"  
        
        ### add final closing bracket
        #git_str="(${git_str})"  
        
        ### add short commitid string
        #git_str="${git_str}$(get_git_commid)"
        git_str="${MORANGE}⌥ (${git_str}${MORANGE} )"  
                            
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
          dirty_state='\[\033[01;38;5;221m\]*'
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
          gupdown="${RED}${grelN}↑"
    fi
    
    if [[ $gdown != "" ]]; then              
          gupdown="${RED}${grelN}↓"
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
      echo "${gupdown}${TXTCOL}${gbranchstr}${dirty_state}${joined_gitstats}"                    	     
}
     


# User specific aliases and functions
HISTSIZE=5000
HISTFILESIZE=10000
shopt -s histappend

color_prompt=yes
if [ "$color_prompt" = yes ]; then


function prompt_command() {
        ###################################################
        ### set an error string for the prompt, if applicable
        if [ $? -eq 0 ]; then 
                ERRPROMPT="\[\033[1;5;32m\]$ "
        else
                ERRPROMPT='\[\033[1;5;31m\]X '
        fi  

        local MORANGE="\[\033[38;5;202m\]"
        local DORANGE="\[\033[38;5;221m\]"
        local YELLOW="\[\033[01;38;5;221m\]"        
        local TEAL="\[\033[0;5;36m\]"
        local BCYAN="\[\033[1;5;36m\]"
        local LBLUE="\[\033[0;1;34m\]"
        local VBLUE="\[\033[0;5;34m\]"
        local VLBLUE="\[\033[1;5;34m\]"        
        local GRAY="\[\033[0;37m\]"
        local DKGRAY="\[\033[1;30m\]"
        local WHITE="\[\033[1;37m\]"
        local TERGREEN="\[\033[00m\]"    
        local RED="\[\033[1;5;31m\]"    
        local CHATREU="\[\033[1;5;32m\]"    
        local LGREEN="\[\033[1;2;32m\]"   
        local SLATE="\[\033[1;2;37m\]"            
        local LYELLOW="\[\033[1;33m\]"      
        local LMAGENTA="\[\033[1;35m\]"      
        local MAGENTA="\[\033[1;5;35m\]"          
        ###
        # High Intensty
        local HIBlack="\[\033[0;90m\]" 
        local HIRed="\[\033[0;5;91m\]"  
        local HIGreen="\[\033[0;92m\]"  
        local HIYellow="\[\033[0;5;93m\]"  
        local HIBlue="\[\033[0;94m\]"
        local HIPurple="\[\033[0;95m\]"  
        local HICyan="\[\033[0;96m\]"  
        local HIWhite="\[\033[0;97m\]"                           
        

        local TXTCOL="${HIGreen}"

       if [[ $(id -u) -eq 0 ]]; then  
                ### root color
                local BARCOL="${MORANGE}"
                local TXTCOL="${RED}"           
        fi # root bit         

        
PS1="${debian_chroot:+($debian_chroot)}\n\
${TXTCOL}⌚ ⌚ ⌚ `date +"%H:%M"` ➟ \
${YELLOW}\w \
$(parse_git)
${TXTCOL}☠ ☠ ☠ \
${TXTCOL}\u ➟ " 
}


PROMPT_COMMAND="prompt_command; history -a; history -c; history -r"
#

else
    PS1="\n\[\033[1;30m\][$$:$PPID - \j:\!\[\033[1;30m\]]\[\033[0;36m\] \T \
\[\033[1;30m\][\[\033[1;34m\]\u@\H\[\033[1;30m\]:\[\033[0;37m\]${SSH_TTY:-o} \
\[\033[0;32m\]+${SHLVL}\[\033[1;30m\]] \[\033[1;37m\]\w\[\033[0;37m\] \n\$ "
fi


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

