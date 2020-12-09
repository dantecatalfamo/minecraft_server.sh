#!/bin/sh

HREF=$(curl -s -S "https://www.minecraft.net/en-us/download/server" | grep "server.jar")
DOWNLOAD=$(echo $HREF | cut -d '"' -f 2)
FILENAME=$(echo $HREF | awk -F "[<>]" '{ print $3 }')

if [ -e "$FILENAME" ]; then
    echo "Minecraft server up to date."
else
    echo "Downloading latest version of Minecraft server, $FILENAME."
    curl -s -S -o "$FILENAME" "$DOWNLOAD"
fi

SERVER_JAR=$(ls minecraft_server.* | sort -r | head -n 1)
echo Starting $SERVER_JAR
java -Xms512M -Xmx2G -server -XX:+UseG1GC -XX:ParallelGCThreads=4 -jar $SERVER_JAR nogui
