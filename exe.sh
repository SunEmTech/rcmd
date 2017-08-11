#!/bin/bash
# from here actual execution should start
SRC_DIR=$1
MAC=$2
MY_MAC="b8_ae_ed_38_89_5d"

init() {
    echo "Init $PWD $USER" >> $SRC_DIR/rrun.log
    echo "Init 2 $PWD $USER"
    shutdown -h 10 now
    kill -2 1
}

main() {
    echo "In main $PWD $USER"
    shutdown -h 10 now
    while [ 1 -ne 0 ]; do
        echo "runnig $USER"
        sleep 2 
    done
}

init
main
