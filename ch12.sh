[root@oldboy C12]# for n in `ls *.sh`;do echo;echo;echo "[root@oldboy C12]# cat $n";cat $n;done
 
[root@oldboy C12]# cat 12_1_1.sh
#!/bin/bash                                                                                    
#Author:oldboy training
#Blog:http://oldboy.blog.51cto.com
#Time:2016-09-21 23:16:11
#Name:12_1_1.sh
#Version:V1.0
#Description:test{break|continue|exit|return}script.
if [ $# -ne 1 ];then
  echo $"usage:$0 {break|continue|exit|return}"
  exit 1
fi
 
test(){
for((i=0; i<=5; i++))
do
  if [ $i -eq 3 ] ;then
      $*;
  fi
  echo $i
done
echo "I am in func."
}
test $*
func_ret=$?
if [ `echo $*|grep return|wc -l` -eq 1 ]
 then
  echo "return's exit status:$func_ret" 
fi
echo "ok"
 
 
 
 
[root@oldboy C12]# cat 12_2_1.sh
#!/bin/bash                                                                                            
#Author:oldboy training
#Blog:http://oldboy.blog.51cto.com
#Time:2016-09-22 00:11:22
#Name:12_2_1.sh
#Version:V1.0
#Description:config ip script.
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
RETVAL=0
add(){
for ip in {1..16}
do
  if [ $ip -eq 10 ] 
  then
     continue
  fi
  ip addr add 10.0.2.$ip/24 dev eth0 label eth0:$ip &>/dev/null
  RETVAL=$?
  if [ $RETVAL -eq 0 ]
  then
      action "add $ip" /bin/true
  else 
      action "add $ip" /bin/false
  fi
done
return $RETVAL
}
 
del(){
for ip in {16..1}
do
  if [ $ip -eq 10 ]
  then
     continue
  fi
  #ip addr del 10.0.2.$ip/24 dev eth0 &>/dev/null
  ifconfig eth0:$ip down &>/dev/null
  RETVAL=$?
  if [ $RETVAL -eq 0 ]
  then
      action "del $ip" /bin/true
  else
      action "del $ip" /bin/false
  fi
done
}
case "$1" in
 start)
    add
    RETVAL=$?
    ;;
 stop)
    del
    RETVAL=$?
    ;;
 restart)
    del
    sleep 2
    add
    RETVAL=$?
    ;;
    *)
     printf "USAGE:$0 {start|stop|restart}\n"
esac
exit $RETVAL
 
 
[root@oldboy C12]# cat 12_2_2.sh
#!/bin/bash                                                                                            
#Author:oldboy training
#Blog:http://oldboy.blog.51cto.com
#Time:2016-09-22 00:36:18
#Name:12_2_2.sh
#Version:V1.0
#Description:config ip new script.
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
RETVAL=0
op(){
if [ "$1" == "del"  ] 
then
    list=`echo {16..1}`
else
    list=`echo {1..16}`
fi
 
for ip in $list
do
  if [ $ip -eq 10 ] 
  then
     continue
  fi
  ip addr $1 10.0.2.$ip/24 dev eth0 label eth0:$ip &>/dev/null
  RETVAL=$?
  if [ $RETVAL -eq 0 ]
  then
      action "$1 $ip" /bin/true
  else 
      action "$1 $ip" /bin/false
  fi
done
return $RETVAL
}
 
case "$1" in
 start)
    op add
    RETVAL=$?
    ;;
 stop)
    op del
    RETVAL=$?
    ;;
 restart)
    op del
    sleep 2
    op add
    RETVAL=$?
    ;;
    *)
     printf "USAGE:$0 {start|stop|restart}\n"
esac
exit $RETVAL
 
 
[root@oldboy C12]# cat 12_3_1.sh
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
 
 
 
[root@oldboy C12]# cat 12_4_1.sh
#!/bin/bash
for n in {0..32767}
do 
  echo "`echo $n|md5sum` $n" >>/tmp/zhiwen.log
done
 
 
 
[root@oldboy C12]# cat 12_4_2.sh
#!/bin/bash
#for n in {0..32767}
#do 
 # echo "`echo $n|md5sum` $n" >>/tmp/zhiwen.log
#done
 
md5char="4fe8bf20ed"
while read line
do
    if [ `echo $line|grep "$md5char"|wc -l` -eq 1 ]
     then
           echo $line
           break
    fi
done </tmp/zhiwen.log