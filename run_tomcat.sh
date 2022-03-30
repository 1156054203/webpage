#!/bin/bash

tomcatdir=/sibcb2/bioinformatics2/chenyulong/software/tomcat-10.0.0
idxdir=last_directory

function usage {
    echo
    echo "Usage:"
    echo "    bash $0 [options]"
    echo "Description:"
    echo "    the script is used to start tomcat for a web site."
    echo "        -i/--idxdir path -- the absolute path of directory for index.html, [default: $idxdir]."
    echo "        -r/--run -- start tomcat."
    echo "        -s/--stop -- stop the running tomcat."
    echo "        -h/--help -- show help message."
    echo
    exit 0
}

ARG=$(getopt -q -o hrsi: --long help,run,stop,idxdir: -n $0 -- $@)

eval set -- $ARG
while [ -n "$1" ];do
case "$1" in
   -i|--ip)
      idxdir=$2;shift 2;;
   -r|--run)
      run=true;shift 1;;
   -s|--stop)
      stop=true;shift 1;;
   -h|--help)
      help=true;shift 1;;
   *)
      break;;
esac
done

if [ $idxdir != 'last_directory' ];then
   sed -i "s#docBase=\(\".*\"\) #docBase=\"$2\" #g" $tomcatdir/conf/server.xml
fi

if [[ $run == 'true' ]];then
   bash $tomcatdir/bin/startup.sh
   echo -e "\ntomcat is runnig"
elif [[ $stop == 'true' ]];then
   bash $tomcatdir/bin/shutdown.sh
   echo -e "\ntomcat has been shut down"
else
   usage
fi
