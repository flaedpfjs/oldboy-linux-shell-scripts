[root@oldboy C07]# cat 7_1.sh
#!/bin/bash
if [ -f /etc/hosts ]
  then 
    echo "[1]"
fi
 
if [[ -f /etc/hosts ]]
  then
    echo "`1`"
fi
 
if test -f /etc/hosts
  then
    echo "test1"
fi
 
 
[root@oldboy C07]# cat 7_2.sh
#!/bin/bash
FreeMem=`free -m|awk 'NR==3 {print $NF}'`
CHARS="Current memory is  $FreeMem."
if [ $FreeMem -lt 1000 ]
  then
    echo $CHARS|tee /tmp/messages.txt
    #mail -s "`date +%F-%T`$CHARS" 490004487@qq.com </tmp/messages.txt
fi
 
 
if (($FreeMem<1000))
  then
    echo $CHARS|tee /tmp/messages.txt
    #mail -s "`date +%F-%T`$CHARS" 490004487@qq.com </tmp/messages.txt
fi
 
if [[ $FreeMem -lt 1000 ]]
  then
    echo $CHARS|tee /tmp/messages.txt
    #mail -s "`date +%F-%T`$CHARS" 490004487@qq.com </tmp/messages.txt
fi
 
if test $FreeMem -lt 1000 
  then
    echo $CHARS|tee /tmp/messages.txt
    #mail -s "`date +%F-%T`$CHARS" 490004487@qq.com </tmp/messages.txt
fi
 
 
 
[root@oldboy C07]# cat 7_3_1.sh
#!/bin/sh
read -p "pls input two num:" a b
if [ $a -lt $b ];then
    echo "yes,$a less than $b"
    exit 0
fi
if [ $a -eq $b ];then
    echo "yes,$a equal $b"
    exit 0
fi
if [ $a -gt $b ];then
    echo "yes,$a greater than $b"
    exit 0
fi
 
 
[root@oldboy C07]# cat 7_3_2.sh
#!/bin/sh
read -p "pls input two num:" a b
if [ $a -lt $b ];then
    echo "yes,$a less than $b"
elif [ $a -eq $b ];then
    echo "yes,$a equal $b"
else [ $a -gt $b ]
    echo "yes,$a greater than $b"
fi
 
 
[root@oldboy C07]# cat 7_3_3.sh
#!/bin/sh
a=$1
b=$2
#read -p "pls input two num:" a b
if [ $a -lt $b ];then
    echo "yes,$a less than $b"
    exit 0
fi
if [ $a -eq $b ];then
    echo "yes,$a equal $b"
    exit 0
fi
if [ $a -gt $b ];then
    echo "yes,$a greater than $b"
    exit 0
fi
 
 
[root@oldboy C07]# cat 7_3_4.sh
#!/bin/sh
a=$1
b=$2
#read -p "pls input two num:" a b
if [ $a -lt $b ];then
    echo "yes,$a less than $b"
elif [ $a -eq $b ];then
    echo "yes,$a equal $b"
else [ $a -gt $b ]
    echo "yes,$a greater than $b"
fi
 
 
[root@oldboy C07]# cat 7_4_1.sh
#!/bin/sh
echo method1-------------------
if [ `netstat -lnt|grep 3306|awk -F "[ :]+" '{print $5}'` -eq 3306 ]
then
    echo "MySQL is Running."
else
    echo "MySQL is Stopped."
    /etc/init.d/mysqld start
fi
echo method2-------------------
if [ "`netstat -lnt|grep 3306|awk -F "[ :]+" '{print $5}'`" = "3306" ]
then
    echo "MySQL is Running."
else
    echo "MySQL is Stopped."
    /etc/init.d/mysqld start
fi
 
echo method3-------------------
if [ `netstat -lntup|grep mysqld|wc -l` -gt 0 ]
then
    echo "MySQL is Running."
else
    echo "MySQL is Stopped."
    /etc/init.d/mysqld start
fi
echo method4-------------------
if [ `lsof -i tcp:3306|wc -l` -gt 0 ]
then
    echo "MySQL is Running."
else
    echo "MySQL is Stopped."
    /etc/init.d/mysqld start
fi
echo method5-------------------
[ `rpm -qa nmap|wc -l` -lt 1 ] && yum install nmap -y &>/dev/null
if [ `nmap 127.0.0.1 -p 3306 2>/dev/null|grep open|wc -l` -gt 0 ]
  then
    echo "MySQL is Running."
else
    echo "MySQL is Stopped."
    /etc/init.d/mysqld start
fi
echo method6-------------------
[ `rpm -qa nc|wc -l` -lt 1 ] && yum install nc -y &>/dev/null
if [ `nc -w 2  127.0.0.1 3306 &>/dev/null&&echo ok|grep ok|wc -l` -gt 0 ]
  then
    echo "MySQL is Running."
else
    echo "MySQL is Stopped."
    /etc/init.d/mysqld start
fi
echo method7-------------------
if [ `ps -ef|grep -v grep|grep mysql|wc -l` -ge 1 ]
  then
    echo "MySQL is Running."
else
    echo "MySQL is Stopped."
    /etc/init.d/mysqld start
fi
 
 
[root@oldboy C07]# cat 7_4_2.sh
#!/bin/sh
echo http method1-------------------
if [ `netstat -lnt|grep 80|awk -F "[ :]+" '{print $5}'` -eq 80 ]
  then
    echo "Nginx is Running."
else
    echo "Nginx is Stopped."
    /etc/init.d/nginx start
fi
echo http method2-------------------
if [ "`netstat -lnt|grep 80|awk -F "[ :]+" '{print $5}'`" = "80" ]
  then
    echo "Nginx is Running."
else
    echo "Nginx is Stopped."
    /etc/init.d/nginx start
fi
 
 
 
echo http method3-------------------
if [ `netstat -lntup|grep nginx|wc -l` -gt 0 ]
  then
    echo "Nginx is Running."
else
    echo "Nginx is Stopped."
    /etc/init.d/nginx start
fi
echo http method4-------------------
if [ `lsof -i tcp:80|wc -l` -gt 0 ]
  then
    echo "Nginx is Running."
else
    echo "Nginx is Stopped."
    /etc/init.d/nginx start
fi
echo http method5-------------------
[ `rpm -qa nmap|wc -l` -lt 1 ] && yum install nmap -y &>/dev/null
if [ `nmap 127.0.0.1 -p 80 2>/dev/null|grep open|wc -l` -gt 0 ]
  then
    echo "Nginx is Running."
else
    echo "Nginx is Stopped."
    /etc/init.d/nginx start
fi
echo http method6-------------------
[ `rpm -qa nc|wc -l` -lt 1 ] && yum install nc -y &>/dev/null
if [ `nc -w 2  127.0.0.1 80 &>/dev/null&&echo ok|grep ok|wc -l` -gt 0 ]
  then
    echo "Nginx is Running."
else
    echo "Nginx is Stopped."
    /etc/init.d/nginx start
fi
echo http method7-------------------
if [ `ps -ef|grep -v grep|grep nginx|wc -l` -ge 1 ]
  then
    echo "Nginx is Running."
else
    echo "Nginx is Stopped."
    /etc/init.d/nginx start
fi
 
echo http method8-------------------
if [[ `curl -I -s -o /dev/null -w "%{http_code}\n" http://127.0.0.1` =~ [23]0[012] ]]
  then
    echo "Nginx is Running."
else
    echo "Nginx is Stopped."
    /etc/init.d/nginx start
fi
 
 
echo http method9-------------------
if [ `curl -I http://127.0.0.1 2>/dev/null|head -1|egrep "200|302|301"|wc -l` -eq 1  ]
  then
    echo "Nginx is Running."
else
    echo "Nginx is Stopped."
    /etc/init.d/nginx start
fi
echo http method10-------------------
if [ "`curl -s http://127.0.0.1`" = "oldboy"  ]
  then
    echo "Nginx is Running."
else
    echo "Nginx is Stopped."
    /etc/init.d/nginx start
fi
 
 
[root@oldboy C07]# cat 7_6.sh
#!/bin/bash
a=$1
b=$2
#no.1 judge arg nums.
if [ $# -ne 2 ];then
    echo "USAGE:$0 arg1 arg2"
    exit 2
fi
 
#no.2 judge if int
expr $a + 1 &>/dev/null
RETVAL1=$?
expr $b + 1 &>/dev/null
RETVAL2=$?
if [ $RETVAL1 -ne 0 -a $RETVAL2 -ne 0 ];then
    echo "please input two int again"
    exit 3
fi
 
if [ $RETVAL1 -ne 0 ];then
    echo "The first num is not int,please input again"
    exit 4
fi
 
if [ $RETVAL2 -ne 0 ];then
    echo "The second num is not int,please input again"
    exit 5
fi
 
#no.3 compart two num.
if [ $a -lt $b ];then
    echo "$a<$b"
elif [ $a -eq $b ];then
    echo "$a=$b"
else
    echo "$a>$b"
fi
 
 
[root@oldboy C07]# cat 7_9.sh
#!/bin/sh
if [ $# -ne 1 ]
  then
    echo $"usage:$0{start|stop|restart}"
    exit 1
fi
if [ "$1" = "start" ]
  then
     rsync --daemon
     if [ `netstat -lntup|grep rsync|wc -l` -ge 1 ]
       then
         echo "rsyncd is started."
         exit 0
     fi
elif [ "$1" = "stop" ]
  then
    pkill rsync
    if [ `netstat -lntup|grep rsync|wc -l` -eq 0 ]
      then
        echo "rsyncd is stopped."
        exit 0
    fi
elif [ "$1" = "restart" ]
  then
    pkill rsync
    sleep 2
    rsync --daemon
else
    echo $"usage:$0{start|stop|restart}"
    exit 1
fi