#!/bin/bash                                                                     
# Pull and run

SRC_DIR=$PWD                                                             
GIT_PATH=http://github.com/SunEmTech/rcmd      
CRON_CMD="@reboot bash $SRC_DIR/rrun.sh $SRC_DIR > $SRC_DIR/rrun.log"                               
USR=$2

if ! [ -z "$USR" ]; then 
    OPTIONS="-u $USR"
fi                              
                                          
case "$1" in
    install)
        echo "$CRON_CMD" | crontab $OPTIONS
        ;;
    remove)
        crontab $OPTIONS -l
        crontab $OPTIONS -r
        echo "Removed" 
        ;;
    *)
        echo "Usage: install.sh [install/remove] user_name"
            
esac

exit 0 
