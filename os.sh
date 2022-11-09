#!/usr/bin/env bash
GREENFG="\e[38;5;82m"
REDWEAKFG="\e[38;5;132m"
BBLUEFG="\e[1;38;5;75m"
GBLUEFG="\e[1;38;5;73m"
FOLDERNAMEFG="\e[1;38;5;45m"
ERRORFG="\e[1;38;5;197m"
RESET="\e[0m"
BOLD="\e[1m"
username="$(<~/NewOSv3/.name)"  
password="$(<~/NewOSv3/.pass)"
version="$(sed -n '1p' ~/NewOSv3/.vers)"
insver="$(sed -n '3p' ~/NewOSv3/.vers)"
updatedv=$(curl -H 'Cache-Control: no-cache' -s 'https://raw.githubusercontent.com/joshilita/NewOSv3-os/main/.vers' | sed -n '1p')
updateins=$(curl -H 'Cache-Control: no-cache' -s 'https://raw.githubusercontent.com/joshilita/NewOSv3-os/main/.vers' | sed -n '3p')
clear
machine=$(uname -o)
ifazure=$(uname -a | grep azure)
host="$(<~/NewOSv3/.host)"
if [ ! "$machine" ]; then
echo -e "${ERRORFG}OPERATING SYSTEM NOT FOUND.${RESET}"
exit 0
fi
if [ "$ifazure" ]; then
echo "ooo running on azure. nice"
sleep 3
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
figlet -f slant NewOS V3!
echo -e "${REDWEAKFG}(c)2021-2022 Joshilita"
echo -e "${GBLUEFG}You can also start this with the command <newos>."
echo -e "${REDWEAKFG}Please wait 5 minutes after a new update is released."
echo -e "Version: ${version}"
sleep 5
clear
echo -e "${BBLUEFG}Loading configurations.."
sleep 2
echo -e "${BBLUEFG}Loading packages.."
sleep 3
echo -e "${GREENFG}Ready!${RESET}"
sleep 1
clear
if [ ! "$machine" ]; then
echo -e "${ERRORFG}OPERATING SYSTEM NOT FOUND${RESET}"
exit 0
fi
if [ "$machine" = "Android" ]; then
echo -e "${ERRORFG}Unfortunately, Termux is not supported. How did you get here?${BBLUEFG}Operating system detected as ${machine} ${RESET}"
fi
FILE=~/NewOSv3/.host
if [ ! -f "$FILE" ]; then
    echo -e "${REDWEAKFG} NewOS needs to be reinstalled due to a major bug fix. Please update the installer and reinstall NewOS.${RESET}"
    exit 0
fi
while true; do
echo -e "Welcome ${username}, please enter your password."
read -s enterpass
if [ "$enterpass" = "$password" ]; then
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
if [ "$input" = "help" ]; then
echo -e "${RESET}exit - Exits NewOS"
echo "help - Shows you a list of commamnds and what they can do"
echo "changelog - It shows you a changelog."
echo "reboot - Restarts NewOS. Will be used if there is a fatal error."
echo "host - Change hostname. Restart is required."
echo "pcks get - Shows list of available packages"
echo "pcks install - Installs package"

elif [ "$input" = "pcks install" ]; then
echo -e "${BBLUEFG}What package would you like to install?${RESET}"
read pinstall
echo -e "${BBLUEFG}Checking package database..${RESET}"
hello=$(curl -s https://raw.githubusercontent.com/joshilita/packages/main/list.json | jq ".Packages[].name" | grep -w ${pinstall} -c)
 if (( $hello == 0 )); then
 echo -e "${ERRORFG}Package "${pinstall}" is not found. Please check if you entered the right package name.${RESET}"
else
echo -e "${GREENFG}Package found!${RESET}"

echo -e "${BBLUEFG}Checking inner OS package requirement...${RESET}"
packagereq=$(curl -s https://raw.githubusercontent.com/joshilita/packages/main/list.json | jq ".Packages[$(($hello-1))].infolink ")
maybetes=$(echo "${packagereq}" | sed 's/"//g')
yas=$(curl -s ${maybetes} | jq ".requirements " | sed 's/"//g')
inst=$(curl -s ${maybetes} | jq ".runafterinstall " | sed 's/"//g')
if (( $inst == "Yes" )); then
 echo -e "${BBLUEFG}Package needs to be ran after installation.${RESET}" 

fi
if (( $yas != "None" )); then
echo -e "${BBLUEFG}No requirements found. Installing Package${RESET}"

else
echo -e "${BBLUEFG}Requirements found. We need to install some inner OS packages using APT. (REQUIRES SUDO)${RESET}"
sudo echo "${GREENFG}Installing these packages: ${BBLUEFG}${yas}${RESET}"
sleep 3
sudo apt update -y -qq > /dev/null
sudo apt install ${yas} -y 


fi
if [ ! -d ~/NewOSv3/Packages ]; then
 echo -e "${BBLUEFG}Creating packages folder.${RESET}" 
 mkdir ~/NewOSv3/Packages
fi
if [ -d ~/NewOSv3/Packages/${pinstall} ]; then
echo -e "${ERRORFG}Package "${pinstall}" is already installed.${RESET}"
else

echo -e "${BBLUEFG}Downloading package...${RESET}"
mkdir ~/NewOSv3/Packages/${pinstall}
touch ~/NewOSv3/Packages/${pinstall}/run.sh
curl -s "https://raw.githubusercontent.com/joshilita/packages/main/${pinstall}/run.sh" >> ~/NewOSv3/Packages/${pinstall}/run.sh
echo -e "${GREENFG}Package installed!${RESET}"
if (( $inst == "Yes" )); then
 echo -e "${BBLUEFG}Starting package.${RESET}" 
 sleep 1

 touch ~/NewOSv3/Packages/${pinstall}/startup
 bash ~/NewOSv3/Packages/${pinstall}/run.sh




fi
fi

fi
echo "${hello}"
elif [ "$input" = "pcks get" ]; then
touch ~/templist.txt
echo -e "${BBLUEFG}Getting all packages. This may take a while.${RESET}"
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
echo -e "${GREENFG}Hostname changed to: ${hostfh}. A restart is required for effect.${CLEAR}"



elif [ "$input" = "reboot" ]; then
echo -e "${BBLUEFG}Are you sure you want to restart NewOS?${RESET}"
  read -r maybe
    if [ "$maybe" = "y" ]; then
    echo "Rebooting..."
    sleep 3
    newos
    exit 0
    fi

elif [ "$input" = "exit" ]; then
echo -e "${GREENFG}Bye!${RESET}"
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
else
bash ~/NewOSv3/Packages/${input}/run.sh
fi
 
else
echo -e "${ERRORFG}(${input})Command not found.${RESET}"
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

