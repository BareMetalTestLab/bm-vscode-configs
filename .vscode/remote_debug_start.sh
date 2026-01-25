#!/bin/bash

host_name="${remote_debug_host_name:-${1}}"
ip_host="${remote_debug_host:-${2}}"
password="${remote_debug_password:-}"

if [ -z "$host_name" ] || [ -z "$ip_host" ]; then
    echo "Usage: $0 <host_name> <remote_host> or set bm.remoteHostName and bm.remoteHost in settings.json"
    exit 1
fi

export REMOTE_DEBUG_HOST="$host_name@$ip_host"


echo "Starting remote debug"
echo "Stopping previous JLinkRemoteServer processes on remote host (if any)"
if [ -n "$password" ]; then
    SSH_CMD="sshpass -p \"$password\" ssh -o StrictHostKeyChecking=no"
else
    SSH_CMD="ssh"
fi


KILL_RESULT=$(eval $SSH_CMD $REMOTE_DEBUG_HOST 'pkill -f JLinkRemoteServer'; echo $?)
if [ "$KILL_RESULT" -eq 0 ]; then
    echo "JLinkRemoteServer process was killed on remote host."
else
    echo "No JLinkRemoteServer process was running on remote host."
fi
echo "Remote host: $REMOTE_DEBUG_HOST"
echo "Launching JLinkRemoteServer on remote host"
JLINK_SERIAL="${bm_jlinkSerial:-772440171}"
JLINK_DEVICE="${bm_deviceName:-STM32F765ZG}"
eval $SSH_CMD $REMOTE_DEBUG_HOST "JLinkRemoteServer -select usb=$JLINK_SERIAL -device $JLINK_DEVICE -endian little -speed 4000 -if swd -vd"
eval $SSH_CMD $REMOTE_DEBUG_HOST "pgrep -af JLinkRemoteServer"
echo "Remote JLinkRemoteServer started."
