#!/usr/bin/env bash

# https://github.com/lpasselin/tailscale-docker

trap 'kill -TERM $PID' TERM INT
echo "Starting Tailscale daemon"
tailscaled --tun=userspace-networking --state=${TAILSCALE_STATE_ARG} ${TAILSCALE_OPT} &
PID=$!
until tailscale up --authkey="${TAILSCALE_AUTH+KEY}" --hostname="${TAILSCALE_HOSTNAME}"; do
    sleep 0.1
done
tailscale status
wait ${PID}
wait ${PID}
