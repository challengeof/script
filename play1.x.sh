#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

#=================================================================#
#   System Required:  CentOS                                      #
#   Description: One click Install play 1.x                       #
#   Author: bowen                                                 #
#==================================================================

clear
echo
echo "#############################################################"
echo "# One click Install paly 1.x                                #"
echo "# Author: bowen                                             #"
echo "#############################################################"
echo

# Current folder
cur_dir=`pwd`

#Java home
PLAY_HOME=''

#Java dir
PLAY=''

# Color
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'

# Make sure only root can run our script
[[ $EUID -ne 0 ]] && echo -e "[${red}Error${plain}] This script must be run as root!" && exit 1


#mkdir play 
mkdir_play_home(){
  if [ ! -d /usr/local/play ]; then
    echo "mkdir play "
    mkdir /usr/local/play
    cd /usr/local/play
    PLAY=`pwd`
  fi
}

# Download play
download_files(){  
  echo "download play-1.4.4.zip"
  cd ${PLAY} 
  if ! wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" https://downloads.typesafe.com/play/1.4.4/play-1.4.4.zip; then
    echo -e "[${red}Error${plain}] Failed to download play-1.4.4.zip"
    exit 1
  fi
  unzip -o play-1.4.4.zip
  if [ $? -ne 0 ]; then
    echo -e "[${red}Error${plain}] Decompress play-1.4.4.zip failed"
    exit 1
  fi
  cd play-1.4.4
  PLAY_HOME=`pwd`
  echo "play home is ${PLAY_HOME}"
}

#configuration environment variable
env_var(){
  echo "configuration environment variable"
  echo "export PATH=\$PATH:${PLAY_HOME}" >> ~/.bashrc
  source ~/.bashrc
}

install_play(){
  mkdir_play_home
  download_files
  env_var
}

# Initialization step
action=$1
[ -z $1 ] && action=install
case "$action" in
    install|uninstall)
        ${action}_play
        ;;
    *)
        echo "Arguments error! [${action}]"
        echo "Usage: `basename $0` [install|uninstall]"
        ;;
esac