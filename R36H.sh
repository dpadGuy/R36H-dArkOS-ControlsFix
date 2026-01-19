#!/bin/bash

. /usr/local/bin/buttonmon.sh

printf "\nAre you sure you want to set device type to R36H?\n"
printf "\nPress A to continue.  Press B to exit.\n"

while true; do
    Test_Button_A
    if [ "$?" -eq "10" ]; then
        cp -f /roms/tools/DeviceType/r33sConfigs/Drastic/backup/drastic.cfg.r33s /opt/drastic/config/drastic.cfg
	sudo systemctl stop oga_events
        sudo cp -f roms/tools/DeviceType/r33sConfigs/ogage/ogage.351mp /usr/local/bin/ogage
        sudo chmod 777 /usr/local/bin/ogage
	sudo systemctl start oga_events
        sudo systemctl start emulationstation
        
        cp -f /roms/tools/DeviceType/r33sConfigs/PPSSPP/r33s/controls.ini /roms/psp/ppsspp/PSP/SYSTEM/controls.ini
        cp -f /roms/tools/DeviceType/r33sConfigs/PPSSPP/r33s/ppsspp.ini /roms/psp/ppsspp/PSP/SYSTEM/ppsspp.ini
        cp -f /roms/tools/DeviceType/r33sConfigs/PPSSPP/r33s/ppsspp.ini.sdl /roms/psp/ppsspp/PSP/SYSTEM/ppsspp.ini.sdl
        cp -f /roms/tools/DeviceType/r33sConfigs/retroarch/retroarch.r36h /home/ark/.config/retroarch/retroarch.cfg
		cp -f /roms/tools/DeviceType/r33sConfigs/retroarch32/retroarch.r36h /home/ark/.config/retroarch32/retroarch.cfg
		
        if [ -d "/roms2/psp" ]; then
            cp -f /roms/tools/DeviceType/r33sConfigs/PPSSPP/r33s/controls.ini /roms2/psp/ppsspp/PSP/SYSTEM/controls.ini
            cp -f /roms/tools/DeviceType/r33sConfigs/PPSSPP/r33s/ppsspp.ini /roms2/psp/ppsspp/PSP/SYSTEM/ppsspp.ini
            cp -f /roms/tools/DeviceType/r33sConfigs/PPSSPP/r33s/ppsspp.ini.sdl /roms2/psp/ppsspp/PSP/SYSTEM/ppsspp.ini.sdl
        fi

        if [ $? -eq 0 ]; then
            printf "\nSuccessfully set the default controls on standalone emulators for the\n"
            printf "R36H\n"
			printf "Console will now restart...\n"
            sleep 5
        else
            printf "\nFailed to set the default controls on standalone emulators for the R36H\n"
            sleep 5
        fi
        exit 0
    fi

    Test_Button_B
    if [ "$?" -eq "10" ]; then
        printf "\nExiting without setting device type to R33H\n"
        sleep 1
        exit 0
    fi
done
