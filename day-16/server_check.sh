#!/bin/bash

SERVICE="ssh"

read -p "Do you want to check the status? (y/n): " CHOICE

if [ "$CHOICE" = "y" ]; then

    if systemctl is-active --quiet $SERVICE; then
        echo "$SERVICE is active"
    else
        echo "$SERVICE is not active"
    fi

else
    echo "Skipped."
fi