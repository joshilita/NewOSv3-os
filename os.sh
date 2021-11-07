#!/usr/bin/env bash
GREENFG="\e[38;5;82m"
REDWEAKFG="\e[38;5;132m"
BBLUEFG="\e[1;38;5;75m"
GBLUEFG="\e[1;38;5;73m"
FOLDERNAMEFG="\e[1;38;5;45m"
ERRORFG="\e[1;38;5;197m"
RESET="\e[0m"
BOLD="\e[1m"
username="$(<.name)"  
password="$(<.pass)"

echo -e "${BBLUEFG}NewOS V3 who dis?"

if [ -f startup ]; then
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
rm -rf startup
bash os.sh
exit 0
else
echo "Welcome to"
figlet -f slant NewOS V3!
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