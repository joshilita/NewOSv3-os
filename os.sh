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
version="$(<~/NewOSv3/.vers)"
updatedv=$(curl  -s 'https://raw.githubusercontent.com/joshilita/NewOSv3-os/main/.vers')
machine=$(uname -o)
if [ "$machine" = "Android" ]; then
echo -e "${ERRORFG}Unfortunately, Termux is not supported. ${BBLUEFG}Operating system detected as ${machine} ${RESET}"
else
echo -e "${BBLUEFG}NewOS V3 who dis?"
if [ -f ~/NewOSv3/updated ]; then
echo -e "${GREENFG}NewOS updated. Configuring.."
sleep 2
rm -rf ~/NewOSv3/updated
rm -rf ~/update
bash ~/NewOSv3/os.sh
exit 0
fi
if [ "$version" = "$updatedv" ]; then
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
echo -e "${REDWEAKFG}(c)2021 Joshilita Open Source"
echo -e "${GBLUEFG}You can also start this with the command <newos>."
echo -e "${REDWEAKFG}Please wait 5 minutes after a new update is released."
echo -e "Version: ${version} Latest: ${updatedv}"
echo -e "${BBLUEFG}Loading."
sleep 3
while true; do
echo -e "Welcome ${username}, please enter your password."
read -s enterpass
if [ "$enterpass" = "$password" ]; then
while true; do
if [ -f ~/NewOSv3/flogin ]; then
echo -e "${GREENFG}This is your first time logging in!"
sleep 2
echo -e "You can type <help> to see the list of commands."
rm -rf ~/NewOSv3/flogin
else
echo -e -n "(${GREENFG}${username}${RESET}@${REDWEAKFG}localhost${RESET} ${BBLUEFG}${RESET}) ${BOLD}\$ ${RESET}";
read input
if [ "$input" = "help" ]; then
echo -e "${RESET}exit - Exits NewOS"
echo "help - Shows you a list of commamnds and what they can do"
elif [ "$input" = "exit" ]; then
echo -e "${GREENFG}Bye!${RESET}"
exit 0
elif [ "$input" = "changelog" ]; then
echo -e $(curl -s 'https://raw.githubusercontent.com/joshilita/NewOSV3/main/changelog.txt')
else
echo -e "${ERRORFG}Command not found.${RESET}"
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
echo -e "Not updated, Current: ${version} New: ${updatedv}"
echo "Please wait..."
sleep 2
cd ~
git clone https://github.com/joshilita/update
cd ~/update
bash updater.sh
exit 0
fi
fi
