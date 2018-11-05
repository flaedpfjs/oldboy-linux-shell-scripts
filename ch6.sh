[root@oldboy C06]# cat 6_15.sh
[ -f /etc ] || {
    echo 1
    echo 2
    echo 3
}
 
 
[root@oldboy C06]# cat 6_34_1.sh
#!/bin/sh
echo -n "pls input a char:" 
read var
[ "$var" == "1" ] && {
    echo 1
    exit 0
}
[ "$var" == "2" ] && {
    echo 2
    exit 0
}
[ "$var" != "2" -a "$var" != "1" ] && {
    echo error
    exit 0
}
 
 
[root@oldboy C06]# cat 6_34_2.sh
#!/bin/sh
var=$1
[ "$var" == "1" ] && {
    echo 1
    exit 0
}
[ "$var" == "2" ] && {
    echo 2
    exit 0
}
[ "$var" != "2" -a "$var" != "1" ] && {
    echo error
    exit 0
}
 
 
[root@oldboy C06]# cat 6_35_1.sh
#!/bin/sh
read -p "Pls input two num:" a b
#no1
[ -z "$a" ] || [ -z "$b" ] && {
    echo "Pls input two num again."
    exit 1
}
#no2
expr $a + 10 &>/dev/null
RETVAL1=$?
expr $b + 10 &>/dev/null
RETVAL2=$?
test $RETVAL1 -eq 0 -a $RETVAL2 -eq 0 || {
    echo "Pls input two "num" again."
    exit 2
}
#no3
[ $a -lt $b ] && {
    echo "$a < $b"
    exit 0
}
#no4
[ $a -eq $b ] && {
    echo "$a = $b"
    exit 0
}
#no5
[ $a -gt $b ] && {
    echo "$a > $b"
}
 
 
[root@oldboy C06]# cat 6_35_2.sh
#!/bin/sh
a=$1
b=$2
#no1
[ $# -ne 2 ] && {
    echo "USAGE:$0 NUM1 NUM2"
    exit 1
}
#no1
expr $a + 10 &>/dev/null
RETVAL1=$?
expr $b + 10 &>/dev/null
RETVAL2=$?
test $RETVAL1 -eq 0 -a $RETVAL2 -eq 0 || {
    echo "Pls input two "num" again."
    exit 2
}
#no3
[ $a -lt $b ] && {
    echo "$a < $b"
    exit 0
}
#no4
[ $a -eq $b ] && {
    echo "$a = $b"
    exit 0
}
#no5
[ $a -gt $b ] && {
    echo "$a > $b"
}
 
 
[root@oldboy C06]# cat 6_36_1.sh
#!/bin/sh
cat <<END
   1.panxiaoting
   2.gongli
   3.fanbinbing
END
read -p "Which do you like?,Pls input the num:" a
[ "$a" = "1" ] && {
    echo "I guess,you like panxiaoting"
    exit 1
}
[ "$a" = "2" ] && {
    echo "I guess,you like gongli"
    exit 1
}
 
[ "$a" = "3" ] && {
    echo "I guess,you like fangbingbing"
    exit 1
}
[[ ! "$a" =~ [1-3] ]] && {
    echo "I guess,you are not man."
}
 
 
[root@oldboy C06]# cat 6_36_2.sh
#!/bin/sh
path=/server/scripts
[ ! -d "$path" ] && mkdir $path
 
#menu
cat <<END
    1.[install lamp]
    2.[install lnmp]
    3.[exit]
    pls input the num you want:
END
read num
expr $num + 1 &>/dev/null
[ $? -ne 0 ] && {
    echo "the num you input must be {1|2|3}"
    exit 1
}
 
[ $num -eq 1 ] && {
    echo "start installing lamp."
    sleep 2;
    [ -x "$path/lamp.sh" ] || {
        echo "$path/lamp.sh does not exist or can not be exec."
        exit 1
    }
    $path/lamp.sh
    exit $?
}
 
[ $num -eq 2 ] && {
    echo "start installing LNMP."
    sleep 2;
    [ -x "$path/lnmp.sh" ] || {
        echo "$path/lnmp.sh does not exist or can not be exec."
        exit 1
    }
    $path/lnmp.sh
    exit $?
}
[ $num -eq 3 ] && {
    echo bye.
    exit 3
}
 
#[[ ! $num =~ [1-3] ]]&&{
[ ! $num -eq 1 -o ! $num -eq 2 -o ! $num -eq 3 ] && {
    echo "the num you input must be {1|2|3}"
    echo "Input ERROR"
    exit 4
}