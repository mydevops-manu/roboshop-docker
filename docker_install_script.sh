
#!/bin/bash

ID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

TIMESTAMP=$(date +%F-%H-%M-%S)
LOGFILE="/tmp/$0-$TIMESTAMP.log"

echo "script stared at $TIMESTAMP" 
echo "script stared at $TIMESTAMP" &>> $LOGFILE       

echo "checking root access..."       

#######################    CHECKING ROOT ACCESSS   #########################
if [ $ID -ne 0 ]
then
    echo -e "$R ERROR $N:: Please run script with root access" &>> $LOGFILE       
    exit 1
else
    echo "Root access confirmed..." &>> $LOGFILE       
    echo "Installing..." &>> $LOGFILE      
fi
#######################   CHECKING ROOT ACCESSS COMPLETED   ################


#################    CHECKING INSTALLATIONS SUCESSS OR FAIL   ##############

CHECK(){

    if [ $1 -ne 0 ]
    then
        echo -e "ERROR:: $2 $R failed $N" &>> $LOGFILE       
        exit 1
    else
        echo -e "$2 $G Success $N" &>> $LOGFILE              
    fi
}

yum install -y yum-utils
CHECK $? "copied utilities"

yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
CHECK $? "added repo and config manager"

yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
CHECK $? "Installed docker client"

systemctl start docker
CHECK $? "docker serviced started"

echo "docker is installed and running..."
