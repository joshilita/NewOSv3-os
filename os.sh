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
UPSTREAM=${1:-'@{u}'}
LOCAL=$(cd ~/NewOSv3/ | git rev-parse @)
REMOTE=$(cd ~/NewOSv3/ | git rev-parse "$UPSTREAM")
BASE=$(cd ~/NewOSv3/ | git merge-base @ "$UPSTREAM")

echo -e "${BBLUEFG}NewOS V3 who dis?"
if [ $LOCAL = $REMOTE ]; then
if [ -f ~/NewOSv3/startup ]; then
echo -e "${GBLUEFG}Welcome ${username}, to NewOS V3!"
sleep 1 
echo "It looks like its your first time here!"
sleep 1 
echo -e "We have to install some packages for this thing to get started! ${REDWEAKFG}(Requires Root Permission)${RESET}"
sudo echo -e "${GREENFG}Permission Granted!${RESET}"
echo "Updating Packages..."
sudo apt update -y -qq > /dev/null
sleep 1
echo "Installing Packeges... (Figlet, Zenity)"
sudo apt install figlet dialog -y -qq > /dev/null
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
echo "(c)2021 Joshilita Open Source"
echo "You can also start this with the command <newos>."
echo -e "${BBLUEFG}Loading."
sleep 3
echo -e "Welcome ${username}, please enter your password."
read -r enterpass
if [ "$enterpass" = "$password" ]; then
echo "entrrr"
else
echo -e "${ERRORFG}Wrong pass! Restarting..."
sleep 4
bash os.sh
exit 0
fi
fi
elif [ $LOCAL = $BASE ]; then
echo "not update"
fi