#!/bin/bash
if ! command -v sshpass &> /dev/null; then
  sudo apt update && sudo apt install -y sshpass
  if ! command -v sshpass &> /dev/null; then
    exit 1
  fi
fi
KEY="$HOME/.ssh/id_ed25519"
if [ ! -f "$KEY" ]; then
  ssh-keygen -t ed25519 -C "raspberrypi" -f "$KEY" -N ""
fi
read -p "Enter the remote username: " REMOTE_USER
read -p "Enter the remote IP or hostname: " REMOTE_HOST
read -p "Enter the destination path (e.g., /home/$REMOTE_USER/key.pub): " REMOTE_PATH
read -s -p "Enter the remote password: " REMOTE_PASS
echo
sshpass -p "$REMOTE_PASS" scp "$HOME/.ssh/id_ed25519.pub" "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_PATH}"
