[root@oldboy C11]# for n in `ls *|sort -t_ -n -k2`;do echo;echo;echo "[root@oldboy C11]# cat $n";cat $n;done
 
 
[root@oldboy C11]# cat 11_1_1.sh
for ((i=1;i<=3;i++))
do
    echo $i
done
 
 
 
[root@oldboy C11]# cat 11_1_2.sh
i=1
while ((i<=3))
do
   echo $i
   ((i++))
done
 
 
[root@oldboy C11]# cat 11_2_1.sh
for num in 5 4 3 2 1
do
    echo $num
done
 
 
[root@oldboy C11]# cat 11_2_2.sh
for n in {5..1}
do
  echo $n
done
 
 
[root@oldboy C11]# cat 11_2_3.sh
for n in `seq 5 -1 1`
do
    echo $n
done
 
 
[root@oldboy C11]# cat 11_3_1.sh
cd /test
for filename in `ls`
do
    echo $filename
done
 
 
 
[root@oldboy C11]# cat 11_4_1.sh
#!/bin/sh
cd /test
for filename in `ls|grep "txt$"`
do
   mv $filename `echo $filename|cut -d . -f1`.gif
done
 
 
[root@oldboy C11]# cat 11_5_1.sh
#!/bin/sh
cd /oldboy
for file in `ls *.jpg`  
do
  mv $file `echo $file|sed 's/_finished//g'` 
done
 
 
[root@oldboy C11]# cat 11_8_1.sh
#!/bin/bash  
#!/bin/sh
GREEN_COLOR='\E[47;30m'
RES='\E[0m'
 
for num1 in `seq 9`
do
  for num2 in `seq 9`
  do
    if [ $num1 -ge $num2 ]
      then
        if (((num1*num2)>9))
          then
            echo -en "${GREEN_COLOR}${num1}x${num2}=$((num1*num2))$RES "
          else
            echo -en "${GREEN_COLOR}${num1}x${num2}=$((num1*num2))$RES  "
        fi
    fi
  done
echo
done
 
 
[root@oldboy C11]# cat 11_11_1.sh
#!/bin/sh
MYUSER=root
MYPASS=oldboy123
SOCKET=/data/3306/mysql.sock
MYCMD="mysql -u$MYUSER -p$MYPASS -S $SOCKET"
for dbname in oldboy oldgirl xiaoting bingbing
do
   
  $MYCMD -e "drop database $dbname;create database $dbname"
done
 
 
[root@oldboy C11]# cat 11_11_2.sh
#!/bin/sh
DBPATH=/server/backup
MYUSER=root
MYPASS=oldboy123
SOCKET=/data/3306/mysql.sock
MYCMD="mysql -u$MYUSER -p$MYPASS -S $SOCKET"
MYDUMP="mysqldump -u$MYUSER -p$MYPASS -S $SOCKET"
[ ! -d $DBPATH ] && mkdir $DBPATH
for dbname in `$MYCMD -e "show databases;"|sed '1,2d'|egrep -v "mysql|schema"`
do
  $MYDUMP $dbname|gzip >$DBPATH/${dbname}_$(date +%F).sql.gz
done
 
 
 
[root@oldboy C11]# cat 11_12_1.sh
#!/bin/sh
MYUSER=root
MYPASS=oldboy123
SOCKET=/data/3306/mysql.sock
MYCMD="mysql -u$MYUSER -p$MYPASS -S $SOCKET"
for dbname in oldboy oldgirl xiaoting bingbing
do
  $MYCMD -e "use $dbname;create table test(id int,name varchar(16));insert into test values(1,'testdata');"
done
 
 
[root@oldboy C11]# cat 11_12_2.sh
#!/bin/sh
MYUSER=root
MYPASS=oldboy123
SOCKET=/data/3306/mysql.sock
MYCMD="mysql -u$MYUSER -p$MYPASS -S $SOCKET"
for dbname in oldboy oldgirl xiaoting bingbing
do
  echo ===============${dbname}.test====================
  $MYCMD -e "use $dbname;select * from ${dbname}.test;"
done
 
 
[root@oldboy C11]# cat 11_12_3.sh
#!/bin/sh
DBPATH=/server/backup
MYUSER=root
MYPASS=oldboy123
SOCKET=/data/3306/mysql.sock
MYCMD="mysql -u$MYUSER -p$MYPASS -S $SOCKET"
MYDUMP="mysqldump -u$MYUSER -p$MYPASS -S $SOCKET"
[ ! -d $DBPATH ] && mkdir -p $DBPATH
for dbname in `$MYCMD -e "show databases;"|sed '1,2d'|egrep -v "mysql|schema"`
do
   mkdir $DBPATH/${dbname}_$(date +%F) -p
   for table in `$MYCMD -e "show tables from $dbname;"|sed '1d'`
   do
    $MYDUMP $dbname $table|gzip >$DBPATH/${dbname}_$(date +%F)/${dbname}_${table}.sql.gz
   done
done
 
 
[root@oldboy C11]# cat 11_13_1.sh
#!/bin/bash
path=/server/scripts
MAIL_GROUP="1111@qq.com 2222@qq.com"
PAGER_GROUP="18600338340 18911718229"
LOG_FILE="/tmp/web_check.log"
 
[ ! -d $path ] && mkdir -p $path
function UrlList(){
cat >$path/domain.list<<EOF
http://blog.oldboyedu.com
http://oldboy.blog.51cto.com
http://10.0.0.7
http://www.baidu.com
EOF
}
 
function CheckUrl(){
FAILCOUNT=0
for ((i=1;$i<=3;i++)) 
 do 
    wget -T 5 --tries=1 --spider $1 >/dev/null 2>&1
    if [ $? -ne 0 ]
      then
        let FAILCOUNT+=1;
    else
      break
    fi
done
return $FAILCOUNT
}
 
function MAIL(){
local SUBJECT_CONTENT=$1
for MAIL_USER  in `echo $MAIL_GROUP`
 do
    mail -s "$SUBJECT_CONTENT " $MAIL_USER <$LOG_FILE
done
}
function PAGER(){
for PAGER_USER  in `echo $PAGER_GROUP`
do
 TITLE=$1   
 CONTACT=$PAGER_USER
 HTTPGW=http://oldboy.sms.cn/smsproxy/sendsms.action
 #send_message method1
 curl -d  cdkey=5ADF-EFA -d password=OLDBOY -d phone=$CONTACT -d message="$TITLE[$2]" $HTTPGW
done
}
function SendMsg(){
  if [ $1 -ge 3 ]
    then 
       RETVAL=1
       NOW_TIME=`date +"%Y-%m-%d %H:%M:%S"`
       SUBJECT_CONTENT="http://$2 is error,${NOW_TIME}."
       echo -e "$SUBJECT_CONTENT"|tee $LOG_FILE
       MAIL $SUBJECT_CONTENT
       PAGER $SUBJECT_CONTENT $NOW_TIME
  else
      echo "http://$2 is ok"
      RETVAL=0
  fi
  return $RETVAL
}
function main(){
UrlList
for url in `cat $path/domain.list`
  do
   CheckUrl $url
   SendMsg $? $url
done
}
main
 
 
[root@oldboy C11]# cat 11_14_1.sh
#!/bin/sh
#author:oldboy
#blog:http://oldboy.blog.51cto.com
user="oldboy"
passfile="/tmp/user.log"
for num in `seq -w 10`
 do
   useradd $user$num
   pass="`echo "test$RANDOM"|md5sum|cut -c3-11`"
   echo "$pass"|passwd --stdin $user$num
   echo  -e "user:$user$num\tpasswd:$pass">>$passfile
done
echo ------this is oldboy trainning class contents----------------
cat $passfile
 
 
[root@oldboy C11]# cat 11_14_2.sh
#!/bin/sh
#author:oldboy
#blog:http://oldboy.blog.51cto.com
. /etc/init.d/functions
user="oldboy"
passfile="/tmp/user.log"
for num in `seq -w 11 15`
 do
   pass="`echo "test$RANDOM"|md5sum|cut -c3-11`"
   useradd $user$num &>/dev/null &&\
   echo "$pass"|passwd --stdin $user$num &>/dev/null &&\
   echo  -e "user:$user$num\tpasswd:$pass">>$passfile
   if [ $? -eq 0 ]
    then
      action "$user$num is ok" /bin/true
    else
      action "$user$num is fail" /bin/false
    fi
done
echo ----------------------
cat $passfile && >$passfile
 
 
[root@oldboy C11]# cat 11_14_3.sh
#!/bin/sh
#author:oldboy
#blog:http://oldboy.blog.51cto.com
. /etc/init.d/functions
user="xiaoting"
passfile="/tmp/user.log"
for num in `seq -w 10`
 do
   pass="`echo "test$RANDOM"|md5sum|cut -c3-11`"
   useradd $user$num &>/dev/null &&\
   echo  -e "$user${num}:$pass">>$passfile
   if [ $? -eq 0 ]
    then
      action "$user$num is ok" /bin/true
    else
      action "$user$num is fail" /bin/false
    fi
done
echo ----------------------
chpasswd < $passfile 
cat $passfile && >$passfile三