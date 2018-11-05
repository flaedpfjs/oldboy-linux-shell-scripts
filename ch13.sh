[root@oldboy C13]# for n in `ls *.sh`;do echo;echo;echo "[root@oldboy C13]# cat $n";cat $n;done 
 
 
[root@oldboy C13]# cat 10_7_2.sh
#!/bin/bash
# this script is created by oldboy.
# e_mail:31333741@qq.com
# function:case example
# version:1.3
. /etc/init.d/functions
check_count=0
url_list=(
http://blog.oldboyedu.com
http://blog.etiantian.org
http://oldboy.blog.51cto.com
http://10.0.0.7
)
 
function wait()
{
echo -n '3秒後,執行檢查URL操作.';
for ((i=0;i<3;i++))
do
  echo -n ".";sleep 1
done
echo
}
function check_url()
{
wait
for ((i=0; i<`echo ${#url_list[*]}`; i++))
do
wget -o /dev/null -T 3 --tries=1 --spider ${url_list[$i]} >/dev/null 2>&1
if [ $? -eq 0 ]
 then
   action "${url_list[$i]}" /bin/true
else
   action "${url_list[$i]}" /bin/false
fi
done
 ((check_count++))
}
main(){
while true
do
 check_url
 echo "-------check count:${check_count}---------"
 sleep 7
done
}
main
 
 
[root@oldboy C13]# cat 13_1_1.sh
#!/bin/sh
array=(1 2 3 4 5)
for((i=0;i<${#array[*]};i++))
do
   echo ${array[i]}
done
 
 
[root@oldboy C13]# cat 13_1_2.sh
#!/bin/sh
array=(1 2 3 4 5)
for n in ${array[*]}
do
   echo $n
done
 
 
[root@oldboy C13]# cat 13_1_3.sh
#!/bin/sh
array=(1 2 3 4 5)
i=0
while ((i<${#array[*]}))
do
   echo ${array[i]}
   ((i++))
done
 
 
[root@oldboy C13]# cat 13_2_1.sh
#!/bin/sh
array=(
 oldboy
 oldgirl
 xiaoting
 bingbing
)
for ((i=0; i<${#array[*]}; i++))
do
   echo "This is num $i,then content is ${array[$i]}"
done
echo ----------------------
echo "array len:${#array[*]}"
 
 
[root@oldboy C13]# cat 13_3_1.sh
#!/bin/bash
dir=($(ls /array))
for ((i=0; i<${#dir[*]}; i++))
do
   echo "This is NO.$i,filename is ${dir[$i]}"
done
 
 
 
[root@oldboy C13]# cat 13_4_1.sh
arr=(I am oldboy teacher welcome to oldboy training class)
for ((i=0;i<${#arr[*]};i++))
do 
    if [ ${#arr[$i]} -lt 6 ]
     then
        echo "${arr[$i]}"
    fi
done
echo -----------------------
for word in ${arr[*]}
do
    if [ `expr length $word` -lt 6 ];then
       echo $word
    fi
done
 
echo ------------------------
for word in I am oldboy teacher welcome to oldboy training class
do
    if [ `echo $word|wc -L` -lt 6 ];then
       echo $word
    fi
done
 
 
chars="I am oldboy teacher welcome to oldboy training class"
for word in $chars
do
    if [ `echo $word|wc -L` -lt 6 ];then
       echo $word
    fi
done
echo ------------------------
chars="I am oldboy teacher welcome to oldboy training class"
echo $chars|awk '{for(i=1;i<=NF;i++) if(length($i)<=6)print $i}'
 
 
[root@oldboy C13]# cat 13_6_1.sh
count=0
status=($(awk -F ': ' '/_Running|_Behind/{print $NF}' slave.log))
for((i=0;i<${#status[*]};i++))
do
   if [ "${status[${i}]}" != "Yes" -a "${status[${i}]}" != "0" ]
     then
      let count+=1
   fi
done
if [ $count -ne 0 ];then
 echo "mysql replcation is failed"
else
 echo "mysql replcation is sucess"
fi
 
 
 
[root@oldboy C13]# cat 13_6_2.sh
#!/bin/bash
CheckDb(){
status=($(awk -F ': ' '/_Running|_Behind/{print $NF}' slave.log))
for((i=0;i<${#status[*]};i++))
do
   count=0
   if [ "${status[${i}]}" != "Yes" -a "${status[${i}]}" != "0" ]
     then
      let count+=1
   fi
done
if [ $count -ne 0 ];then
 echo "mysql replcation is failed"
 return 1
else
 echo "mysql replcation is sucess"
 return 0
fi
}
main(){
while true
do
  CheckDb
  sleep 3
done
}
main
 
 
[root@oldboy C13]# cat 13_6_3.sh
#!/bin/bash
###########################################
# this script function is :
# check_mysql_slave_replication_status
# USER        YYYY-MM-DD - ACTION
# oldboy      2009-02-16 - Created
############################################
path=/server/scripts
MAIL_GROUP="1111@qq.com 2222@qq.com"
PAGER_GROUP="18600338340 18911718229"
LOG_FILE="/tmp/web_check.log"
USER=root
PASSWORD=oldboy123
PORT=3307
MYSQLCMD="mysql -u$USER -p$PASSWORD -S /data/$PORT/mysql.sock"
error=(1008 1007 1062)
RETVAL=0
[ ! -d $path ] && mkdir -p $path
 
function JudgeError(){
for((i=0;i<${#error[*]};i++))
do
  if [ "$1" == "${error[$i]}" ]
    then
      echo "MySQL slave errorno is $1,auto repairing it."
      $MYSQLCMD -e "stop slave;set global sql_slave_skip_counter=1;start slave;"
  fi
done
return $1
}
 
function CheckDb(){
status=($(awk -F ': ' '/_Running|Last_Errno|_Behind/{print $NF}' slave.log))
 expr ${status[3]} + 1 &>/dev/null
 if [ $? -ne 0 ];then
    status[3]=300
 fi
 if [ "${status[0]}" == "Yes" -a "${status[1]}" == "Yes" -a ${status[3]} -lt 120 ]
  then
    #echo "Mysql slave status is ok"
    return 0
  else
    #echo "mysql replcation is failed"
    JudgeError ${status[2]}
  fi
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
  if [ $1 -ne 0 ]
    then 
       RETVAL=1
       NOW_TIME=`date +"%Y-%m-%d %H:%M:%S"`
       SUBJECT_CONTENT="mysql slave is error,errorno is $2,${NOW_TIME}."
       echo -e "$SUBJECT_CONTENT"|tee $LOG_FILE
       MAIL $SUBJECT_CONTENT
       PAGER $SUBJECT_CONTENT $NOW_TIME
  else
      echo "Mysql slave status is ok"
      RETVAL=0
  fi
  return $RETVAL
}
function main(){
while true
do
   CheckDb
   SendMsg $? 
   sleep 300
done
}
main