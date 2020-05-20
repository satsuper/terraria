#!/bin/sh

echo -e "\nBootstrap:\nconfigpath=$CONFIGPATH\nworldpath=$WORLDPATH\nlogpath=$LOGPATH\n"
echo "Copying plugins..."
ls
cp -Rfv /plugins/* ./ServerPlugins

mono --server --gc=sgen -O=all TerrariaServer.exe -configPath "$CONFIGPATH" -worldpath "$WORLDPATH" -logpath "$LOGPATH" "$@" 