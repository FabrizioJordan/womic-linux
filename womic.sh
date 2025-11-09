#!/bin/bash

function display_help() {
echo "Usage: womic [OPTIONS]"
    echo "Options:"
    echo "   -b   - to connect via Bluetooth"
    echo "   -w   - to connect via WiFi"
    echo "   -k   - to disconnect"
    echo "   -h   - help (this message)"
    echo "   -u   - how to Use (like User Manual)"
}

if [ $# -eq 0 ]; then
	display_help
     	exit 1
fi

if [ `ls | grep ^micclient-x86_64.*$` ]; then
    MICCLIENT=$(ls | grep ^micclient-x86_64.*$)
else
    printf "WO Mic Appimage binary not found! Would you like to download it now? (y/n): "
    read INPUT

    if [ "$INPUT" == "y" ]; then
        printf "\n"
        wget -q --show-progress https://wolicheng.com/womic/softwares/micclient-x86_64.AppImage

        if [ $? -eq 1 ]; then
            curl https://wolicheng.com/womic/softwares/micclient-x86_64.AppImage -o micclient-x86_64.AppImage
        fi

        printf "\n"
    else
        printf "\nThe WO Mic Appimage binary is required in order for the script to function.\n"
        printf "Either re-run the script and choose \"y\" to download the binary automatically or download it manually according to the README file.\n"
        exit 1
    fi
fi

function executable_check() {
    if ! [ -x $MICCLIENT ]; then
        chmod +x $MICCLIENT
    fi
}

function module_check() {
    if ! [ `lsmod | grep -o ^snd_aloop` ]; then
        sudo modprobe snd-aloop
    fi
}

function how_to_use() {
	printf "This is the User Manual\n\n"
	printf "What do you want to know? "
	printf "\n a) How to find Bluetooth address on my phone"
	printf "\n b) How to find Wi-Fi address on my phone"
	printf "\n c) What I need to connect my devices"
	printf "\nOption: "
	read LEARN
	case $LEARN in
		a)
			echo -e "\nHow to find your Bluetooth address: "
			echo -e "\nOn iPhone: "
			echo -e " Go to Settings \n Tap General \n Tap About \n Scroll down to the Bluetooth address"

			echo -e "\nOn Android: "
			echo -e " Go to Settings"
			echo -e " Tap About Phone or About Device (sometimes under the 'System' menu)"
			echo -e " Tap Status or scroll down (you may need to tap Detailed Information first)"
			echo -e " And find the Bluetooth address"

			echo -e "\nThe address format looks like this:"
                	echo -e " Format: xx:xx:xx:xx:xx:xx"
                	echo -e " Example: a4:02:b1:b0:10:54"
                	exit 0
		;;
		b)
			echo -e "\nHow to find your Wi-Fi address: "
			echo -e "\nOn iPhone: "
			echo -e " Go to Settings \n Tap General \n Tap About \n Scroll down to find the Wi-Fi address"

			echo -e "\nOn Android: "
			echo -e " Go to Settings \n Tap About Phone or About Device (sometimes under 'System' menu) \n Tap Status or scroll down (you may need to tap Detailed Information first) \n Find the Wi-Fi address"

			echo -e "\nThe address has a format like this example:"
                	echo -e " Example: 192.168.0.100"
			exit 0
		;;
		c)
		 echo -e "\nHow to use the app / How to connect your devices:"
		 echo -e "\nFirst, in your phone: "
		 echo -e " Open your WO Mic app"
		 echo -e " Connect your devices via Bluetooth or Wi-Fi"
		 echo -e " Click on the top button to start app to 'wait for connection'"
		 echo -e "Then, on your computer: "
		 echo -e " Run this script using '-b' (Bluetooth) or '-w' (for Wi-Fi)"
		 exit 0
		;;
		*)
		 echo -e "\n Invalid option. Please run again and choose a valid one.\n"
		 exit 1
		 ;;
	esac
	exit 0
}

while getopts "hbwku" OPTION; do
    case $OPTION in
        h)
         display_help
         exit 0
         ;;
        b)
         if ! [[ -z $(ps aux | grep '[m]icclient-x86_64.*$' | awk '{print $2}') ]]; then
                printf "WO Mic is already running!\n"
                exit 1
         else
                executable_check
                module_check

                printf "If you want to know where is your Bluetooth address, execute this script with '-u'"

                printf "\n\n(Format: xx:xx:xx:xx:xx:xx)\n"
                printf "Enter device address: "
                read ADDRESS
                echo ""
                printf "Run 'womic -k' to disconnect\n\n"
                ./$MICCLIENT -t Bluetooth $ADDRESS &
                sleep 3
         fi
         ;;
        w)
	 if ! [[ -z $(ps aux | grep '[m]icclient-x86_64.*$' | awk '{print $2}') ]]; then
		printf "WO Mic is already running!\n"
                exit 1
         else
                executable_check
                module_check

                printf "If you want to know where is your Wi-Fi address, execute this script with '-u'"

                printf "\n\n(Example: 192.168.0.100)\n"
                printf "Enter device IP: "
                read IP
                echo ""
                printf "Run 'womic -k' to disconnect\n\n"
                ./$MICCLIENT -t Wifi $IP &
                sleep 3
         fi
         ;;
        k)
         if ! kill -2 $(ps aux | grep '[m]icclient-x86_64.*$' | awk '{print $2}') > /dev/null 2>&1; then
         	printf "WO Mic is not running!\n"
                exit 1
         else
                kill -2 $(ps aux | grep '[m]icclient-x86_64.*$' | awk '{print $2}')
                sleep 1
                exit 0
         fi
	 ;;
	u)
	 how_to_use
	 exit 0
	 ;;
        *)
	 echo ""
         echo "Run 'womic -h' for help or 'womic -u' for the user manual"
         exit 0
         ;;
    esac
done
