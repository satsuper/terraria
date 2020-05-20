#!/bin/sh
echo -e "\nBootstrap:\nconfigpath=$CONFIGPATH\nworldpath=$WORLDPATH\nlogpath=$LOGPATH\n"
mono --server --gc=sgen -O=all TerrariaServer.exe -configPath "$CONFIGPATH" -worldpath "$WORLDPATH" -logpath "$LOGPATH" "$@" 