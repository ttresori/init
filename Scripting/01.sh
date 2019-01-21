cat /etc/passwd | awk -F ":" '{print "login: "$1 " UID: "$3 " PATH: "$6 $7}'
