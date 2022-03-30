#!/bin/bash

stfdir=/sibcb2/bioinformatics2/chenyulong/software/pierced/linux
ip=10.42.1.64
port=8080

function usage {
    echo
    echo "Usage:"
    echo "    bash $0 [options]"
    echo "Description:"
    echo "    the script is used to Mapping a local area network to a public network by pierced."
    echo "        -i/--ip ip -- ip address, [default: $ip]."
    echo "        -p/--port port -- port number, [default: $port]."
    echo "        -h/--help -- show help message."
    echo
    exit 0
}

ARG=$(getopt -q -o hi:p: --long help,ip:port: -n $0 -- $@)

eval set -- $ARG
while [ -n "$1" ];do
case "$1" in
   -i|--ip)
      ip=$2;shift 2;;
   -p|--port)
      port=$2;shift 2;;
   -h|--help)
      help=true;shift 1;;
   *)
      break;;
esac
done

if [[ $help == 'true' ]];then
   usage
else
   $stfdir/ding -config=$stfdir/ding.cfg -subdomain=chenyulong $ip:$port
fi
