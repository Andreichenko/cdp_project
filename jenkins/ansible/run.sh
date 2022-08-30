#!/bin/bash
check_vars()
{
  var_names=("$@")
  for var_name in "${var_names[@]}"; do
    [ -z "${!var_name}" ] && echo "$var_name is unset." && var_unset=true
  done
  [ -n "$var_unset" ] && exit 1
  return 0
}

generate_remote_state_file()
{
  echo "bucket=\"$TF_VAR_db_remote_state_bucket\"" > remote.tfbackend
  echo "dynamodb_table=\"$TF_VAR_db_remote_state_key\"" >> remote.tfbackend
  echo "key=\"$CI_PROJECT/$CI_ENVIRONMENT/terraform.tfstate\"" >> remote.tfbackend
  echo "region=\"$AWS_DEFAULT_REGION\"" >> remote.tfbackend
}
