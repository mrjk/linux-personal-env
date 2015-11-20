##########################
# Initialisation
##########################

# To live try:
# source <( curl https://raw.githubusercontent.com/mrjk/linux-personal-env/master/bash/bash.bashrc)
# To install locally
# curl https://raw.githubusercontent.com/mrjk/linux-personal-env/master/bash/bash.bashrc > ~/.bashrc && source .bashrc

# If not running interactively, don't do anything
case $- in
	*i*)
	;;
	*) 
		return
	;;
esac


##########################
# Func: Global variables
##########################

shell_global_variable () {
	HOSTNAME=$(head -n 1 /etc/hostname)

	# Custom variables
	##########################

	# Regex to match IP
	export RGX_IP='(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)'
	export RGX_IP='([0-2][0-9]{2}\.){3}'

	# Regex to match emplty lines and comments ... use with grep -E -v
	export RGX_EL='^[[:blank:]]*#|^$'

	# Match a username
	export RGX_USER='[a-z0-9-]'

	# Match a domain ANSI
	export RGX_DOM='([a-z][a-z0-9\-]+(\.|\-*\.))+[a-z]{2,6}'
	export RGX_DOM='[a-z0-9-]+(\.[a-z0-9-]+)?\.[a-z0-9-]{2,6}'

	# Match Hexadecimal, 
	export RGX_HEX='#?([a-f0-9]{6}|[a-f0-9]{3})'

	# Match email
	export RGX_EMAIL='([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})'

	# Match URL
	export RGX_URL='(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?'
}


##########################
# Func: Global color
##########################

shell_global_color () {
	# Easy
	export RED='\033[31m'
	export GREEN='\033[32m'
	export YELLOW='\033[33m'
	export BLUE='\033[34m'
	export PURPLE='\033[35m'
	export CYAN='\033[36m'
	export WHITE='\033[37m'
	export NIL='\033[00m'

	# Reset
	export Color_Off='\e[0m'       # Text Reset

	# Regular Colors
	export Black='\e[0;30m'        # Black
	export Red='\e[0;31m'          # Red
	export Green='\e[0;32m'        # Green
	export Yellow='\e[0;33m'       # Yellow
	export Blue='\e[0;34m'         # Blue
	export Purple='\e[0;35m'       # Purple
	export Cyan='\e[0;36m'         # Cyan
	export White='\e[0;37m'        # White

	# Bold
	export BBlack='\e[1;30m'       # Black
	export BRed='\e[1;31m'         # Red
	export BGreen='\e[1;32m'       # Green
	export BYellow='\e[1;33m'      # Yellow
	export BBlue='\e[1;34m'        # Blue
	export BPurple='\e[1;35m'      # Purple
	export BCyan='\e[1;36m'        # Cyan
	export BWhite='\e[1;37m'       # White

	# Underline
	export UBlack='\e[4;30m'       # Black
	export URed='\e[4;31m'         # Red
	export UGreen='\e[4;32m'       # Green
	export UYellow='\e[4;33m'      # Yellow
	export UBlue='\e[4;34m'        # Blue
	export UPurple='\e[4;35m'      # Purple
	export UCyan='\e[4;36m'        # Cyan
	export UWhite='\e[4;37m'       # White

	# Background
	export On_Black='\e[40m'       # Black
	export On_Red='\e[41m'         # Red
	export On_Green='\e[42m'       # Green
	export On_Yellow='\e[43m'      # Yellow
	export On_Blue='\e[44m'        # Blue
	export On_Purple='\e[45m'      # Purple
	export On_Cyan='\e[46m'        # Cyan
	export On_White='\e[47m'       # White

	# High Intensity
	export IBlack='\e[0;90m'       # Black
	export IRed='\e[0;91m'         # Red
	export IGreen='\e[0;92m'       # Green
	export IYellow='\e[0;93m'      # Yellow
	export IBlue='\e[0;94m'        # Blue
	export IPurple='\e[0;95m'      # Purple
	export ICyan='\e[0;96m'        # Cyan
	export IWhite='\e[0;97m'       # White

	# Bold High Intensity
	export BIBlack='\e[1;90m'      # Black
	export BIRed='\e[1;91m'        # Red
	export BIGreen='\e[1;92m'      # Green
	export BIYellow='\e[1;93m'     # Yellow
	export BIBlue='\e[1;94m'       # Blue
	export BIPurple='\e[1;95m'     # Purple
	export BICyan='\e[1;96m'       # Cyan
	export BIWhite='\e[1;97m'      # White

	# High Intensity backgrounds
	export On_IBlack='\e[0;100m'   # Black
	export On_IRed='\e[0;101m'     # Red
	export On_IGreen='\e[0;102m'   # Green
	export On_IYellow='\e[0;103m'  # Yellow
	export On_IBlue='\e[0;104m'    # Blue
	export On_IPurple='\e[0;105m'  # Purple
	export On_ICyan='\e[0;106m'    # Cyan
	export On_IWhite='\e[0;107m'   # White
}


##########################
# Func: shell PS1
##########################

# Full function wrapper
shell_ps1 () {
	shell_ps1_advanced
	#shell_ps1_simple
}

# PS1 shell reset (in case of emergency)
shell_ps1_simple () {
	PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
	#PS1='$USER@$(hostname):$PWD\$ '
}

# Full function
shell_ps1_advanced () {

	# Define dynamic prompt variables (Fucking bashisms :-()
	local PS1_RETURN="\$(
		PS1_EXIT=\$?; 
		[[ \$PS1_EXIT == 0 ]] ||  echo -n \"\[$Red\]\${PS1_EXIT}\[${Color_Off}\] \"
	)"
	
	local PS1_PATH="\$(
		if [ -s \"\${PWD}\" ] ; then
		#	PS1_DF=\$(command df -P \"\${PWD}\" | grep -E -o '[0-9]{1,3}%' | grep -E -o '[0-9]{1,3}');
			PS1_DF=\$(command timeout 1s df -P \"\${PWD}\" | awk 'END {print \$5} {sub(/%/,\"\")}');

			if [ \"\${PS1_DF:-0}\" -gt 95 ]; then
				PS1_PATH=\"\[$Red\]:\"
			elif [ \"\${PS1_DF:-0}\" -gt 90 ]; then
				PS1_PATH=\"\[$Yellow\]:\"
			else
				PS1_PATH=\"\[$White\]:\"
			fi
		else
			# Current directory is size '0' (like /proc, /sys etc).
			PS1_PATH=\"\[$Yellow\]:\";
		fi
		if [ -w \"\${PWD}\" ] ; then
			PS1_PATH=\"\${PS1_PATH}\[$Blue\]\w\"
		else
			# No 'write' privilege in the current directory.
			PS1_PATH=\"\${PS1_PATH}\[$Yellow\]\w\"
		fi

		echo -e \"\${PS1_PATH}\"
	)"

	# Get jobs
	local PS1_JOBS="\$(
		PS1_JOBS='';
		PS1_JOBS_RUNNING=\$(jobs -r | wc -l);
		PS1_JOBS_STOPPED=\$(jobs -s | wc -l);
		if [ \${PS1_JOBS_RUNNING} -gt 0 ] || [ \${PS1_JOBS_STOPPED} -gt 0 ]
		then
			if [ \${PS1_JOBS_RUNNING:-0} -gt 0 ]; then
				PS1_JOBS_RUNNING=\"\[$Green\]\${PS1_JOBS_RUNNING}\[$Color_Off\]\"
			else
				PS1_JOBS_RUNNING=''
			fi

			if [ \${PS1_JOBS_STOPPED:-0} -gt 0 ]; then
				PS1_JOBS_STOPPED=\"\[$Yellow\]\${PS1_JOBS_STOPPED}\[$Color_Off\]\"
			else
				PS1_JOBS_STOPPED=''
			fi
			PS1_JOBS=\"\${PS1_JOBS_RUNNING}:\${PS1_JOBS_STOPPED} \";
		else
			PS1_JOBS=''
		fi
		echo -e \"\${PS1_JOBS}\";
	)"

	# Time execution checker

	# Maximal time to consider prompt as slow in ms
	local PS1_MAX_EXEC_TIME=500
	# Number of time needed before swithing to basic prompt
	local PS1_MAX_TIME=3
	# Time windows to check
	local PS1_MAX_EXEC_DELAY=60
	# Time before reloading full PS1 after showing simple prompt
	local PS1_DELAY_RELOAD=300

	# Debug
#	local PS1_MAX_EXEC_TIME=5
#	local PS1_MAX_TIME=3
#	local PS1_MAX_EXEC_DELAY=60
#	local PS1_DELAY_RELOAD=30
	
	local PS1_TMP_FILE=/tmp/.load-$(whoami)
	chown $(whoami):$(whoami) ${PS1_TMP_FILE} 2>/dev/null
	local PS1_START="\$(
		if [ -f ${PS1_TMP_FILE} ] && [ \"\$(cat ${PS1_TMP_FILE} | grep -E -o '^reset')\" = \"reset\" ]
		then
			echo '\u@\h:\[\033[01;34m\]\w\[\033[00m\]\\$ '
			if [ \$((\$(date +%s) - \$(stat -c %Y ${PS1_TMP_FILE}) )) -gt ${PS1_DELAY_RELOAD} ]
			then
				echo -n \"Shell: full prompt reactivated.\n\"
				> ${PS1_TMP_FILE};
			fi
		else
			ts=\$(date +%s%N); 
			echo -e \""
	local PS1_STOP="\"; 
			tt=\$(((\$(date +%s%N) - \${ts})/1000000));
			if [ \${tt} -gt ${PS1_MAX_EXEC_TIME} ]
			then
				echo 1 >> ${PS1_TMP_FILE};
					if [ \$((\$(date +%s) - \$(stat -c %Y ${PS1_TMP_FILE}) )) -gt ${PS1_MAX_EXEC_DELAY} ] || [ \$(wc -l ${PS1_TMP_FILE} | grep -E -o '^[0-9]{1,3}') -gt ${PS1_MAX_TIME} ]
					then
						echo "reset" > ${PS1_TMP_FILE};
						echo -n \"Shell: prompt is taking more than ${PS1_MAX_EXEC_TIME}ms to anwser. Normal prompt will be reactivated in ${PS1_DELAY_RELOAD}s. Execute 'rm ${PS1_TMP_FILE}' to force.\n\" ;
					fi
			fi 
		fi
	)"

	# Define static prompt variables
	local PS1_ACOUNT="\[$White\]\\$ "
	local PS1_CHROOT_DEB="${debian_chroot:+($debian_chroot)}"

	# Set variable identifying the chroot you work in (used in the prompt below)
	if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	    local debian_chroot=$(cat /etc/debian_chroot)
	fi

	# Define prompt depending user
	if [ $(id -u) -eq 0 ];
	then # you are root, make the prompt red
		# Are you root ?
		local PS1_USER="\[$Green\]\u"
		# In green
	elif [ -n "$(cat /etc/passwd  | grep $(whoami)  | grep -E -v ':/bin/(ba|z|t)?sh')" ]; then
		# The you are a no login user ...
		local PS1_USER="\[$Red\]\u"
		# In red
	elif [ $(id -u) -lt 1000 ]; then
		# Are you a system user ?
		local PS1_USER="\[$Yellow\]\u"
		# In orange
	elif [ $(id -u) -ge 1000 ]; then
		# Are you a regular user ?
		local PS1_USER="\[$White\]\u"
		# In white
	fi

	# Detect serial connection (virtualisation, ttySx)
	if [ $(ps ax | grep $$ | awk '{ print $2 }' | grep 'ttyS.' | wc -l ) -gt 0 ]; then
		local PS1_HOST="@\[$Red\]\h"
	else
		local PS1_HOST="\[$Green\]@\h"
	fi

	# Set the prompt depending the shell
	if [ "${CURRENT_SHELL}" = "bash" ]; then
		PS1="\[$Color_Off\]${PS1_RETURN}${PS1_START}${PS1_JOBS}${PS1_USER}${PS1_HOST}${PS1_PATH}${PS1_ACOUNT}\[$Color_Off\]${PS1_STOP}"
	elif [ "${CURRENT_SHELL}" = "dash" ] ; then
		PS1='$USER@$HOSTNAME:$PWD\$ '
	else
		PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
	fi
}


##########################
# Func: Bash alias
##########################

bash_alias () {
	alias ll='ls -lh'
	alias la='ls -lAh'
	alias l='ls -ClFh'
	alias ltr='ls -ahltr'
	alias lsd="ls -l | grep ^d"

	alias mkdir='mkdir -p'

	alias ..='cd ..'
	alias ...='cd ../..'
	alias ....='cd ../..'

	alias h='history'
	alias j='jobs -l'

	alias vih='vim /etc/hosts '
	alias vit='vim /etc/fstab '
	alias vif='vim /etc/network/interfaces '
	alias diff='colordiff '
	alias tmount='mount |column -t '

	alias wgets='wget --no-check-certificate '
	alias wgeth='wget --no-check-certificate -S -O /dev/null '
	alias uncmt="grep '^[^#|^$|^ *$]' "
	alias monip='wget -q -O - "$@" monip.org | grep -o "[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}"'
	alias monhost='echo "My host is ..."; host $(wget -q -O - "$@" monip.org | grep -o "[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}")'
	alias text2ascii='tail --bytes=+4'

	alias iptlist='sudo /sbin/iptables -L -n -v --line-numbers'
	alias iptlistin='sudo /sbin/iptables -L INPUT -n -v --line-numbers'
	alias iptlistout='sudo /sbin/iptables -L OUTPUT -n -v --line-numbers'
	alias iptlistfw='sudo /sbin/iptables -L FORWARD -n -v --line-numbers'

	# Typo correction
	alias cd..='cd ..'

	# List directory when moving
	#cd() { builtin cd "$@"; ll; }

	# Chroot helper
	chroot_mount_system () {
		if [ -d $1 ]; then
			mount -t proc none $1/proc
			mount -obind /dev $1/dev
			mount -obind /sys $1/sys
			echo "Then: chroot $1 /bin/bash "
		else
			echo "Usage: chroot_mount_system <dir>"
		fi
	}

	# SSH Helper
	alias ssh_unsecure='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no CheckHostIP=no'
	alias ssh_local='ssh -o CheckHostIP=no '
}


##########################
# Func: Completion on SSH Hosts
##########################

bash_completion () {

	# SSH Host completion	
	if [ -e ~/.ssh/known_hosts ] ; then
		complete -W "$(echo `cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq | grep -v "\["`;)" ssh
		# Note: HashKnownHosts need to be set 'no' in /etc/ssh/ssh_config
	fi

}

##########################
# Func: Define environment vars 
##########################

bash_env () {

	# SSH Host completion
	export EDITOR="vim"
	export SVN_EDITOR=vim

}

##########################
# Func: Command not found
##########################

shell_command_not_found () {
	# if the command-not-found package is installed, use it
	if [ -x /usr/lib/command-not-found -o -x /usr/share/command-not-found/command-not-found ]; then
		command_not_found_handle () {
			# check because c-n-f could've been removed in the meantime
			if [ -x /usr/lib/command-not-found ]; then
				/usr/bin/python /usr/lib/command-not-found -- "$1"
				return $?
			elif [ -x /usr/share/command-not-found/command-not-found ]; then
				/usr/bin/python /usr/share/command-not-found/command-not-found -- "$1"
				return $?
			else
				printf "%s: command not found\n" "$1" >&2
				return 127
			fi
		}
	fi
}

##########################
# Func: Bash command color
##########################

bash_command_color () {

	if [ -x /usr/bin/dircolors ]; then
		test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
		alias ls='ls --color=auto'
		alias dir='dir --color=auto'
		alias vdir='vdir --color=auto'
		
		alias grep='grep --color=auto'
		alias fgrep='fgrep --color=auto'
		alias egrep='egrep --color=auto'
	fi


	if [ -x /usr/bin/colordiff ]; then
		alias diff='colordiff' 
	fi


	# Pager config and colors
	#export MANPAGER='/usr/bin/most -S'
	export MANPAGER='/usr/bin/less'

	export LESS_TERMCAP_mb=$'\E[01;31m'
	export LESS_TERMCAP_us=$'\E[01;32m'
	export LESS_TERMCAP_md=$'\E[01;31m'
	export LESS_TERMCAP_se=$'\E[0m'
	export LESS_TERMCAP_so=$'\E[01;44;33m'
	export LESS_TERMCAP_ue=$'\E[0m'
	export LESS_TERMCAP_me=$'\E[0m'


	# Ajout log en couleurs
	ctail() { tail -f $1 | ccze -A; }
	cless() { ccze -A < "$1" | less -R; }
}



##########################
# Func: Bash config
##########################


bash_config () {
	##########################
	# History management
	##########################

	# Force timestamp in history
	export HISTTIMEFORMAT='%F %T '

	# Ignore duplicates and lines starting by a space
	export HISTCONTROL=""

	# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
	export HISTSIZE=10000
	export HISTFILESIZE=2000

	if [ -w ~/.bash_history ]; then
#		echo "Bash: enabling history file"
		export HISTFILE=~/.bash_history
	else
#		echo "Bash: disabling history file"
		unset HISTFILE
	fi


	##########################
	# Misc
	##########################

	# Disable mail check
	unset MAILCHECK

	# Update shell output according to the terminal size
	shopt -s checkwinsize

	# Load other aliases
	if [ -f ~/.bash_aliases ]; then
	    . ~/.bash_aliases
	fi

	# Synchronise history
	shopt -s histappend
	export PROMPT_COMMAND="history -a"

	# Enable completion
	if ! shopt -oq posix; then
	  if [ -f /usr/share/bash-completion/bash_completion ]; then
	    . /usr/share/bash-completion/bash_completion
	  elif [ -f /etc/bash_completion ]; then
	    . /etc/bash_completion
	  fi
	fi

	# Bash correction
	shopt -s autocd
	shopt -s cdspell
	shopt -s checkjobs
	shopt -s hostcomplete
	shopt -s nocaseglob
}



##########################
# Function calls
##########################

# Checking the shell
case $(readlink -f $SHELL) in
	*/zsh) 
		CURRENT_SHELL="zsh"
		;;
	*/bash)
		CURRENT_SHELL="bash";
		;;
	*/dash)
		CURRENT_SHELL="dash";
		;;
	*)
		# assume something else
		CURRENT_SHELL="none"
esac

# Preset
shell_global_variable
shell_global_color
shell_ps1
shell_command_not_found
bash_env

bash_alias
bash_command_color

if [ ${CURRENT_SHELL} = "bash" ]; then
	bash_config
	bash_completion
fi
