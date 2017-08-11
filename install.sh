#!/bin/bash                                                                     
# Pull and run

PULL_DIR=$HOME/rpull                                                            
RUN_DIR=$HOME/rrun                                                              
GIT_PATH=http://github.com/SunEmTech/rcmd                                       
                                                                                
pull() {                                                                        
                                                                                
    if ! [ -f $PULL_DIR/rrun.sh ]; then                                         
        git clone $GIT_PATH $PULL_DIR                                           
        return $?                                                               
    else                                                                        
        RET_STR=`git -C $PULL_DIR pull`                                         
        if [ $? -ne 0 ]; then                                                   
            return 1;                                                           
        fi                                                                      
        if [ "$RET_STR" = "Already up-to-date." ]; then                         
            return 2;                                                           
        fi                                                                      
    fi                                                                          
    return 0                                                                    
}

case "$1" in
    install)
        echo "Pulling from net..."
        pull
        if [ $? -ne 0 ]; then 
            echo "Already Installed or No Internet"
            exit 1
        fi
        
        echo "@reboot bash $PULL_DIR/rrun.sh >> $PULL_DIR/rrun.log" >> /etc/crontab
        ;;
    remove)
        echo "No cmd to remove."
        sudo rm -rf $PULL_DIR
        ;;
    *)
        echo "Usage: install.sh [install/remove]"
            
esac

exit 0 
