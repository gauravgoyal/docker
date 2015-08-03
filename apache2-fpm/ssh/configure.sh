#!/bin/bash

if [ "${AUTHORIZED_KEYS}" != "**None**" ]; then
    echo "=> Found authorized keys"
    mkdir -p /root/.ssh
    chmod 700 /root/.ssh
    touch /root/.ssh/authorized_keys
    chmod 600 /root/.ssh/authorized_keys
    IFS=$'\n'
    arr=$(echo ${AUTHORIZED_KEYS} | tr "," "\n")
    for x in $arr
    do
        x=$(echo $x |sed -e 's/^ *//' -e 's/ *$//')
        cat /root/.ssh/authorized_keys | grep "$x" >/dev/null 2>&1
        if [ $? -ne 0 ]; then
            echo "=> Adding public key to /root/.ssh/authorized_keys: $x"
            echo "$x" >> /root/.ssh/authorized_keys
        fi
    done
fi

if [ ! -f /.root_pw_set ]; then
	bin/bash /root_pw_set.sh
fi

main() {
    local owner group owner_id group_id tmp
    read owner group owner_id group_id < <(stat -c '%U %G %u %g' .)
    if [[ $owner = UNKNOWN ]]; then
        owner=$(randname)
        if [[ $group = UNKNOWN ]]; then
            group=$owner
            addgroup --system --gid "$group_id" "$group"
        fi
        adduser --system --uid=$owner_id --gid=$group_id "$owner"
    fi
    tmp=/tmp/$RANDOM
    {
        echo "User $owner"
        echo "Group $group"
        grep -v '^User' /etc/apache2/apache2.conf |
            grep -v '^Group'
    } >> "$tmp" &&
    cat "$tmp" > /etc/apache2/apache2.conf &&
    rm "$tmp"
    # Not volumes, so need to be chowned
    chown -R "$owner:$group" /var/{lock,log,run}/apache*
    service php5-fpm start
    service ssh start
    exec /usr/sbin/apache2ctl "$@"
}

main -D FOREGROUND
