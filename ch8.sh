[root@oldboy C08]# cat 8_1.sh
#!/bin/bash
oldboy(){
    echo "I am oldboy."
}
function oldgirl(){
    echo "I am oldgirl."
}
oldboy
oldgirl
 
 
[root@oldboy C08]# cat 8_2.sh
#!/bin/bash
oldgirl
function oldgirl(){
    echo "I am oldgirl."
}
oldgirl
 
 
[root@oldboy C08]# cat 8_3.sh
#!/bin/bash
[ -f /etc/init.d/functions ] && . /etc/init.d/functions || exit 1
oldboy
 
 
[root@oldboy C08]# cat 8_4.sh
#!/bin/bash
[ -f /etc/init.d/functions ] && . /etc/init.d/functions || exit 1
oldgirl $1
#oldgirl xiaoting
 
 
[root@oldboy C08]# cat 8_5_1.sh
#!/bin/sh
function usage(){
  echo $"usage:$0 url"
  exit 1
}
 
function check_url(){
  wget --spider -q -o /dev/null --tries=1 -T 5 $1
  if [ $? -eq 0 ]
   then
     echo "$1 is yes."
  else
    echo "$1 is no."
  fi
}
 
function main(){
  if [ $# -ne 1 ]
   then
     usage
  fi
  check_url $1
}
main $*
 
 
[root@oldboy C08]# cat 8_5.sh
#!/bin/sh
if [ $# -ne 1 ]
 then
   echo $"usage:$0 url"
   exit 1
fi
wget --spider -q -o /dev/null --tries=1 -T 5 $1
if [ $? -eq 0 ]
 then
  echo "$1 is yes."
else
  echo "$1 is no."
fi
 
 
[root@oldboy C08]# cat 8_6.sh
#!/bin/sh
. /etc/init.d/functions
 
function usage(){
  echo $"usage:$0 url"
  exit 1
}
 
function check_url(){
  wget --spider -q -o /dev/null --tries=1 -T 5 $1
  if [ $? -eq 0 ]
   then
     action "$1 is yes." /bin/true
  else
     action "$1 is no." /bin/false
  fi
}
 
function main(){
  if [ $# -ne 1 ]
   then
     usage
  fi
  check_url $1
}
main $*
 
 
[root@oldboy C08]# cat 8_7_1.sh
#!/bin/bash
# author:oldboy
# qq:31333741
#set env
export PATH=$PATH:/bin:/sbin:/usr/sbin
# Require root to run this script.
if [ "$UID" != "0" ]; then
    echo "Please run this script by root."
    exit 1
fi
 
#define cmd var
SERVICE=`which service`
CHKCONFIG=`which chkconfig`
 
function mod_yum(){
    #modify yum path
    if [ -e /etc/yum.repos.d/CentOS-Base.repo ]
     then
       mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup&&\
       wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-6.repo
    fi
}
 
function close_selinux(){
    #1.close selinux
    sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
    #grep SELINUX=disabled /etc/selinux/config
    setenforce 0 &>/dev/null
    #getenforce
}
 
function close_iptables(){
    #2.close iptables
    /etc/init.d/iptables stop
    /etc/init.d/iptables stop
    chkconfig iptables off
}
 
function least_service(){
    #3.least service startup
    chkconfig|awk '{print "chkconfig",$1,"off"}'|bash
    chkconfig|egrep "crond|sshd|network|rsyslog|sysstat"|awk '{print "chkconfig",$1,"on"}'|bash
    #export LANG=en
    #chkconfig --list|grep 3:on
}
 
function adduser(){
    #4.add oldboy and sudo
    if [ `grep -w oldboy /etc/passwd|wc -l` -lt 1 ]
      then
        useradd oldboy
        echo 123456|passwd --stdin oldboy
        \cp /etc/sudoers /etc/sudoers.ori
        echo "oldboy  ALL=(ALL) NOPASSWD: ALL " >>/etc/sudoers
        tail -1 /etc/sudoers
        visudo -c &>/dev/null
    fi
}
 
function charset(){
    #5.charset config
    cp /etc/sysconfig/i18n /etc/sysconfig/i18n.ori
    echo 'LANG="zh_CN.UTF-8"'  >/etc/sysconfig/i18n
    source /etc/sysconfig/i18n
    #echo $LANG
}
 
function time_sync(){
    #6.time sync.
    cron=/var/spool/cron/root
    if [ `grep -w "ntpdate" $cron|wc -l` -lt 1  ]
      then
        echo '#time sync by oldboy at 2010-2-1' >>$cron
        echo '*/5 * * * * /usr/sbin/ntpdate time.nist.gov >/dev/null 2>&1' >>$cron
        crontab -l
    fi
}
 
function com_line_set(){
    #7.command set.
    if [ `egrep "TMOUT|HISTSIZE|HISTFILESIZE" /etc/profile|wc -l` -ge 3  ]
      then
        echo 'export TMOUT=300' >>/etc/profile
        echo 'export HISTSIZE=5' >>/etc/profile
        echo 'export HISTFILESIZE=5' >>/etc/profile
        . /etc/profile
    fi
}
 
function open_file_set(){
    #8.increase open file.
    if [ `grep 65535 /etc/security/limits.conf|wc -l` -lt 1 ]
      then 
        echo '*               -       nofile          65535 ' >>/etc/security/limits.conf
        tail -1 /etc/security/limits.conf
    fi
}
 
function set_kernel(){
    #9.kernel set.
    if [ `grep kernel_flag /etc/sysctl.conf|wc -l` -lt 1 ]
      then
        cat >>/etc/sysctl.conf<<EOF
        #kernel_flag
        net.ipv4.tcp_fin_timeout = 2
        net.ipv4.tcp_tw_reuse = 1
        net.ipv4.tcp_tw_recycle = 1
        net.ipv4.tcp_syncookies = 1
        net.ipv4.tcp_keepalive_time = 600
        net.ipv4.ip_local_port_range = 4000    65000
        net.ipv4.tcp_max_syn_backlog = 16384
        net.ipv4.tcp_max_tw_buckets = 36000
        net.ipv4.route.gc_timeout = 100
        net.ipv4.tcp_syn_retries = 1
        net.ipv4.tcp_synack_retries = 1
        net.core.somaxconn = 16384
        net.core.netdev_max_backlog = 16384
        net.ipv4.tcp_max_orphans = 16384
        net.nf_conntrack_max = 25000000
        net.netfilter.nf_conntrack_max = 25000000
        net.netfilter.nf_conntrack_tcp_timeout_established = 180
        net.netfilter.nf_conntrack_tcp_timeout_time_wait = 120
        net.netfilter.nf_conntrack_tcp_timeout_close_wait = 60
        net.netfilter.nf_conntrack_tcp_timeout_fin_wait = 120
EOF
        sysctl -p
    fi
}
function init_ssh(){
    \cp /etc/ssh/sshd_config /etc/ssh/sshd_config.`date +"%Y-%m-%d_%H-%M-%S"`
    #sed -i 's%#Port 22%Port 52113%' /etc/ssh/sshd_config
    sed -i 's%#PermitRootLogin yes%PermitRootLogin no%' /etc/ssh/sshd_config
    sed -i 's%#PermitEmptyPasswords no%PermitEmptyPasswords no%' /etc/ssh/sshd_config
    sed -i 's%#UseDNS yes%UseDNS no%' /etc/ssh/sshd_config
    /etc/init.d/sshd reload &>/dev/null
}
 
function update_linux(){
    #10.upgrade linux.
    if [ `rpm -qa lrzsz nmap tree dos2unix nc|wc -l` -le 3 ]
      then
        yum install lrzsz nmap tree dos2unix nc -y
        #yum update -y
    fi
}
main(){
    mod_yum
    close_selinux
    close_iptables
    least_service
    adduser
    charset
    time_sync
    com_line_set
    open_file_set
    set_kernel
    init_ssh
    update_linux
}
main
 
 
[root@oldboy C08]# cat 8_7_2.sh
#!/bin/bash
################################################
#this scripts is created by oldboy
#oldboy QQ:31333741
#blog:http://oldboy.blog.51cto.com
################################################
#set env
export PATH=$PATH:/bin:/sbin:/usr/sbin
# Require root to run this script.
if [ "$UID" != "0" ]; then
    echo "Please run this script by root."
    exit 1
fi
 
# Source function library.
. /etc/init.d/functions
 
function check_yum(){
    Base=/etc/yum.repos.d/CentOS-Base.repo
    if [ `grep aliyun $Base|wc -l` -ge 1  ];then
        action "$Base config" /bin/true
    else
        action "$Base config" /bin/false
    fi
}
 
function check_selinux(){
    config=/etc/selinux/config
    if [ `grep "SELINUX=disabled" $config|wc -l ` -ge 1  ];then
        action "$config config" /bin/true
    else
        action "$config config" /bin/false
    fi
}
 
function check_service(){
    export LANG=en
    if [ `chkconfig|grep 3:on|egrep "crond|sshd|network|rsyslog|sysstat"|wc -l` -eq 5 ]
      then
        action "sys service init" /bin/true
    else
        action "sys service init" /bin/false
    fi
}
function check_open_file(){
    limits=/etc/security/limits.conf
    if [ `grep 65535 $limits|wc -l` -eq 1 ]
      then
        action "$limits" /bin/true
    else
        action "$limits" /bin/false
    fi
}
main(){
    check_yum
    check_selinux
    check_service
    check_open_file
}
main
 
 
[root@oldboy C08]# cat 8_8.sh
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