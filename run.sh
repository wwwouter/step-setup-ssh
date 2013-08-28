#save public key
export WERCKER_SETUP_SSH_ID_FILE=$WERCKER_STEP_TEMP/id.key
echo -e "$WERCKER_SETUP_SSH_PRIVATE_KEY" > "$WERCKER_SETUP_SSH_ID_FILE"

#set permission
chmod 0700 "$WERCKER_SETUP_SSH_ID_FILE"

export WERCKER_SSH="ssh $WERCKER_SETUP_SSH_HOST -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -l $WERCKER_SETUP_SSH_USERNAME -i $WERCKER_SETUP_SSH_ID_FILE"

result="$($WERCKER_SSH echo 1)"
exitCode=$?

if [ $exitCode != "0" ] ; then
  error "Could not connect"
  $WERCKER_SSH -v echo 1
  exit 1
else
  info "check is ok $exitCode"
  echo "$result"
fi
  

success "Created WERCKER_SHH $WERCKER_SSH"
