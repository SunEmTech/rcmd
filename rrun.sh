#!/bin/bash
# Pull and run
SRC_DIR=$1
GIT_PATH=http://github.com/SunEmTech/rcmd

if [ -z $SRC_DIR ]; then 
    echo "Usage: bash rrun.sh [source directory/\$PWD]"
    exit 1
fi

pull() {

    if ! [ -f $SRC_DIR/rrun.sh ]; then
        git clone $GIT_PATH $SRC_DIR
        return $?
    else
        RET_STR=`git -C $SRC_DIR pull`
        if [ $? -ne 0 ]; then
            return 1;
        fi
        if [ "$RET_STR" = "Already up-to-date." ]; then
            return 2;
        fi
    fi 
    return 0
}

get_mac() {                                                                     
    set `ifconfig -a | grep HWaddr`                                             
    MAC=`echo "$5" | sed -e 's/\:/\_/g'`                                        
    echo $MAC                                                                   
}                                                                               
                                                                                
pre_doit() {
    echo "pre_doit"
    sleep 20
}

doit() {
    echo "doit"
    MAC=`get_mac`
    for EXE in `ls $SRC_DIR/exe*`; do
        echo "echo of $EXE $SRC_DIR $MAC"
        bash $EXE $SRC_DIR $MAC &
    done
}

post_doit() {
    echo "post doit"
}

start() {
    RETRY=1
    while [ $RETRY -ne 0 ]; do
        pull
        if [ $? -ne 0 ]; then
            echo "Wait for the internet connection: $RETRY"
            RETRY=`expr $RETRY + 1`
            sleep 5
            continue
        fi
        
        doit

        sleep 3
    done
}

pre_doit
doit
start
post_doit


