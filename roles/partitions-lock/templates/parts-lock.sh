#!/bin/sh

if [ "$1" = "lock" ]; then
{% for part in managed_parts %}
    device=$(grep -E '\s+{{ part.mount_point }}\s+' /etc/fstab | cut -f 1 -d ' ')
    mount -o remount,{{ part.lock_opts }} $device {{ part.mount_point }} 2>&1 >/dev/null
{% endfor %}
elif [ "$1" = "unlock" ]; then
{% for part in managed_parts %}
    device=$(grep -E '\s+{{ part.mount_point }}\s+' /etc/fstab | cut -f 1 -d ' ')
    mount -o remount,{{ part.unlock_opts }} $device {{ part.mount_point }}
{% endfor %}
fi
