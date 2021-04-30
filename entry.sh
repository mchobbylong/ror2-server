#!/bin/bash

echo "Generating server configuration..."
envsubst < "default_config.cfg" > "${STEAMAPPDIR}/Risk of Rain 2_Data/Config/server.cfg"

if [ "${R2_ENABLE_MODS}" = 1 ]; then
    echo "Setting up mods..."
    cp -r ${STEAMAPPDIR}/mods/BepInEx             ${STEAMAPPDIR}/BepInEx
    cp    ${STEAMAPPDIR}/mods/doorstop_config.ini ${STEAMAPPDIR}/doorstop_config.ini
    cp    ${STEAMAPPDIR}/mods/winhttp.dll         ${STEAMAPPDIR}/winhttp.dll
    DLL="winhttp=n,b"
fi

echo "Generating initial Wine configuration..."
/opt/wine-stable/bin/winecfg

echo "Let's wait :)"
sleep 5

echo "Starting server..."
WINEDLLOVERRIDES=${DLL} xvfb-run /opt/wine-stable/bin/wine "${STEAMAPPDIR}/Risk of Rain 2.exe"
