#!/bin/bash

host_name="${bm_remoteHostName:-${1}}"
remote_host="${bm_remoteHost:-${2}}"

if [ -z "$host_name" ] || [ -z "$remote_host" ]; then
    echo "Usage: $0 <host_name> <remote_host> or set bm.remoteHostName and bm.remoteHost in settings.json"
    exit 1
fi

export REMOTE_DEBUG_HOST="$host_name@$remote_host"


echo "Starting remote debug"
echo "Stopping previous JLinkGDBServer processes on remote host (if any)"
if [ -n "$REMOTE_DEBUG_PASS" ]; then
    SSH_CMD="sshpass -p \"$REMOTE_DEBUG_PASS\" ssh -o StrictHostKeyChecking=no"
else
    SSH_CMD="ssh"
fi


eval $SSH_CMD $REMOTE_DEBUG_HOST 'pkill -f JLinkGDBServer || true'
echo "Remote host: $REMOTE_DEBUG_HOST"
echo "Launching JLinkRemoteServer on remote host"
JLINK_SERIAL="${bm_jlinkSerial:-772440171}"
JLINK_DEVICE="${bm_deviceName:-STM32F765ZG}"
eval $SSH_CMD $REMOTE_DEBUG_HOST "nohup ./JLinkRemoteServer -select usb=$JLINK_SERIAL -USB -device $JLINK_DEVICE -endian little -speed 4000 -if swd -vd &> /tmp/remote/JLinkRemoteServer.log &"
echo "Remote JLinkRemoteServer started."
