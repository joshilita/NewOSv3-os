#!/usr/bin/env bash
cd ~/NewOSv3/
GREENFG="\e[38;5;82m"
REDWEAKFG="\e[38;5;132m"
BBLUEFG="\e[1;38;5;75m"
GBLUEFG="\e[1;38;5;73m"
FOLDERNAMEFG="\e[1;38;5;45m"
ERRORFG="\e[1;38;5;197m"
RESET="\e[0m"
BOLD="\e[1m"

version="$(sed -n '1p' ~/NewOSv3/.vers)"
insver="$(sed -n '3p' ~/NewOSv3/.vers)"
updatedv=$(curl -H 'Cache-Control: no-cache' -s 'https://raw.githubusercontent.com/joshilita/NewOSv3-os/main/.vers' | sed -n '1p')
updateins=$(curl -H 'Cache-Control: no-cache' -s 'https://raw.githubusercontent.com/joshilita/NewOSv3-os/main/.vers' | sed -n '3p')
clear
machine=$(uname -o)
ifazure=$(uname -a | grep azure)
rebootrequire=false
rebootrecon=false

if [ -f ~/NewOSv3/Logs.txt ]; then
echo "" >> ~/NewOSv3/Logs.txt
echo "($(date +\%r)) Log Started at $(date +%m-%d-%Y)." >> ~/NewOSv3/Logs.txt
randomnumber=$RANDOM
echo "Log ID: $randomnumber" >> ~/NewOSv3/Logs.txt
fi
if [ ! "$machine" ]; then
echo -e "${ERRORFG}OPERATING SYSTEM NOT FOUND.${RESET}"
exit 0
fi
if [ "$ifazure" ]; then
echo "ooo running on azure. nice"
sleep 0.2
fi
if [ "$machine" = "Android" ]; then
echo -e "${ERRORFG}Unfortunately, Termux is not supported. ${BBLUEFG}Operating system detected as ${machine} ${RESET}"
else
if [ -f ~/NewOSv3/updated ]; then
echo -e "${GREENFG}NewOS updated. Configuring.."
sleep 2
rm -rf ~/NewOSv3/updated
rm -rf ~/update
bash ~/NewOSv3/os.sh
exit 0
fi
if [ "$insver" = "$updateins" ]; then
if [ "$version" = "$updatedv" ]; then
if [ -f ~/NewOSv3/startup ]; then
if [ "$machine" = "Android" ]; then
echo -e "${ERRORFG}Unfortunately, Termux is not supported. ${BBLUEFG}Operating system detected as ${machine} ${RESET}"
fi
echo -e "${GBLUEFG}Welcome ${username}, to NewOS V3!"
sleep 1 
echo "It looks like its your first time here!"
if [ ! "$machine" ]; then
echo -e "${ERRORFG}OPERATING SYSTEM NOT FOUND${RESET}"
exit 0
fi
sleep 1 
echo -e "We have to install some packages for this thing to get started! ${REDWEAKFG}(Requires Root Permission)${RESET}"
sudo echo -e "${GREENFG}Permission Granted!${RESET}"
echo "Updating Packages..."
sudo apt update -y -qq > /dev/null
sleep 1
echo "Installing Packeges... (Figlet, Zenity, jq)"
sudo apt install figlet dialog jq -y -qq > /dev/null
echo -e "${GREENFG}All done! Restarting NewOS..."
touch ~/NewOSv3/newos
echo "bash ~/NewOSv3/os.sh" > ~/NewOSv3/newos
sudo mv ~/NewOSv3/newos /usr/bin
sudo chmod +x /usr/bin/newos
rm -rf ~/NewOSv3/startup
bash ~/NewOSv3/os.sh
exit 0
else
echo "Welcome to"
figlet -f slant NewOS V3
echo -e "${REDWEAKFG}(c)2021-2022 Joshilita"
echo -e "${GBLUEFG}You can also start this with the command <newos>."
echo -e "${REDWEAKFG}Please wait 5 minutes after a new update is released."
echo -e "Version: ${version}"
if [ -f ~/NewOSv3/Logs.txt ]; then
echo -e "${ERRORFG}(WARNING)${GBLUEFG} Log Service is active. Every action will be logged in the Logs.txt file."
 sleep 2
    fi
sleep 5
clear
echo -e "${BBLUEFG}Loading configurations.."
hostlol=~/NewOSv3/.host
userlol=~/NewOSv3/.user
passlol=~/NewOSv3/.pass
if [ ! -f "$hostlol" ]; then
    echo -e "${ERRORFG}FATAL ERROR: Host configurations are inaccessible. Please reinstall NewOS.${RESET}"
    exit 0
    elif [ ! -f "$userlol" ]; then
        echo -e "${ERRORFG}FATAL ERROR: User configurations are inaccessible. Please reinstall NewOS. (info: u)${RESET}"
        exit 0

    elif [ ! -f "$passlol" ]; then
        echo -e "${ERRORFG}FATAL ERROR: User configurations are inaccessible. Please reinstall NewOS. (info: p)${RESET}"
        exit 0
    
fi
host="$(<~/NewOSv3/.host)"
username="$(<~/NewOSv3/.name)"  
password="$(<~/NewOSv3/.pass)"
sleep 1
if [ -f ~/NewOSv3/Logs.txt ]; then
echo "($(date +\%r)) Configurations Loaded" >> ~/NewOSv3/Logs.txt
fi
echo -e "${BBLUEFG}Loading packages.."
sleep 2
if [ -f ~/NewOSv3/Logs.txt ]; then
echo "($(date +\%r)) Packages Loaded" >> ~/NewOSv3/Logs.txt
fi
echo -e "${GREENFG}Ready!${RESET}"
if [ -f ~/NewOSv3/Logs.txt ]; then
echo "($(date +\%r)) Everything is loaded. User needs to log in now." >> ~/NewOSv3/Logs.txt
fi
sleep 1
clear
if [ ! "$machine" ]; then
echo -e "${ERRORFG}OPERATING SYSTEM NOT FOUND${RESET}"
exit 0
fi
if [ "$machine" = "Android" ]; then
echo -e "${ERRORFG}Unfortunately, Termux is not supported. How did you get here?${BBLUEFG}Operating system detected as ${machine} ${RESET}"
fi

while true; do
echo -e "Welcome ${username}, please enter your password."
read -s enterpass
if [ "$enterpass" = "$password" ]; then
if [ -f ~/NewOSv3/Logs.txt ]; then
echo "($(date +\%r)) User ${username} logged in." >> ~/NewOSv3/Logs.txt
fi
while true; do
if [ -f ~/NewOSv3/flogin ]; then
echo -e "${GREENFG}This is your first time logging in!"
sleep 2
if [ ! "$machine" ]; then
echo -e "${ERRORFG}OPERATING SYSTEM NOT FOUND${RESET}"
exit 0
fi
echo -e "You can type <help> to see the list of commands."
rm -rf ~/NewOSv3/flogin
else
if [ "$machine" = "Android" ]; then
echo -e "${ERRORFG}Unfortunately, Termux is not supported. ${BBLUEFG}Operating system detected as ${machine} ${RESET}"
fi

echo -e -n "(${GREENFG}${username}${RESET}@${REDWEAKFG}${host}${RESET}${BBLUEFG}${RESET}) ${BOLD}\$ ${RESET}";
read input
if [ $rebootrequire == true ]; then
echo -e "${ERRORFG}You are unable to do anything until you reboot. Do you want to reboot? (Reboot Required)${RESET}"
read -r rebootplss
    if [ "$rebootplss" = "y" ]; then
    echo -e "${ERRORFG}Rebooting.${RESET}"
    newos
    exit 0

    else
echo -e "${ERRORFG}Ight. Have fun doing nothin then :skull:${RESET}"
break
    fi
fi
if [ $rebootrecon == true ]; then
echo -e "${ERRORFG}Reboot recomendation is active. When you have time, please reboot NewOS.${RESET}"
fi
if [ -f ~/NewOSv3/Logs.txt ]; then
echo "($(date +\%r)) Command '${input}' was entered." >> ~/NewOSv3/Logs.txt
fi
if [ "$input" = "help" ]; then
echo -e "${RESET}exit - Exits NewOS"
echo "help - Shows you a list of commamnds and what they can do"
echo "changelog - It shows you a changelog."
echo "reboot - Restarts NewOS. Will be used if there is a fatal error."
echo "host - Change hostname. Restart is required."
echo "pcks get - Shows list of available packages"
echo "pcks install - Installs package"
echo "pcks uninstall - Deletes package"
echo "logs all - Gets all logs"
echo "logs - Shows you specific log"
echo "service enable logs - Enables the logging service"
echo "service disable logs - Disables the logging service"


elif [ "$input" = "logs" ]; then
FILE=~/NewOSv3/Logs.txt
if [ -f "$FILE" ]; then
echo -e "${BBLUEFG}What is the ID of the log?${RESET}"
read allah
date=$(cat Logs.txt | grep -n "${allah}" | grep -Eo '^[^:]+')

realdate=${date}
okmaya=$(($realdate - 1))
assumeed=$(sed -n '/^$/=' Logs.txt)
if [ "$allah" = "$randomnumber" ]; then
 echo -e "${ERRORFG}Log ${allah} is being used. Please restart NewOS if you want to see this log.${RESET}"
fi
for line in $assumeed
do

if [ "$line" != "9" ]; then
if [ "$line" \> "$realdate" ]; then
echo "$(sed -n -e "${okmaya},${line} p" -e "${line} q" Logs.txt)"

break
fi
fi
done
else
echo -e "${ERRORFG}Log Service is not enabled. Abort${RESET}"
fi
elif [ "$input" = "logs all" ]; then
FILE=~/NewOSv3/Logs.txt
if [ -f "$FILE" ]; then
maybenohaha=$(cat Logs.txt | grep "Log ID" | sed 's/Log ID://')
for line in $maybenohaha
do
# mamaci=$maybenohaha | 
echo ""

date=$(cat Logs.txt | grep -n "${line}" | grep -Eo '^[^:]+')
realdate=${date}
okfrdate=$(($realdate - 1))
echo "ID: $line"
echo "Time: $(sed -n ${okfrdate}p Logs.txt | cut -c 2-12)"
echo "Date: $(sed -n ${okfrdate}p Logs.txt | cut -c 30-39)"
if [ "$line" = "$randomnumber" ]; then
 echo -e "${BBLUEFG}Log ${line} is currently active. You will not be able to see this log until NewOS shuts down.${RESET}"
fi

done
else
echo -e "${ERRORFG}Log Service is not enabled. Abort${RESET}"
fi
elif [ "$input" = "pcks uninstall" ]; then

echo -e "${BBLUEFG}What package would you like to uninstall?${RESET}"
read puinstall
 if [ -f ~/NewOSv3/Logs.txt ]; then
    echo "($(date +\%r)) Package Deletion: ${puinstall}">> ~/NewOSv3/Logs.txt
    fi
if [ -d ~/NewOSv3/Packages/${puinstall} ]; then
byebye=$(curl -s https://raw.githubusercontent.com/joshilita/packages/main/list.json | jq ".Packages[].name" | grep -w ${puinstall} -n | cut -c1-1)
 if [ -z "${byebye}" ]; then
 echo -e "${BBLUEFG}It seems that this is a custom package. Are you sure you want to delete this? (Package not found in database) ${RESET}"
 if [ -f ~/NewOSv3/Logs.txt ]; then
    echo "($(date +\%r)) Package Deletion Warn (CSTM PCKG- NOT IN DTABASE)" >> ~/NewOSv3/Logs.txt
    fi
read -r uninstallmaybe
    if [ "$uninstallmaybe" = "y" ]; then
    rm -rf ~/NewOSv3/Packages/${puinstall}
     echo -e "${BBLUEFG}Package Uninstalled.${RESET}"
      if [ -f ~/NewOSv3/Logs.txt ]; then
    echo "($(date +\%r)) Custom Package Deleted: ${puinstall}">> ~/NewOSv3/Logs.txt
    fi

    fi
 
else
rm -rf ~/NewOSv3/Packages/${puinstall}
     echo -e "${BBLUEFG}Package Uninstalled.${RESET}"
     if [ -f ~/NewOSv3/Logs.txt ]; then
    echo "($(date +\%r)) Package Deleted: ${puinstall}">> ~/NewOSv3/Logs.txt
    fi
    fi
else
echo -e "${ERRORFG}Package not installed. Did you enter it in correctly?"
fi
elif [ "$input" = "service disable logs" ]; then
FILE=~/NewOSv3/Logs.txt
if [ -f "$FILE" ]; then
echo -e "${ERRORFG}This will delete the logs file. Are you sure? (Type save to save into a new file)${RESET}"
read -r logsdelete
    if [ "$logsdelete" = "y" ]; then
    rm -rf ~/NewOSv3/Logs.txt
    echo -e "${ERRORFG}Service Disabled. Rebooting${RESET}"
    sleep 1
    newos
    exit 0
    elif [ "$logsdelete" = "save" ]; then
    touch "$(date +%m-%d-%Y)-${randomnumber}-Logs.txt"
    cat Logs.txt >> "$(date +%m-%d-%Y)-${randomnumber}-Logs.txt"
    echo -e "${BBLUEFG}Saved into $(date +%m-%d-%Y)-${randomnumber}-Logs.txt - Service Disabled. Reboot required at level HIGH"
    rebootrequire=true
    rm -rf ~/NewOSv3/Logs.txt


    else
    echo -e "${ERRORFG}Okay. Abort${RESET}"
     if [ -f ~/NewOSv3/Logs.txt ]; then
    echo "($(date +\%r)) Thank you for not deleting me :> (aborted logs service disable)" >> ~/NewOSv3/Logs.txt
    fi
    
    fi
else
echo -e "${ERRORFG}Log Service is not enabled. Abort${RESET}"

fi
elif [ "$input" = "service enable logs" ]; then
echo -e "${BBLUEFG}Enabling Log Service.${RESET}"
FILE=~/NewOSv3/Logs.txt
if [ -f "$FILE" ]; then
echo -e "${ERRORFG}Log Service is already enabled.${RESET}"
else
sleep 2
touch ~/NewOSv3/Logs.txt
echo "$(figlet NewOS Dev Log)" >> ~/NewOSv3/Logs.txt
echo "($(date +\%r)) Log Service Enabled" >> ~/NewOSv3/Logs.txt
echo "($(date +\%r)) Log Started at $(date +%m-%d-%Y)." >> ~/NewOSv3/Logs.txt
echo -e "${BBLUEFG}Log Service enabled. Restarting NewOS..${RESET}"
echo "($(date +\%r)) Rebooting NewOS (Initiated by SERVICE)" >> ~/NewOSv3/Logs.txt
sleep 3
newos
exit 0


fi




elif [ "$input" = "pcks install" ]; then
echo -e "${BBLUEFG}What package would you like to install?${RESET}"
read pinstall
echo -e "${BBLUEFG}Checking package database..${RESET}"
if [ -f ~/NewOSv3/Logs.txt ]; then
    echo "($(date +\%r)) Installing package: ${pinstall} (Requested by User)" >> ~/NewOSv3/Logs.txt
    fi
hello=$(curl -s https://raw.githubusercontent.com/joshilita/packages/main/list.json | jq ".Packages[].name" | grep -w ${pinstall} -n | cut -c1-1)
 if [ -z "${hello}" ]; then
 echo -e "${ERRORFG}Package "${pinstall}" is not found. Please check if you entered the right package name.${RESET}"
 if [ -f ~/NewOSv3/Logs.txt ]; then
    echo "($(date +\%r)) Package Installation Failed: (PCKG NOT FOUND)" >> ~/NewOSv3/Logs.txt
    fi
else
echo -e "${GREENFG}Package found!${RESET}"

echo -e "${BBLUEFG}Checking package requirements...${RESET}"
packagereq=$(curl -s https://raw.githubusercontent.com/joshilita/packages/main/list.json | jq ".Packages[$(($hello-1))].infolink ")
maybetes=$(echo "${packagereq}" | sed 's/"//g')
yas=$(curl -s ${maybetes} | jq ".requirements " | sed 's/"//g')
inst=$(curl -s ${maybetes} | jq ".runafterinstall " | sed 's/"//g')
if [ "$inst" = "Yes" ]; then
 echo -e "${BBLUEFG}Package needs to be ran after installation.${RESET}" 
   




fi
# echo -e "It says: ${inst}"
#      echo -e "It says: ${yas}"
#      echo -e "It says: ${maybetes}"
#          echo -e "It says: ${packagereq}"
#     echo -e "It says: ${hello}"
 if [ -f ~/NewOSv3/Logs.txt ]; then
    echo "($(date +\%r)) Package Info:" >> ~/NewOSv3/Logs.txt
    echo "Info Link: ${maybetes}" >> ~/NewOSv3/Logs.txt
    echo "Package Number: ${hello}" >> ~/NewOSv3/Logs.txt
    echo "Start automatically after install: ${inst}" >> ~/NewOSv3/Logs.txt



    fi
echo -e "${BBLUEFG}No requirements found. Installing Package${RESET}"
if [ ! -d ~/NewOSv3/Packages ]; then
 echo -e "${BBLUEFG}Creating packages folder.${RESET}" 
 mkdir ~/NewOSv3/Packages
fi
if [ -d ~/NewOSv3/Packages/${pinstall} ]; then
echo -e "${ERRORFG}Package "${pinstall}" is already installed.${RESET}"
 if [ -f ~/NewOSv3/Logs.txt ]; then
    echo "($(date +\%r)) Package Installation Failed (PCKG ALREADY INST)" >> ~/NewOSv3/Logs.txt
    fi
else

echo -e "${BBLUEFG}Downloading package...${RESET}"
mkdir ~/NewOSv3/Packages/${pinstall}
touch ~/NewOSv3/Packages/${pinstall}/run.sh
curl -s "https://raw.githubusercontent.com/joshilita/packages/main/${pinstall}/run.sh" >> ~/NewOSv3/Packages/${pinstall}/run.sh
echo -e "${GREENFG}Package installed!${RESET}"
 if [ -f ~/NewOSv3/Logs.txt ]; then
    echo "($(date +\%r)) Package Installation Successful (PCKG INSTALLED)" >> ~/NewOSv3/Logs.txt
    fi
if [ "$inst" = "Yes" ]; then
 echo -e "${BBLUEFG}Starting package.${RESET}" 
 sleep 1

 touch ~/NewOSv3/Packages/${pinstall}/startup
 bash ~/NewOSv3/Packages/${pinstall}/run.sh


fi


fi

fi
elif [ "$input" = "pcks get" ]; then
touch ~/templist.txt
echo -e "${BBLUEFG}Getting all packages. This may take a while.${RESET}"
if [ -f ~/NewOSv3/Logs.txt ]; then
    echo "($(date +\%r)) Getting all packages (Requested by User)" >> ~/NewOSv3/Logs.txt
    fi
tput sc
yessir=0
yes=$(curl -H 'Cache-Control: no-cache' -s https://raw.githubusercontent.com/joshilita/packages/main/list.json | jq ".Packages[].name")
amount=$(echo "$yes" | wc -l)
actual=$(($amount-1))
# echo $(curl -s https://raw.githubusercontent.com/joshilita/packages/main/list.json | jq ".Packages[${actual}]")
for line in $yes 
do

yessir=$(($yessir+1))
tput rc;tput el 
echo "Percentage: ${yessir}/${amount}"
   echo "Name: ${line}"|sed 's/"//g' >> ~/templist.txt
info=$(curl -H 'Cache-Control: no-cache' -s https://raw.githubusercontent.com/joshilita/packages/main/list.json | jq ".Packages[$(($yessir-1))].infolink ")
maybeso=$(echo "${info}" | sed 's/"//g')
idkhaha=$(echo "${line}" | sed 's/"//g')

echo "Description: $(curl -s ${maybeso} | jq ".description " | sed 's/"//g')" >> ~/templist.txt
if [ -d ~/NewOSv3/Packages/${idkhaha} ]; then
echo "Installed: Yes" >> ~/templist.txt
else
echo "Installed: No" >> ~/templist.txt

fi
echo "" >> ~/templist.txt
done
cat ~/templist.txt
rm  ~/templist.txt

elif [ "$input" = "host" ]; then
echo -e "${BBLUEFG}What do you want to change your hostname to?${RESET}"
read -r hostfh
echo "${hostfh}" > ~/NewOSv3/.host
if [ -f ~/NewOSv3/Logs.txt ]; then
echo "($(date +\%r)) Hostname was changed to '${hostfh}' (User-Reboot is recommended)" >> ~/NewOSv3/Logs.txt
fi
echo -e "${GREENFG}Hostname changed to: ${hostfh}. A restart is required for effect. (Restart requirement at RECOMMENDED) ${CLEAR}"
rebootrecon=true



elif [ "$input" = "reboot" ]; then
echo -e "${BBLUEFG}Are you sure you want to restart NewOS?${RESET}"
  read -r maybe
    if [ "$maybe" = "y" ]; then
    echo "Rebooting..."
    if [ -f ~/NewOSv3/Logs.txt ]; then
    echo "($(date +\%r)) Rebooting NewOS (Initiated by User)" >> ~/NewOSv3/Logs.txt
    fi
    sleep 3
    if [ -f ~/NewOSv3/Logs.txt ]; then
    echo "($(date +\%r)) End of log" >> ~/NewOSv3/Logs.txt
    fi
    newos
    exit 0
    fi

elif [ "$input" = "exit" ]; then
echo -e "${GREENFG}Bye!${RESET}"
if [ -f ~/NewOSv3/Logs.txt ]; then
echo "($(date +\%r)) Exited by user. End of log" >> ~/NewOSv3/Logs.txt
fi
exit 0

elif [ "$input" = "changelog" ]; then
echo -e $(curl -s 'https://raw.githubusercontent.com/joshilita/NewOSV3/main/changelog.txt')

elif [ "$input" = "" ]; then
echo "type something"
elif [ "$input" = "dlg1221" ]; then
echo -e "${ERRORFG}01000101 01101110 01110100 01100101 01110010 00100000 01110000 01100001 01110011 01110011 00101110"
read -s ddll
dddd=$(curl -s 'https://raw.githubusercontent.com/joshilita/joshilita/main/bigchicjpotpie')
if [ "$ddll"  = "$dddd" ]; then
data=$(dialog --passwordbox "Enter your password" 10 30 3>&1- 1>&2- 2>&3-)
if [ "$data" = "1221441" ]; then
clear
echo "nice"
fi
fi
else
if [ -d ~/NewOSv3/Packages/${input} ]; then
if grep -q "404: Not Found" ~/NewOSv3/Packages/${input}/run.sh; then
  echo -e "${ERRORFG}Package was installed incorrectly. Please try to install the package again.${RESET}"
  if [ -f ~/NewOSv3/Logs.txt ]; then
    echo "($(date +\%r)) Package Error (PCKG INSTALLED INCORRECTLY WITH 404)" >> ~/NewOSv3/Logs.txt
    fi
else
bash ~/NewOSv3/Packages/${input}/run.sh
fi
 
else
echo -e "${ERRORFG}(${input})Command not found.${RESET}"
if [ -f ~/NewOSv3/Logs.txt ]; then
echo "($(date +\%r)) Command was not found" >> ~/NewOSv3/Logs.txt
fi
fi

fi
fi
done
elif [ "$enterpass" = "resetpasswd" ]; then
echo "Reset Pass"
read -r passres
echo "${passres}" > ~/NewOSv3/.pass
echo "Password Resetted"
exit 0
elif [ "$enterpass" = "changelog" ]; then 
echo -e $(curl -s 'https://raw.githubusercontent.com/joshilita/NewOSV3/main/changelog.txt')
else
echo -e "${ERRORFG}Wrong pass!"
fi
done
fi

else
if [ ! "$machine" ]; then
echo -e "${ERRORFG}OPERATING SYSTEM NOT FOUND${RESET}"
exit 0
fi
echo -e "Not updated, Current: ${version} New: ${updatedv}"
echo "Please wait..."
sleep 2
cd ~
git clone https://github.com/joshilita/update
cd ~/update
bash updater.sh
exit 0
fi
else 

echo "ins noat upadj"
fi
fi
