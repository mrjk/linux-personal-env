### Managed by Puppet ###

##########################
# Func: Login user info
##########################

shell_user_info () {
	# Session information
	if [ "$0" == "-su" ] 
	then # you were root, and you come via 'su -'

		# Get general infos
		if [ $(grep "^$(whoami):" /etc/passwd | grep -E ':/bin/(ba|z|da|t)?sh$') ]; then
			local INFO_SHELL="Shell:\t\tinteractive shell enabled ($(grep "^$(whoami):" /etc/passwd | cut -d ':' -f 7))"
		else
			local INFO_SHELL="Shell:\t\tinteractive shell disabled ($(grep "^$(whoami):" /etc/passwd | cut -d ':' -f 7))"
		fi

		# Get account information
		if [ $(passwd -S $(whoami) | cut -d ' ' -f 2) == "L" ]; then
			local INFO_ACCOUNT="Account:\tlocked"
		else
			local INFO_ACCOUNT="Account:\tenabled"
		fi 

		# Get SSH Keys in $HOME
		INFO_SSH_KEYS=$(grep '^ssh-' ~/.ssh/authorized_keys 2> /dev/null | wc -l )
		if [ ${INFO_SSH_KEYS} -eq 0 ] ; then
			local INFO_SSH_KEYS="SSH Keys:\tno keys found"
		else
			local INFO_SSH_KEYS="SSH Keys:\t${INFO_SSH_KEYS} found"
		fi

		# Get extra info about home
		local INFO_HOME_XTRA=""
		local INFO_HOME_PASSWD="$(grep "^$(whoami):" /etc/passwd | cut -d ':' -f 6 )"
		if [ ! -d "${INFO_HOME_PASSWD}" ]; then
			local INFO_HOME_XTRA="Home info:\thome directory doesn't exist (${INFO_HOME_PASSWD})"
		elif [ ! -w ${INFO_HOME_PASSWD} ]; then
			local INFO_HOME_XTRA="Home info:\tuser can't write into its home"
		fi

		# Get Shell level (might be irrelevant)
		if [ "$SHLVL" -gt 0 ]; then
			local INFO_SHELL_LVL="nested $SHLVL time(s), "
		else
			local INFO_SHELL_LVL=""
		fi

		# Try to detect if bash history is enabled
		touch ~/.bash_history 2> /dev/null
		if [ $? -eq 1 ]; then
			local INFO_SHELL_HIST="'~/.bash_history' disabled, "
		else
			local INFO_SHELL_HIST=""
		fi
		local INFO_SHELL_XTRA=$(echo "$INFO_SHELL_LVL$INFO_SHELL_HIST" | sed 's/, *$//')

		# Easy peasy
		local INFO_USER="User:\t\t$(whoami) ($(id -u):$(id -g))"
		local INFO_GROUPS="Groups:\t\t$(groups) ($(id -G))"
		local INFO_HOME="Home:\t\t${HOME} ($(df -h $HOME | sed '1 d' | awk '{print $5 " used, " $4 " free"}'))"

		# Display result
		echo "=== User infos ==="
		echo -e "$INFO_USER\r"
		echo -e "$INFO_GROUPS\r"
		echo -e "$INFO_HOME\r"
		if [ -n "$INFO_HOME_XTRA" ]; then echo -e "$INFO_HOME_XTRA\r"; fi
		echo -e "$INFO_SHELL\r"
		if [ -n "$INFO_SHELL_XTRA"  ]; then echo -e "Shell info:\t$INFO_SHELL_XTRA\r"; fi
		echo -e "$INFO_ACCOUNT\r"
		echo -e "$INFO_SSH_KEYS\r"
		echo "=================="
	fi
}


##########################
# Call function if Bash
##########################
if [ "$(readlink -f $SHELL)" = */bash ]; then
	user_info
fi
