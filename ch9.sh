[root@oldboy C09]# cat plush_color.sh
#!/bin/sh
RED_COLOR='\E[1;31m'
GREEN_COLOR='\E[1;32m'
YELLOW_COLOR='\E[1;33m'
BLUE_COLOR='\E[1;34m'
RES='\E[0m'
echo -e "$RED_COLOR oldboy $RES"
echo -e "$YELLOW_COLOR oldgirl $RES"
 
 
[root@oldboy C09]# cat 9_1_1.sh
#!/bin/bash
# this script is created by oldboy.
# oldboy@oldboyedu.com
read -p "Please input a number:" ans 
case "$ans" in
    1)
      echo  "The num you input is 1"
      ;;
    2)
      echo "The num you input is 2"
      ;;
    [3-9])
      echo "The num you input is $ans"
      ;;
    *)
      echo "Please input [0-9] int.bye."
      exit;
esac
 
 
[root@oldboy C09]# cat 9_1_2.sh
#!/bin/bash
# this script is created by oldboy.
# oldboy@oldboyedu.com
read -p "please input a number:" ans
if [ $ans -eq 1 ];then
    echo "the num you input is 1" 
elif [ $ans -eq 2 ];then
    echo "the num you input is 2" 
elif [ $ans -ge 3 -a $ans -le 9 ];then
    echo "the num you input is $ans" 
else
    echo "the num you input must be [1-9]."
    exit
fi
 
 
 
[root@oldboy C09]# cat 9_2_1.sh
#!/bin/sh
RED_COLOR='\E[1;31m'
GREEN_COLOR='\E[1;32m'
YELLOW_COLOR='\E[1;33m'
BLUE_COLOR='\E[1;34m'
RES='\E[0m'
echo '
  =====================
  1.apple
  2.pear
  3.banana
  4.cherry
  =====================
'
read -p "pls select a num:" num
case "$num" in
    1) 
      echo -e "${RED_COLOR}apple${RES}"
      ;; 
    2)
      echo -e "${GREEN_COLOR}pear${RES}"
      ;;
    3)
      echo -e "${YELLOW_COLOR}banana${RES}"
      ;;
    4)
      echo -e "${BLUE_COLOR}cherry${RES}"
      ;;
    *)
      echo "muse be {1|2|3|4}"
esac
 
 
[root@oldboy C09]# cat 9_2_2.sh
#!/bin/sh
RED_COLOR='\E[1;31m'
GREEN_COLOR='\E[1;32m'
YELLOW_COLOR='\E[1;33m'
BLUE_COLOR='\E[1;34m'
RES='\E[0m'
menu(){
    cat <<END
    1.apple
    2.pear
    3.banana
END
}
menu
read -p "pls input your choice:" fruit
case "$fruit" in
    1)
      echo -e "${RED_COLOR}apple${RES}"
      ;;
    2)
      echo -e "${GREEN_COLOR}pear${RES}" 
      ;;
    3)
      echo -e "${YELLOW_COLOR}banana${RES}" 
      ;;
    *)
      echo -e "no fruit you choose."
esac
 
 
[root@oldboy C09]# cat 9_2_3.sh
#!/bin/sh
RED_COLOR='\E[1;31m'
GREEN_COLOR='\E[1;32m'
YELLOW_COLOR='\E[1;33m'
BLUE_COLOR='\E[1;34m'
RES='\E[0m'
function usage(){
    echo "USAGE: $0 {1|2|3|4}"
    exit 1
}
function menu(){
    cat <<END
    1.apple
    2.pear
    3.banana
END
}
function chose(){
    read -p "pls input your choice:" fruit
    case "$fruit" in
        1)
          echo -e "${RED_COLOR}apple${RES}"
          ;;
        2)
          echo -e "${GREEN_COLOR}pear${RES}" 
          ;;
        3)
          echo -e "${YELLOW_COLOR}banana${RES}" 
          ;;
        *)
          usage
    esac
}
function main(){
     menu
     chose
}
main
 
 
[root@oldboy C09]# cat 9_4_2.sh
SETCOLOR_SUCCESS="echo -en \\033[1;32m"
SETCOLOR_FAILURE="echo -en \\033[1;31m"
SETCOLOR_WARNING="echo -en \\033[1;33m"
SETCOLOR_NORMAL="echo -en \\033[0;39m"
echo ----oldboy trainning-----   &&  $SETCOLOR_SUCCESS
echo ----oldboy trainning-----   &&  $SETCOLOR_FAILURE
echo ----oldboy trainning-----   &&  $SETCOLOR_WARNING
echo ----oldboy trainning-----   &&  $SETCOLOR_NORMAL
 
 
[root@oldboy C09]# cat 9_4.sh
#!/bin/bash
RED_COLOR='\E[1;31m'
GREEN_COLOR='\E[1;32m'
YELLOW_COLOR='\E[1;33m'
BLUE_COLOR='\E[1;34m'
PINK='\E[1;35m'
RES='\E[0m'
echo -e  "${RED_COLOR}======red color======${RES}"
echo -e  "${YELLOW_COLOR}======yellow color======${RES}"
echo -e  "${BLUE_COLOR}======blue color======${RES}"
echo -e  "${GREEN_COLOR}======green color======${RES}"
echo -e  "${PINK}======pink color======${RES}"
 
 
[root@oldboy C09]# cat 9_5_1.sh
#!/bin/bash
RED_COLOR='\E[1;31m'
GREEN_COLOR='\E[1;32m'
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
 
 
[root@oldboy C09]# cat 9_5_2.sh
#!/bin/bash
plus_color(){
RED_COLOR='\E[1;31m'
GREEN_COLOR='\E[1;32m'
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
plus_color "I" red
plus_color "am" green
plus_color "oldboy" blue
 
 
[root@oldboy C09]# cat 9_5_3.sh
#!/bin/bash
function AddColor(){
    RED_COLOR='\E[1;31m'
    GREEN_COLOR='\E[1;32m'
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
function main(){
    AddColor $1 $2 
}
main $*
 
 
[root@oldboy C09]# cat 9_5_4.sh
#!/bin/sh
RED_COLOR='\E[1;31m'
GREEN_COLOR='\E[1;32m'
YELLOW_COLOR='\E[1;33m'
BLUE_COLOR='\E[1;34m'
RES='\E[0m'
function usage(){
    echo "USAGE: $0 {1|2|3|4}"
    exit 1
}
function menu(){
     cat <<END
    1.apple
    2.pear
    3.banana
END
}
function chose(){
    read -p "pls input your choice:" fruit
    case "$fruit" in
        1)
          echo -e "${RED_COLOR}apple${RES}"
          ;;
        2)
          echo -e "${GREEN_COLOR}pear${RES}" 
          ;;
        3)
          echo -e "${YELLOW_COLOR}banana${RES}" 
          ;;
        *)
          usage
    esac
}
function main(){
    menu
    chose
}
main
 
 
[root@oldboy C09]# cat 9_8_1.sh
#!/bin/sh
path=/application/nginx/sbin
RETVAL=0
. /etc/init.d/functions
start(){
    if [ `netstat -lntup|grep nginx|wc -l` -eq 0 ];then
        $path/nginx
        RETVAL=$?
        if [ $RETVAL -eq 0 ];then
            action "nginx is started" /bin/true
            exit $RETVAL
        else
            action "nginx is started" /bin/false
            exit $RETVAL
        fi
    else
        echo "nginx is running"
        exit 0
    fi
}
stop(){
    if [ `netstat -lntup|grep nginx|wc -l` -ne 0 ];then
        $path/nginx -s stop
        RETVAL=$?
        if [ $RETVAL -eq 0 ];then
            action "nginx is stopped" /bin/true
        else
            action "nginx is stopped" /bin/false
        fi
    else
        echo "nginx is no running"
        exit
     fi
}
 
case "$1" in
    start)
        start
            RETVAL=$?
        ;;
    stop)
        stop
        RETVAL=$?
        ;;
    restart)
         stop
             sleep 1
         start
         RETVAL=$?
         ;;
    *)
         echo $"Usage: $0 {start|stop|restart|reload}"
         exit 1
esac
exit $RETVAL
 
 
[root@oldboy C09]# cat 9_8_2.sh
#!/bin/sh
# chkconfig: 2345 40 98
# description: Start/Stop Nginx server
path=/application/nginx/sbin
pid=/application/nginx/logs/nginx.pid
RETVAL=0
. /etc/init.d/functions
start(){
    if [ ! -f $pid ];then
        $path/nginx
        RETVAL=$?
        if [ $RETVAL -eq 0 ];then
            action "nginx is started" /bin/true
            return $RETVAL
        else
            action "nginx is started" /bin/false
            return $RETVAL
        fi
    else
        echo "nginx is running"
        return 0
    fi
}
stop(){
    if [ -f $pid ];then
        $path/nginx -s stop
        RETVAL=$?
        if [ $RETVAL -eq 0 ];then
            action "nginx is stopped" /bin/true
            return $RETVAL
        else
            action "nginx is stopped" /bin/false
            return $RETVAL
        fi
    else
        echo "nginx is no running"
        return $RETVAL
    fi
}
 
case "$1" in
    start)
          start
              RETVAL=$?
          ;;
    stop)
          stop
          RETVAL=$?
          ;;
    restart)
          stop
              sleep 1
          start
          RETVAL=$?
          ;;
    *)
          echo $"Usage: $0 {start|stop|restart|reload}"
          exit 1
esac
exit $RETVAL
 
 
[root@oldboy C09]# cat 9_8_3.sh
#!/bin/sh
# chkconfig: 2345 40 98
# description: Start/Stop Nginx server
path=/application/nginx/sbin
pid=/application/nginx/logs/nginx.pid
RETVAL=0
. /etc/init.d/functions
start(){
    if [ ! -f $pid ];then
        $path/nginx
        RETVAL=$?
        if [ $RETVAL -eq 0 ];then
            action "nginx is started" /bin/true
            return $RETVAL
        else
            action "nginx is started" /bin/false
            return $RETVAL
        fi
    else
        echo "nginx is running"
        return 0
    fi
}
stop(){
    if [ -f $pid ];then
        $path/nginx -s stop
         RETVAL=$?
        if [ $RETVAL -eq 0 ];then
            action "nginx is stopped" /bin/true
            return $RETVAL
        else
            action "nginx is stopped" /bin/false
            return $RETVAL
        fi
    else
        echo "nginx is no running"
        return $RETVAL
    fi
}
 
case "$1" in
    start)
        start
        RETVAL=$?
        ;;
    stop)
        stop
        RETVAL=$?
        ;;
    restart)
         stop
             sleep 1
         start
         RETVAL=$?
         ;;
    *)
         echo $"Usage: $0 {start|stop|restart|reload}"
         exit 1
esac
exit $RETVAL