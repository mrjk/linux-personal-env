### Managed by Puppet ###


shell_serial_login () {
	# Define session timeout depending tty
	local TMOUTTTY="ttyS0"
	local TMOUTTIME=600

	# Detect if user comes from a serial console
	if [ $(ps ax | grep $$ | awk '{ print $2 }' | grep ${TMOUTTTY} | wc -l ) -gt 0 ]; then
		TMOUT=${TMOUTTIME}
		readonly TMOUT
		echo "Info: Auto logout set to ${TMOUTTIME}s ..."
	fi

	# Old version
	#ps ax | grep $$ | awk '{ print $2 }' | grep "${TMOUTTTY}" 2>&1 > /dev/null
	#if [ $? -eq 0 ]; then
	#	TMOUT=${TMOUTTIME}
	#	readonly TMOUT
	#	#export TMOUT
	#	echo "Info: Auto logout set to ${TMOUTTIME}s ..."
	#fi

}
