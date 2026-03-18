#!/bin/bash

# Check if "company" connection is active
if nmcli connection show --active | grep -q "company"; then
    echo '{"text": " 󰖂  ", "class": "vpn-connected"}'
else
    echo '{"text": " 󰖂  ", "class": "vpn-disconnected"}'
fi

