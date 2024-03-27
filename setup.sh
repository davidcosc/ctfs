#!/bin/bash
set -e
echo "Update and upgrade deps ......"
apt update && apt upgrade -y
echo "Update and upgrade deps ..[ok]"
echo "Install python3 ......"
apt install python3 -y
python3 --version
echo "Install python3 ..[ok]"
echo "Install pip3 ......"
apt install python3-pip -y
pip3 --version
echo "Install pip3 ..[ok]"
echo "Install python3 pwntools ......"
pip3 install pwntools
echo "Install python3 pwntools ..[ok]"
echo "Install patchelf ......"
apt install patchelf -y
echo "Install patchelf ..[ok]"
echo "Install elfutils ......"
apt install elfutils -y
echo "Install elfutils ..[ok]"
echo "Install pwninit ......"
FILE="./pwninit"
if test -f "${FILE}"; then
  echo "Install pwninit ..[ok]"
else
  wget "https://github.com/io12/pwninit/releases/download/3.3.1/pwninit"
  chmod +x "./pwninit"
  echo "Install pwninit ..[ok]"
fi
echo "Install git ......"
apt install git -y
echo "Install git ..[ok]"
echo "Install pwndbg ......"
FILE="./pwndbg"
if test -d "${FILE}"; then
  echo "Install pwndbg ..[ok]"
else
  git clone https://github.com/pwndbg/pwndbg
  cd pwndbg
  chmod +x ./setup.sh
  ./setup.sh
  cd ..
  echo "Install pwndbg ..[ok]"
fi
