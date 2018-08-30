#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

#=================================================================#
#   System Required:  CentOS                                      #
#   Description: One click Install JDK                 #
#   Author: bowen                                                 #
#==================================================================

clear
echo
echo "#############################################################"
echo "# One click Install JDK                                     #"
echo "# Author: bowen                                             #"
echo "#############################################################"
echo

# Current folder
cur_dir=`pwd`

#Java home
JAVA_HOME=''

#Java dir
JAVA=''

# Color
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'

# Make sure only root can run our script
[[ $EUID -ne 0 ]] && echo -e "[${red}Error${plain}] This script must be run as root!" && exit 1

# is 64bit or not
is_64bit(){
    if [ `getconf WORD_BIT` = '32' ] && [ `getconf LONG_BIT` = '64' ] ; then
        return 0
    else
        return 1
    fi
}

#mkdir java 
mkdir_java_home(){
  if [ ! -d /usr/local/java ]; then
    echo "mkdir java "
    mkdir /usr/local/java
    cd /usr/local/java
    JAVA=`pwd`
  fi
}

# Download jdk
download_files(){  
  echo "download jdk-8u181-linux-x64.tar.gz"
  cd ${JAVA} 
  if ! wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jdk-8u181-linux-x64.tar.gz; then
    echo -e "[${red}Error${plain}] Failed to download jdk-8u181-linux-x64.tar.gz"
    exit 1
  fi
  tar -zxvf jdk-8u181-linux-x64.tar.gz
  if [ $? -ne 0 ]; then
    echo -e "[${red}Error${plain}] Decompress jdk-8u181-linux-x64.tar.gz failed"
    exit 1
  fi
  cd jdk1.8.0_181
  JAVA_HOME=`pwd`
  echo "java home is ${JAVA_HOME}"
}

#configuration environment variable
env_var(){
  echo "configuration environment variable"
  echo "JAVA_HOME=${JAVA_HOME}" >> ~/.bashrc
  echo "PATH=$PATH:$JAVA_HOME/bin" >> ~/.bashrc
  echo "export JAVA_HOME PATH" >> ~/.bashrc
  source ~/.bashrc
}

install_jdk(){
  mkdir_java_home
  download_files
  env_var
}

# Initialization step
action=$1
[ -z $1 ] && action=install
case "$action" in
    install|uninstall)
        ${action}_jdk
        ;;
    *)
        echo "Arguments error! [${action}]"
        echo "Usage: `basename $0` [install|uninstall]"
        ;;
esac