#!/bin/bash

docker=snode043

function usage {
    echo
    echo "Usage:"
    echo "    bash $0 [options]"
    echo "Description:"
    echo "    the script is used to switch node."
    echo "        -w/--wsl -- switch to windows subsystem for linux."
    echo "        -s/--snode -- switch to snode011."
    echo "        -d/--docker node -- switch to node of docker queue, [default: '$docker']."
    echo "        -h/--help -- show help message."
    echo
    exit 0
}

if [ $# -ne 1 ];then
   usage
fi

ARG=$(getopt -q -o hwsd: --long help,wsl,snode,docker: -n $0 -- $@)

eval set -- $ARG
while [ -n "$1" ];do
case "$1" in
   -d|--docker)
      docker=$2;shift 2;;
   -w|--wsl)
      wsl=true;shift 1;;
   -s|--snode)
      snode=true;shift 1;;
   -h|--help)
      help=true;shift 1;;
   *)
      break;;
esac
done

if [[ $wsl == 'true' ]];then
   /usr/bin/ssh chenyl@10.10.155.108
elif [[ $snode == 'true' ]];then
   /usr/bin/ssh chenyulong@10.42.1.64
else
   ssh $docker -q docker.q
fi
