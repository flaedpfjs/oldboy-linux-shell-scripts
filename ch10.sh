[root@oldboy C10]# for n in `ls *|sort -t"_" -n -k2`;do echo;echo;echo "[root@oldboy C11]# cat $n";cat $n;done
 
 
[root@oldboy C11]# cat 10_1_2.sh
#!/bin/sh
while [ 1 ]
 do
  uptime >>/tmp/uptime.log
  usleep 2000000
done
 
 
 
[root@oldboy C11]# cat 10_1.sh
#!/bin/sh
while true
 do
  uptime
  sleep 2
done
 
 
 
[root@oldboy C11]# cat 10_2_1.sh
#!/bin/sh
i=5
while ((i>0))
 do
        echo  "$i"
        ((i--))
done
 
 
[root@oldboy C11]# cat 10_2_4.sh
#!/bin/sh
i=5
until [[ $i < 6 ]]
    do
      echo $i
      ((i--))
done
 
 
 
[root@oldboy C11]# cat 10_3_1.sh
#!/bin/bash
# this script is created by oldboy.
i=1
sum=0
while ((i<=100 ))
do
   ((sum=sum+i))
   ((i++))
done
[ "$sum" -ne 0 ] && printf "totalsum is: $sum\n"
 
 
[root@oldboy C11]# cat 10_3_2.sh
#!/bin/sh
i=100
((sum=i*(i+1)/2))
echo $sum
 
 
[root@oldboy C11]# cat 10_4_1.sh
#!/bin/bash
total=0
export LANG="zh_CN.UTF-8"
NUM=$((RANDOM%61))
echo "當前蘋果價格是每斤$NUM元"
echo "========================"
usleep 1000000
clear
echo '這蘋果多少錢一斤啊？
      請猜0-60的數字'
apple(){
read -p "請輸入你的價格：" PRICE
expr $PRICE + 1 &>/dev/null
if [ $? -ne 0 ]
 then
        echo "別逗我了，快猜數字"
        apple
fi
}
 
guess(){
        ((total++))
        if [ $PRICE -eq $NUM ]
         then
                echo "猜對了，就是$NUM元"
                if [ $total -le 3 ];then
                   echo "一共猜了$total次，太牛了。"
                elif [ $total -gt 3 -a $total -le 6 ];then
                   echo "一共猜了$total次，次數有點多，加油啊。"
                elif [ $total -gt 6 ];then
                   echo "一共猜了$total次，行不行，猜了這多次"
                fi
                exit 0
         elif [ $PRICE -gt $NUM ]
          then
                echo "嘿嘿，要不你用這個價買？"
                echo "再給你一次機會，請繼續猜："
                apple
         elif [ $PRICE -lt $NUM ]
          then
                echo "太低太低"
                echo "再給你一次機會，請繼續猜："
                apple
         fi
}
main(){
apple
while true
do
  guess
done
}
main
 
 
[root@oldboy C11]# cat 10_5_1.sh
#!/bin/sh
export LANG="zh_CN.UTF-8"
sum=15
msg_fee=15
msg_count=0
menu(){
    cat <<END
當前餘額為${sum}分，每條短信需要${msg_fee}分
==========================
      1.充值
      2.發消息
      3.退出
==========================
END
}
recharge(){
    read -p "請輸入金額充值:" money
        expr $money + 1 &>/dev/null 
        if [ $? -ne 0 ]
           then
               echo "then money your input is error,must be int."
           else 
               sum=$(($sum+$money))
               echo "當前餘額為:$sum"
        fi
}
sendInfo(){
    if [ ${sum} -lt $msg_fee ]
       then
            printf "餘額不足：$sum ，請充值。\n"
       else 
            while true 
              do
                 read -p "請輸入短信內容(不能有空格):" msg
                 sum=$(($sum-$msg_fee))
                 printf "Send "$msg" successfully!\n"
                 printf "當前餘額為： $sum\n"
                 if [ $sum -lt 15 ]
                    then
                        printf "餘額不足，剩餘$sum分\n"
                        return 
                 fi
            done
    fi
}
main(){
while true
do
   menu
   read -p "請輸入數字選擇：" num
   case "$num" in
       1)
         recharge
         ;;
       2)
         sendInfo
         ;;
       3)
         exit 
         ;;
       *)
        printf "選擇錯誤，必須是{1|2|3}\n"
   esac
done
}
main
 
 
[root@oldboy C11]# cat 10_5_2.sh
#!/bin/sh
TOTAL=500
MSG_FEE=499
. /etc/init.d/functions
 
function IS_NUM(){
    expr $1 + 1 &>/dev/null
    if [ $? -ne 0 -a "$1" != "-1" ];then
        return 1
    fi
    return 0
}
 
function color(){
RED_COLOR='\E[1;31m'
YELLOW_COLOR='\E[1;33m'
BLUE_COLOR='\E[1;34m'
PINK='\E[1;35m'
RES='\E[0m'
if [ $# -ne 2 ];then
   echo "Usage $0 content {red|yellow|blue|green}"
   exit
fi
case "$2" in
  red|RED)
         echo -e  "${RED_COLOR}$1${RES}"
         ;;
  yellow|YELLOW)
         echo -e  "${YELLOW_COLOR}$1${RES}"
         ;;
   green|GREEN)
         echo -e  "${GREEN_COLOR}$1${RES}"
         ;;
   blue|BLUE)
         echo -e  "${BLUE_COLOR}$1${RES}"
         ;;
   pink|PINK)
         echo -e  "${PINK_COLOR}$1${RES}"
         ;;
   *)
         echo "Usage $0 content {red|yellow|blue|green}"
         exit
esac
}
 
function consum(){
    color "You have left $TOTAL money,Send a msg need to charge $MSG_FEE money" yellow
    if [ $TOTAL -lt $MSG_FEE ];then
    charge
    fi
    read -p "Pls input your msg:" TXT
    read -p "Are you to send?[y|n]" OPTION
    case $OPTION in
        [yY]|[yY][eE][sS])
                color "Send "$TXT" successfully!" yellow
                echo $TXT >>/tmp/consum.log
                ((TOTAL=TOTAL-MSG_FEE))
                color "Your have $TOTAL left!" yellow
                ;;
        [nN]|[nN][oO])
                echo "Canceled"
                ;;
        *)
                echo "Invalid Input,this msg doesnt send out"
                ;;
    esac
}
 
 
function charge(){
        if [ $TOTAL -lt $MSG_FEE ];then
                color "Money is not enough,Are U want to charge?[y|n]" red
                read  OPT2
        case $OPT2 in
                y|Y)
                        while true
                        do
                                read -p "How much are you want to charge?[INT]" CHARGE
                                IS_NUM $CHARGE&&break||{
                                echo "INVALID INPUT" 
                                exit 100
                                }
                        done
                        ((TOTAL+=CHARGE)) && echo "you have $TOTAL money."
                        if [ $TOTAL -lt $MSG_FEE ];then
                          charge
                        fi
                        ;;
                n|N)
                        color "You have left $TOTAL money,can not send a msg,bye" red
                        ;;
                *)
                        charge
                        ;;
        esac
        fi
}
 
main(){
 while [ $TOTAL -ge $MSG_FEE ]
 do
  #color "You have left $TOTAL money" red
  consum
  charge
done
}
main
 
 
[root@oldboy C11]# cat 10_6_1.sh
#!/bin/sh
if [ $# -ne 1 ];then
   echo $"usage $0 url"
   exit 1
fi
while true
do
   if [ `curl -o /dev/null --connect-timeout 5 -s -w "%{http_code}"  $1|egrep -w "200|301|302"|wc -l` -ne 1 ]
     then
      echo "$1 is error."
      #echo "$1 is error."|mail -s "$1 is error." 31333741--@qq.com
   else
      echo "$1 is ok"
   fi
   sleep 10
done
 
 
 
[root@oldboy C11]# cat 10_7_1.sh
#!/bin/sh
. /etc/init.d/functions
if [ $# -ne 1 ];then
   echo $"usage $0 url"
   exit 1
fi
while true
do
   if [ `curl -o /dev/null --connect-timeout 5 -s -w "%{http_code}"  $1|egrep -w "200|301|302"|wc -l` -ne 1 ]
     then
      action "$1 is error." /bin/false
      #echo "$1 is error."|mail -s "$1 is error." 31333741--@qq.com
   else
      action "$1 is ok" /bin/true
   fi
   sleep 1
done
 
 
 
[root@oldboy C11]# cat 10_7_2.sh
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
 
 
[root@oldboy C11]# cat 10_8_1.sh
#!/bin/bash
sum=0
exec <$1
while read line
do
  size=`echo $line|awk '{print $10}'`
  expr $size + 1 &>/dev/null
  if [ $? -ne 0 ];then
   continue
  fi
  ((sum=sum+$size))
done
echo "${1}:total:${sum}bytes =`echo $((${sum}/1024))`KB"
 
 
 
[root@oldboy C11]# cat 10_9_1.sh
while read line
do
    echo $line
done<$1
 
 
 
[root@oldboy C11]# cat 10_10_1.sh
file=$1
while true
do
        awk '{print $1}' $1|grep -v "^$"|sort|uniq -c >/tmp/tmp.log
        exec </tmp/tmp.log
        while read line
        do
          ip=`echo $line|awk '{print $2}'`
          count=`echo $line|awk '{print $1}'`
            if [ $count -gt 3 ] && [ `iptables -L -n|grep "$ip"|wc -l` -lt 1 ]
             then
                iptables -I INPUT -s $ip -j DROP
                echo "$line is dropped" >>/tmp/droplist_$(date +%F).log
            fi
        done
        sleep 5
done
 
 
 
待測數據
[root@oldboy C11]# cat netstat.log
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address               Foreign Address             State      
tcp        0      0 0.0.0.0:80                  0.0.0.0:*                   LISTEN      
tcp        0      0 115.29.49.213:80            117.136.27.254:13779        SYN_RECV    
tcp        0      0 115.29.49.213:80            113.97.117.157:1847         SYN_RECV    
tcp        0      0 115.29.49.213:80            117.136.40.20:19594         SYN_RECV    
tcp        0      0 115.29.49.213:80            117.136.40.20:19595         SYN_RECV    
tcp        0      0 115.29.49.213:80            121.236.219.69:45363        SYN_RECV    
tcp        0      0 0.0.0.0:21                  0.0.0.0:*                   LISTEN      
tcp        0      0 0.0.0.0:22                  0.0.0.0:*                   LISTEN      
tcp        0      0 0.0.0.0:3306                0.0.0.0:*                   LISTEN      
tcp        0      0 115.29.49.213:80            123.163.178.32:3009         ESTABLISHED 
tcp        0      0 115.29.49.213:80            117.136.1.202:21158         TIME_WAIT   
tcp        0      0 115.29.49.213:80            220.191.224.154:48550       ESTABLISHED 
tcp        0      0 115.29.49.213:80            183.32.61.109:5600          ESTABLISHED 
tcp        0      0 115.29.49.213:80            27.17.23.22:51256           FIN_WAIT2   
tcp        0      0 115.29.49.213:80            218.242.161.183:50519       FIN_WAIT2   
tcp        0      0 115.29.49.213:80            223.104.12.101:49900        TIME_WAIT   
tcp        0      0 115.29.49.213:80            140.206.64.90:62291         TIME_WAIT   
tcp        0      0 115.29.49.213:80            120.237.97.10:54195         ESTABLISHED 
tcp        0      0 115.29.49.213:80            49.80.146.230:13453         FIN_WAIT2   
tcp        0      0 115.29.49.213:80            113.104.25.50:56714         FIN_WAIT2   
tcp        0      0 115.29.49.213:80            101.226.89.193:41639        ESTABLISHED 
tcp        0      0 115.29.49.213:80            119.147.225.185:58321       TIME_WAIT   
tcp        0      0 115.29.49.213:80            54.183.177.237:64129        TIME_WAIT   
tcp        0      0 115.29.49.213:80            120.198.202.48:41960        ESTABLISHED 
tcp        0      1 115.29.49.213:80            119.127.188.242:38843       FIN_WAIT1   
tcp        0      0 115.29.49.213:34081         223.4.9.70:80               TIME_WAIT   
tcp        0      0 115.29.49.213:80            58.223.4.14:46716           FIN_WAIT2   
tcp        0      0 115.29.49.213:80            122.90.74.255:12177         FIN_WAIT2   
tcp        0      0 115.29.49.213:80            59.53.166.165:62253         ESTABLISHED 
tcp        0      0 115.29.49.213:80            219.133.40.13:34113         ESTABLISHED 
tcp        0      0 115.29.49.213:80            222.175.140.230:29902       TIME_WAIT   
tcp        0      0 115.29.49.213:80            54.77.101.105:49967         TIME_WAIT   
tcp        0      0 115.29.49.213:80            54.207.37.100:63364         TIME_WAIT   
tcp        0      0 115.29.49.213:80            125.118.62.149:61840        FIN_WAIT2   
tcp        0      0 115.29.49.213:80            112.117.173.124:50367       ESTABLISHED 
tcp        0      0 115.29.49.213:80            120.194.52.156:2752         FIN_WAIT2   
tcp        0      0 115.29.49.213:80            114.106.68.5:54231          ESTABLISHED 
tcp        0      0 115.29.49.213:80            27.154.82.136:3013          FIN_WAIT2   
tcp        0      0 115.29.49.213:80            182.245.82.46:55306         FIN_WAIT2   
tcp        0      0 115.29.49.213:80            117.92.15.157:29926         TIME_WAIT   
tcp        0      0 115.29.49.213:80            163.179.63.118:62371        ESTABLISHED 
tcp        0    777 115.29.49.213:80            106.59.15.116:1673          ESTABLISHED 
tcp        0    777 115.29.49.213:80            117.22.215.8:1382           ESTABLISHED 
tcp        0      0 115.29.49.213:80            114.217.182.123:51960       TIME_WAIT   
tcp        0      0 115.29.49.213:80            118.242.18.177:24615        ESTABLISHED 
tcp        0      0 115.29.49.213:80            220.191.224.154:23380       TIME_WAIT   
tcp        0      0 115.29.49.213:80            119.78.240.118:59230        FIN_WAIT2   
tcp        0      0 115.29.49.213:80            218.83.11.138:52739         TIME_WAIT   
tcp        0      0 115.29.49.213:80            122.70.113.17:57809         TIME_WAIT   
tcp        0      0 115.29.49.213:80            121.235.160.76:2487         TIME_WAIT   
tcp        0      0 115.29.49.213:80            111.175.68.97:49920         TIME_WAIT   
tcp        0      1 115.29.49.213:80            221.137.78.206:54593        FIN_WAIT1   
tcp        0      0 115.29.49.213:80            119.121.180.245:14524       TIME_WAIT   
tcp        0      0 115.29.49.213:80            123.151.42.52:55816         ESTABLISHED 
tcp        0      0 115.29.49.213:80            120.192.146.19:26133        FIN_WAIT2   
tcp        0      0 115.29.49.213:80            113.107.56.233:45496        TIME_WAIT   
tcp        0      1 115.29.49.213:80            119.249.255.140:1664        FIN_WAIT1   
tcp        0      0 115.29.49.213:80            222.132.131.91:5451         ESTABLISHED 
tcp        0      0 115.29.49.213:80            183.32.61.109:5712          FIN_WAIT2   
tcp        0     52 115.29.49.213:22            119.2.28.4:13185            ESTABLISHED 
tcp        0      0 115.29.49.213:80            221.179.140.171:48647       TIME_WAIT   
tcp        0      0 115.29.49.213:80            111.161.61.49:60865         ESTABLISHED 
tcp        0      0 115.29.49.213:80            58.247.119.17:64369         TIME_WAIT   
tcp        0      0 115.29.49.213:80            121.35.208.125:50139        FIN_WAIT2   
tcp        0      0 115.29.49.213:80            118.242.18.177:24619        ESTABLISHED 
tcp        0      0 115.29.49.213:80            111.17.45.226:5492          TIME_WAIT   
tcp        0      0 115.29.49.213:80            114.250.252.127:50802       TIME_WAIT   
tcp        0      0 115.29.49.213:80            49.80.146.230:13424         TIME_WAIT   
tcp        0      0 115.29.49.213:80            113.241.77.56:18509         TIME_WAIT   
tcp        0      0 115.29.49.213:80            101.226.61.186:57302        ESTABLISHED 
tcp        0      0 115.29.49.213:80            59.38.233.215:18224         FIN_WAIT2   
tcp        0      0 115.29.49.213:80            222.70.73.234:52968         FIN_WAIT2   
tcp        0      0 115.29.49.213:80            114.100.142.6:3171          TIME_WAIT   
tcp        0      0 115.29.49.213:80            27.18.159.160:50095         TIME_WAIT   
tcp        0      0 115.29.49.213:80            122.64.91.155:35708         ESTABLISHED 
tcp        0      0 115.29.49.213:80            116.90.81.14:52978          TIME_WAIT   
tcp        0      0 115.29.49.213:80            124.227.212.140:38460       ESTABLISHED 
tcp        0      0 115.29.49.213:80            223.242.103.128:3997        TIME_WAIT   
tcp        0      0 115.29.49.213:80            113.116.147.94:50073        ESTABLISHED 
tcp        0      0 115.29.49.213:80            112.117.173.124:50366       TIME_WAIT   
tcp        0      0 115.29.49.213:80            122.227.191.174:4833        FIN_WAIT2   
tcp        0      0 115.29.49.213:80            42.95.73.152:51472          ESTABLISHED 
tcp        0      0 115.29.49.213:80            58.215.136.140:56794        TIME_WAIT   
tcp        0      0 115.29.49.213:80            116.90.81.14:52974          TIME_WAIT   
tcp        0      0 115.29.49.213:80            223.100.156.53:59779        TIME_WAIT   
tcp        0      0 115.29.49.213:80            125.112.122.240:44893       FIN_WAIT2   
tcp        0      0 115.29.49.213:80            14.211.169.36:26342         TIME_WAIT   
tcp        0      0 115.29.49.213:80            114.250.252.127:50809       TIME_WAIT   
tcp        0      0 115.29.49.213:80            14.157.228.55:3184          FIN_WAIT2   
tcp        0      0 115.29.49.213:80            112.113.160.225:3029        TIME_WAIT   
tcp        0      0 115.29.49.213:80            14.17.11.196:33403          ESTABLISHED 
tcp        0      0 115.29.49.213:80            36.249.78.78:2615           FIN_WAIT2   
tcp        0      0 115.29.49.213:80            114.105.192.151:1312        ESTABLISHED 
tcp        0      0 115.29.49.213:80            118.242.18.177:24616        FIN_WAIT2   
tcp        0      0 115.29.49.213:80            27.191.14.232:50272         FIN_WAIT2   
tcp        0      0 115.29.49.213:80            119.187.139.167:1779        FIN_WAIT2   
tcp        0      0 115.29.49.213:80            218.75.147.14:5195          TIME_WAIT   
tcp        0      0 115.29.49.213:80            1.204.201.226:12694         ESTABLISHED 
 
 
 
[root@oldboy C11]# cat 10_10_2.sh
#!/bin/sh
file=$1
if expr "$file" : ".*\.log" &>/dev/null
  then 
   :
  else
   echo $"usage:$0 xxx.log"
   exit 1
fi
 
while true
do
grep "ESTABLISHED" $1|awk -F "[ :]+" '{ ++S[$(NF-3)]}END {for(key in S) print S[key], key}'|sort -rn -k1|head -5 >/tmp/tmp.log
        while read line
        do
          ip=`echo $line|awk '{print $2}'`
          count=`echo $line|awk '{print $1}'`
            if [ $count -gt 3 ] && [ `iptables -L -n|grep "$ip"|wc -l` -lt 1 ]
             then
                iptables -I INPUT -s $ip -j DROP
                echo "$line is dropped" >>/tmp/droplist_$(date +%F).log
            fi
        done</tmp/tmp.log
        sleep 5
done
 
 
[root@oldboy C11]# cat 10_10_3.sh
#!/bin/sh
file=$1
JudgeExt(){
if expr "$1" : ".*\.log" &>/dev/null
  then 
   :
  else
   echo $"usage:$0 xxx.log"
   exit 1
fi
}
 
IpCount(){
grep "ESTABLISHED" $1|awk -F "[ :]+" '{ ++S[$(NF-3)]}END {for(key in S) print S[key], key}'|sort -rn -k1|head -5 >/tmp/tmp.log
}
 
ipt(){
local ip=$1
if [ `iptables -L -n|grep "$ip"|wc -l` -lt 1 ]
then
  iptables -I INPUT -s $ip -j DROP
  echo "$line is dropped" >>/tmp/droplist_$(date +%F).log
fi
}
main(){
JudgeExt $file
while true
do
IpCount $file
while read line
        do
          ip=`echo $line|awk '{print $2}'`
          count=`echo $line|awk '{print $1}'`
            if [ $count -gt 3 ]
             then
                ipt $ip
            fi
        done</tmp/tmp.log
        sleep 5
done
}
main