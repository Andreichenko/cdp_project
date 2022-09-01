#!/bin/bash

while [[ $# -gt 1 ]]
do
  key="$1"
  case $key in
    -p|--profile)
    PROFILE="--profile $2"
    shift
    ;;
    -r|--region)
    REGION="--region $2"
    shift
    ;;
    -g|--group)
    GROUP="$2"
    shift
    ;;
    -k|--key)
    SSHKEY="-i $2"
    shift
    ;;
    --sh)
    CMD=ssh
	shift
    break
    ;;
    --cp)
    CMD=scp
	shift
	break
    ;;
    *)
	echo unknown option: $key
    ;;
  esac
  shift
done

aws $PROFILE $REGION ec2 describe-instances \
	--filter "Name=tag:aws:autoscaling:groupName,Values=$GROUP" \
	| jq -r .Reservations[].Instances[].PublicDnsName \
	| xargs -I % $CMD $SSHKEY ubuntu@% $@