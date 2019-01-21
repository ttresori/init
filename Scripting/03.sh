#!/bin/bash
heure=0 ; minutes=0 ; maxheure=23 ; maxminutes=59 ; valid=1 ; shell_env="/bin/bash"
while [ $valid -ne 2 ]
do
    echo "Choisis une heure d'execution :" 
    read heure
    echo "Choisis la/les minute/s :"
    read minutes
    if [ $heure -gt $maxheure ]
    then
	echo "Pas possible, il n'ya que 24 heure dans une journee"
    else
	valid=2
    fi
    if [ $minutes -gt $maxminutes ]
    then
	echo "Pas possible, il n'ya que $maxminutes dans une heure"
	valid=1
    fi
    if [ $heure -lt "0" ]
    then
	echo "Pas possible, il n'ya pas heure negative dans une journee"
	valid=1
    fi
    if [ $minutes -lt "0" ]
    then
	echo "Pas possible, il n'ya pas de minutes negative dans une heure"
	valid=1
    fi
    if [ $heure -gt $maxheure ]
    then
	echo "Pas possible, il n'ya que 24 heure dans une journee"
    else
       valid=2
    fi
done
if [ $heure -lt "10" ]
then
   echo -n "0"$heure"h"
else
    echo -n ""$heure"h"
fi
if [ $minutes -lt "10" ]
then
    echo -n "0"$minutes""
else
    echo -n ""$minutes""
fi
read -p " te convient (y/n)?" yn
case $yn in
    [Yy]* ) echo "OK";;
    [Nn]* ) echo "Restart the script so"; exit;;
esac
echo "commande a executer"
read command
shell_env=`env | grep SHELL | cut -d "=" -f 2`
echo $command >> /home/$USER/Documents/init/Scripting/.command_to_exec.sh
chmod +x .command_to_exec.sh
echo ""$minutes" "$heure"   * * * exec $shell_env /home/$USER/Documents/init/Scripting/.command_to_exec.sh" >> .my_crontab
crontab .my_crontab
rm .my_crontab
/etc/init.d/cron reload
/etc/init.d/cron restart
