#!/bin/bash
pid_now="$$"
mkdir /tmp/$pid_now
mount -o bind /tmp/$pid_now /proc/$pid_now
rm -rf /tmp/$pid_now

# Command Info
function extract_info(){
uuid_data="$1"
echo -e '
\# command_short_info
\# This short info for Test

\# command_long_info
\# This long info for Test
' | sed 's/^\\//g' > /tmp/${uuid_data}
}
if [[ "$1" == 'extract_info' ]]; then
    extract_info "$2"
    exit 0
fi

# Content
if [[ ! -z "$1" ]]; then
    echo -e "This is Test Command with Params"
else
    echo -e "This is Test Command"
fi
