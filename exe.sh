#!/bin/bash
# from here actual execution should start
SRC_DIR=$1
MAC=$2
MY_MAC="b8_ae_ed_38_89_5d"

init() {
    echo "Init $PWD $USER" >> $SRC_DIR/rrun.log
    echo "Init 2 $PWD $USER"
    shutdown -h 10 now
}

main() {
    while [ 1 -ne 0 ]; do
        echo "runnig"
        sleep 1
    done
}

init
main
