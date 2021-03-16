#!/bin/bash

ACTION=usage
MYSCENARIO=scenariotest

function usage () {

	echo "Usage information goes here"
}


### Parse options
OPTS=$(getopt -o h? --long action:,user:,verbose,help,timeout:,other:,dryrun -n 'parse-options' -- "$@")
if [ $? != 0 ] ; then echo "Failed parsing options." >&2 ; exit 1 ; fi

writeout "$OPTS" debug
eval set -- "$OPTS"
while true; do
        case "$1" in
        -v | --verbose )
                LOGGING=verbose
                ;;
        --timeout )
                TIMEOUT=$2
                shift
                ;;
        --user )
                USERNAME=$2
                shift
                ;;
        --action )
                ACTION=$2
		shift
                ;;
        -o | --other )
                OTHER="$2"
                shift
                ;;
        --dryrun )
                DRYRUN=true
                ;;
        --) shift; break ;;
        *) break ;;
        esac
        shift
done

if [ "$ACTION" == "usage" ]; then
        writeout "No action selected - defaulting to usage" debug
        usage
        exit 1
else
	if [ -z $USERNAME ]; then
		echo "ERROR: --username must be used to set the username to perform the action for"
		echo "Exiting."
		exit 1
	fi
	### MAybe add a check here to make sure that $USERNAME is even running the module before going any further?
fi


if [ "$ACTION" == "launch" ]; then
	echo "Executing action $ACTION for user $USERNAME with options $OPTIONS"

	#add $OPTIONS parsing here if required
	if [ "$DRYRUN" == "true" ]; then
		echo "DRYRUN only - we would run something like 'terraform apply -target=. -var "username=$USERNAME"' "
		RC=$?
	else
		echo "MOCKING - we would run something like 'terraform apply -target=. -var "username=$USERNAME"' "
		RC=$?
	fi
fi

if [ "$ACTION" == "terminate" ]; then
	echo "Executing action $ACTION for user $USERNAME with options $OPTIONS"

	#add $OPTIONS parsing here if required
	if [ "$DRYRUN" == "true" ]; then
		echo "DRYRUN only - we would run something like 'terraform apply -target=. -var "username=$USERNAME"' "
		RC=$?
	else
		echo "MOCKING - we would run something like 'terraform apply -target=. -var "username=$USERNAME"' "
		RC=$?
	fi
fi

if [ "$ACTION" == "start" ]; then
	echo "Executing action $ACTION for user $USERNAME with options $OPTIONS"

	#add $OPTIONS parsing here if required
	if [ "$DRYRUN" == "true" ]; then
		echo "DRYRUN only - we would run something like 'aws ec2 start-instances --instance-ids i-1234567890abcdef0' where we'd grab the instance ID from the state file?"
		RC=$?
	else
		echo "MOCKING - we would run something like 'aws ec2 start-instances --instance-ids i-1234567890abcdef0' where we'd grab the instance ID from the state file?"
		RC=$?
	fi
fi

if [ "$ACTION" == "stop" ]; then
	echo "Executing action $ACTION for user $USERNAME with options $OPTIONS"

	#add $OPTIONS parsing here if required
	if [ "$DRYRUN" == "true" ]; then
		echo "DRYRUN only - we would run something like 'aws ec2 stop-instances --instance-ids i-1234567890abcdef0' where we'd grab the instance ID from the state file?"
		RC=$?
	else
		echo "MOCKING - we would run something like 'aws ec2 stop-instances --instance-ids i-1234567890abcdef0' where we'd grab the instance ID from the state file?"
		RC=$?
	fi
fi

exit $RC
