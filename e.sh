﻿#!/bin/bash

function display {

    #Clear Console
    echo -e "\033c"

    #Display MOTD
    echo "
============================================================
$(tput setaf 6) ________  ________  ________  ___  ___  ________  _______      
$(tput setaf 5)|\   ____\|\   ____\|\   __  \|\  \|\  \|\   __  \|\  ___ \     
$(tput setaf 4)\ \  \___|\ \  \___|\ \  \|\  \ \  \\\  \ \  \|\  \ \   __/|    
$(tput setaf 3) \ \_____  \ \  \    \ \  \\\  \ \  \\\  \ \   ____\ \  \_|/__  
$(tput setaf 2)  \|____|\  \ \  \____\ \  \\\  \ \  \\\  \ \  \___|\ \  \_|\ \ 
$(tput setaf 1)    ____\_\  \ \_______\ \_______\ \_______\ \__\    \ \_______\
$(tput setaf 0)   |\_________\|_______|\|_______|\|_______|\|__|     \|_______|
$(tput setaf 7)   \|_________|                                                 
=============================================================                         
    "  
}

function forceStuffs {
  # Forcing Default Server Icon.
  curl -O https://media.discordapp.net/attachments/1000330618007195668/1038180815777058888/server-icon.png

  # Forcing Hibernate Plugin.

  # Forcing MOTD.
  echo "motd=\u00a7f Ten Server jest hostowany na \u00a79ScoupeHosting\u00a7r\n\u00a77 Mozesz zmienic to MOTD w server.properties" >> server.properties
}

function launchJavaServer {
  # Using Aikars flags.
  java -Xms1024M -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar paper-server.jar nogui
}
FILE=eula.txt

# Currently this is still in development.

function optimizeJavaServer {
  # Decreasing view distance.
  echo "view-distance=10" >> server.properties

  # Slows down incremental chunk saving during the world save task
   echo "max-auto-save-chunks-per-tick: 10" >> paper.yml
  
  # Optimize explosions.
   echo "optimize-explosions: true" >> paper.yml
  
  # Disable overload warnings
   echo "warn-on-overload: false" >> spigot.yml

  # Prevents players from entering an unloaded chunk (due to lag), which causes more lag.
  # echo "prevent-moving-into-unloaded-chunks: true" >> paper.yml
  
}

if [ ! -f "$FILE" ]
then
    mkdir -p plugins
    display
sleep 5
echo "
  
  $(tput setaf 3)Którą wersje zainstalować?
  1)  1.8.8       
  2)  1.12.2      
  3)  1.16.5      
  4)  1.17.1      
  5)  1.19.2      
  "
read -r n

case $n in
  1) 
    sleep 1

    echo "$(tput setaf 3)Ok, Zainstaluje wersje 1.8.8."

    sleep 4

    forceStuffs

    curl -O https://api.papermc.io/v2/projects/paper/versions/1.8.8/builds/445/downloads/paper-1.8.8-445.jar ./paper-server.jar

    display
    
    echo "$(tput setaf 1)Z powodu tej wersji musisz zmienić obraz dokera, w przeciwnym razie nie zadziała. Przejdź do zakładki Uruchamianie i zmień obraz okna dokowanego na Java 8."
    
    sleep 10
    
    echo -e ""
    
    optimizeJavaServer
    launchJavaServer
  ;;

  2) 
    sleep 1

    echo "$(tput setaf 3)Ok, Zainstaluje wersje 1.12.2 ."

    sleep 4

    forceStuffs

    curl -O https://api.papermc.io/v2/projects/paper/versions/1.12.2/builds/1620/downloads/paper-1.12.2-1620.jar ./paper-server.jar

    display   

    echo "$(tput setaf 1)Z powodu tej wersji musisz zmienić obraz dokera, w przeciwnym razie nie zadziała. Przejdź do zakładki Uruchamianie i zmień obraz okna dokowanego na Java 11"
    
    sleep 10

    echo -e ""

    optimizeJavaServer
    launchJavaServer
  ;;

  3) 
    sleep 1

    echo "$(tput setaf 3)Ok, Zainstaluje wersje 1.16.5 ."

    sleep 4

    forceStuffs

    curl -O https://api.papermc.io/v2/projects/paper/versions/1.16.5/builds/794/downloads/paper-1.16.5-794.jar ./paper-server.jar

    display   

    echo "$(tput setaf 1)Z powodu tej wersji musisz zmienić obraz dokera, w przeciwnym razie nie zadziała. Przejdź do zakładki Uruchamianie i zmień obraz okna dokowanego na Java 16."
    
    sleep 10

    echo -e ""

    optimizeJavaServer
    launchJavaServer
  ;;

  4)
    sleep 1

    echo "$(tput setaf 3)Ok, Zainstaluje wersje 1.17.1."

    sleep 4

    forceStuffs

    curl -O https://api.papermc.io/v2/projects/paper/versions/1.17.1/builds/411/downloads/paper-1.17.1-411.jar ./paper-server.jar

    display

    sleep 10

    echo -e ""

    optimizeJavaServer
    launchJavaServer
  ;;

  5) 
    sleep 1

    echo "$(tput setaf 3)Ok , Zainstaluje wersje 1.19.2 ."

    sleep 4

    forceStuffs

    curl -O https://api.papermc.io/v2/projects/paper/versions/1.19.2/builds/258/downloads/paper-1.19.2-258.jar ./paper-server.jar

    display

    sleep 10

    echo -e ""

    optimizeJavaServer
    launchJavaServer
  ;;

  

  *) 
    echo "Niepoprawna Opcja, Anulowanie..."
    exit
  ;;
esac  
else
if [ -f plugins ]; then
mkdir plugins
fi

if [ ! -f hA5AW4Ni6Si6S4WvZ4WvZhA5AW4N.png ]; then
# Force the server icon.
curl -O https://media.discordapp.net/attachments/1000330618007195668/1038180815777058888/server-icon.png
fi
if [ -d plugins ]; then
  mkdir -p plugins

fi
fi
fi