#!/bin/bash
# Pull and run
PULL_DIR=$HOME/rpull
RUN_DIR=$HOME/rrun
GIT_PATH=http://github.com/SunEmTech/rcmd

pull() {

    if ! [ -f $PULL_DIR/rrun.sh ]; then
        echo "comig here"
        git clone $GIT_PATH $PULL_DIR
        return $?
    else
        RET_STR=`git -C $PULL_DIR pull`
        if [ $? -ne 0 ]; then
            return 1;
        fi
        echo "$RET_STR"
        if [ "$RET_STR" = "Already up-to-date." ]; then
            return 2;
        fi
    fi 
    return 0
}

pre_doit() {
    mkdir -p $RUN_DIR
    cp -r $PULL_DIR/*.sh $RUN_DIR
}

doit() {
    xterm -e bash $RUN_DIR/main.sh &
}

post_doit() {
    echo "post doit"
}

start() {
    RETRY=100
    while [ $RETRY -ne 0 ]; do
        pull
        if [ $? -ne 0 ]; then
            echo "Wait for the internet connection: $RETRY"
            #RETRY=`expr $RETRY - 1`
            sleep 2
            continue
        fi
        
        pre_doit
        doit
        post_doit
        sleep 3
    done
}

start


