#!/bin/bash
#exce="adb -s 8BDAX00AB6 shell"
exce="/usr/local/google/home/oceanchen/platform-tools/adb -s 8BDAX00AB6 shell"
#exce=""
log="terminal"
#log="kernel"
color=0
count=0
limit=300
SECONDS=0

show_color()
{
	get_color $1 $2
	echo $color
}

get_color()
{
	color=$($exce screencap -x $1 -y $2)
    #width=$($exce "screencap2 | dd bs=4 count=1 status=none" | od -A n -t d4)
    #color=$($exce "screencap2 | dd bs=4 count=1 skip=$(((width*$2)+$1+4)) status=none" | od -A n -t x4 | tr a-z A-Z)
    #high=$($exce "screencap | dd bs=4 count=1 skip=1 status=none" | od -A n -t d4)
}

click()
{
	$exce input touchscreen tap $1 $2
}

log()
{
	if [ "$log" = "terminal" ]; then
		echo -e $1
	elif [ "$log" = "kernel" ]; then
		$exce "echo sg:$1 > /dev/kmsg"
	fi;
	$exce "echo ""sg $1"" > /dev/kmsg"
}

wait()
{
	count=0
	while [[ ("$color" != "$3") && (count -ne "$5") ]]
    do
        get_color $1 $2
        ((count++))
        sleep 1

		if [[ `expr $count % 10` == "0" ]]; then
			log "$4 time : $count : wating color $color to $3"
		fi
			echo -n .
    done
    if [ "$count" = "$limit" ] || [ "$count" = "$5" ]; then
        log "$4 color mismatch $color : $3"
        $exce dmesg > dmesg
    	exit 1
    fi;
}

wait_then_click()
{
    get_color $1 $2

    if [ -z "$5" ]; then #check $5 argument is not exsit
		wait $1 $2 $3 "$4" $limit
	else
		wait $1 $2 $3 "$4" $5
    fi;

	$exce input touchscreen tap $1 $2
	sleep 1.5
	log "$4 color match, click [$1,$2]"
}

check_and_click()
{
	get_color $1 $2
	if [ "$color" = "$3" ]; then 
		log "$4 color match, click [$1,$2]"
		$exce input touchscreen tap $1 $2
		sleep 2
	else
		log "$4 color mismatch $color $3"
	fi;
}

check_and_click_another()
{
	get_color $1 $2
	if [ "$color" = "$3" ]; then 
		log "$4 color match, click [$5,$6]"
		$exce input touchscreen tap $5 $6
		sleep 2
	else
		log "$4 color mismatch $color $3"
	fi;
}

collect_all_items()
{
	wait_then_click 1361  1013   FF3B5069 "collect item @1"
	check_and_click  915   915   FF527B95 "outstand craft"
	check_and_click  915   915   FF527B95 "outstand craft"
	wait_then_click 1159  1013   FF374D65 "collect item @2"
	check_and_click  915   915   FF527B95 "outstand craft"
	check_and_click  915   915   FF527B95 "outstand craft"
	wait_then_click  957  1013   FF334962 "collect item @3"
	check_and_click  915   915   FF527B95 "outstand craft"
	check_and_click  915   915   FF527B95 "outstand craft"
	wait_then_click  755  1013   FF2F455F "collect item @4"
	check_and_click  915   915   FF527B95 "outstand craft"
	check_and_click  915   915   FF527B95 "outstand craft"
	wait_then_click  553  1013   FF344A63 "collect item @5"
	check_and_click  915   915   FF527B95 "outstand craft"
	check_and_click  915   915   FF527B95 "outstand craft"
}

create_starred_item()
{
	#wait_then_click  2129  375   FF735252 "collect material"
	wait_then_click  2129  232   FF937272 "collect material"
	wait_then_click  549  1008   FFFFFFFF "open forge window"
	check_and_click  203  1022   FF2A4F69 "look starred item"

	check_and_click_another 283 823   FF4A5263 "forge the first item" 283 700
	check_and_click_another 283 823   FF2B4057 "forge the first item" 283 700
	check_and_click_another 283 823   FF4A5263 "forge the first item" 283 700
	check_and_click_another 283 823   FF2B4057 "forge the first item" 283 700
	check_and_click_another 283 823   FF4A5263 "forge the first item" 283 700
	check_and_click_another 283 823   FF2B4057 "forge the first item" 283 700
	check_and_click_another 283 823   FF4A5263 "forge the first item" 283 700
	check_and_click_another 283 823   FF2B4057 "forge the first item" 283 700
	check_and_click_another 283 823   FF4A5263 "forge the first item" 283 700
	check_and_click_another 283 823   FF2B4057 "forge the first item" 283 700
	#wait_then_click  288   722   FF8EBBDF "forge the first item"
	#wait_then_click  288   722   FF8EBBDF "forge the first item"
	#wait_then_click  288   722   FF8EBBDF "forge the first item"
	#wait_then_click  288   722   FF8EBBDF "forge the first item"
	#wait_then_click  288   722   FF8EBBDF "forge the first item"
	#wait_then_click  674   722   FF92BDDF "forge the second item"
	#wait_then_click 1006   722   FF8EBBDF "forge the third item"
	#wait_then_click  288   722   FF8EBBDF "forge the first item"
	#wait_then_click  674   722   FF92BDDF "forge the second item"
}

click_delete_button()
{
	for i in `seq 1 10`;
	do
	    check_and_click  395  914    FFE7EDF7 "delete item-a : $i"
	    check_and_click  395  914    FF88BADA "delete item-b : $i"
        if [ "$i" -eq "1" ]; then
			check_and_click 1275 670 FF3568AC "check item deletable"
        fi
	done
}

delete_all_producing_items()
{
	wait_then_click 2070   990   FF24536A "open feature list"
	wait_then_click 1244   994   FF3F7496 "open warehouse"
	####################
	wait_then_click  715   929   FF8899BB "select ax icon"
	wait_then_click  393   774   FFFFFFFF "open first item info"
	click_delete_button
	check_and_click 1713   192   FF919195 "exsit info dialog"
	####################
	wait_then_click 1538   929   FFAAA191 "select herb icon"
	wait_then_click  393   774   FFFFFFFF "open first item info"
	click_delete_button
	check_and_click 1713   192   FF919195 "exsit info dialog"
	####################
	wait_then_click  885  1020   FF92A796 "select cloth icon"
	wait_then_click  393   774   FFFFFFFF "open first item info"
	click_delete_button
	check_and_click 1713   192   FF919195 "exsit info dialog"
	####################
	check_and_click 1713   192   FF919195 "exsit info dialog"
	wait_then_click 2121    33   FFFFFFFF "exsit window"
}

empty_wait()
{
    for j in `seq 1 $1`;
	do
	    log "------ stay $j sec ------"
	    sleep 1
	done
}

produce_started_items()
{
	collect_all_items
	create_starred_item
	delete_all_producing_items
}

all()
{
    for i in `seq 1 999`;
    do
        log "------ run the $i time ------"
		collect_all_items
        create_starred_item
        empty_wait 1
    done
}


fight()
{
    for i in `seq 1 200`;
    do
		check_and_click  1073  890    FFA7DAFA "search opponent"
		check_and_click  1073  890    FF00014A "fight start"
		check_and_click  1929  1036   FFEEEEEE "skip fight animation"
		check_and_click  1929  1036   FF251507 "skip fight animation"
		check_and_click  1929  1036   FF8CBBD2 "skip fight animation"
		check_and_click  1000  200    FF5D4D45 "leave the fail dialog"
		check_and_click  1943  1023   FF0C0702 "close fighting result"
		check_and_click  1943  1023   FFF5F5F5 "close fighting result"
		check_and_click  1943  1023   FF030406 "skip level changed"
    done
}

measure_yield()
{
	echo "start"
	wait_then_click  2129  232   FF937272 "collect material"
	$exce "screencap -p /sdcard/screen.png" && adb -s 8BDAX00AB6 pull /sdcard/screen.png ./screenshot-$(date +%Y-%m-%d_%H%M%S) > /dev/null
	for i in `seq 1 600`;
	do

		if [[ `expr $i % 10` == "0" ]]; then
			echo $i
		fi
			echo -n .
		sleep 1
	done
	wait_then_click  2129  232   FF937272 "collect material"
	$exce "screencap -p /sdcard/screen.png" && adb -s 8BDAX00AB6 pull /sdcard/screen.png ./screenshot-$(date +%Y-%m-%d_%H%M%S) > /dev/null
	echo "end"
}

launch_app()
{
	$exce am start -n com.yoda.and.twsgdh/.MainActivity
	wait_then_click 1080 860 FF1C66B6 "click enter on bulletin"
	wait_then_click 1476 822 FF2387D9 "start game"
	wait_then_click 1029 729 FF3E4236 "enter workshop"
}

just_try()
{
	wait_then_click 1272 852 FF1F68B2 "get refined item"
	$exce input swipe 450 150 2000 900 1000
	$exce "screencap -p /sdcard/screen.png" 
	/usr/local/google/home/oceanchen/platform-tools/adb -s 8BDAX00AB6 pull /sdcard/screen.png ./screenshot-$(date +%Y-%m-%d_%H%M%S).png
}

explore_mission()
{
	wait_then_click 100 1000 FF235458 "back to home page" 3
	wait_then_click 1800 800 FF84A0BC "Enter explore page" 3
	wait_then_click 1730 570 FFDADAEF "select 7th mission" 3
	wait_then_click 2050 900 FF669074 "start mission" 3
	wait_then_click 1730 570 FFDADAEF "select 7th mission" 3
	wait_then_click 2050 900 FF669074 "start mission" 3
	wait_then_click 1730 570 FFDADAEF "select 7th mission" 3
	wait_then_click 2050 900 FF669074 "start mission" 3
	wait_then_click 700 1010 FFCCD2D8 "select reward slot 1" 3
	wait_then_click 1647 976 FF89A771 "get reward" 3
	wait_then_click 1636 978 FF749758 "get reward continue a" 3
	wait_then_click 900 1010 FFC4CAD2 "select reward slot 2" 3
	wait_then_click 1647 976 FF89A771 "get reward" 3
	wait_then_click 1636 978 FF759858 "get reward continue b" 3
	wait_then_click 904  783 FFFFFFFF "drop equipment" 3
	wait_then_click 1100 1010 FF465A70 "select reward slot 3" 3
	wait_then_click 1647 976 FF89A771 "get reward" 3
	wait_then_click 1636 978 FF759858 "get reward continue b" 3
	wait_then_click 904  783 FFFFFFFF "drop equipment" 3
	wait_then_click 2121    33   FFFFFFFF "exsit window"
	wait_then_click 1029 729 FF3E4236 "enter workshop"
}

do_partial()
{
	count=1
	collect_all_items
	create_starred_item
    for i in `seq 1 99999`;
    do
        duration=$SECONDS
        if [[ "$duration" -gt "300" ]]; then
       		log "\n------ run the $count time ------"
			SECONDS=0
			collect_all_items
			create_starred_item

			$exce "screencap -p /sdcard/screen.png" 
			/usr/local/google/home/oceanchen/platform-tools/adb -s 8BDAX00AB6 pull /sdcard/screen.png ./screenshot-$(date +%Y-%m-%d_%H%M%S).png
        	((count++))
		fi

		if [[ `expr $i % 50` == "0" ]]; then
			echo $i
			python3 psg.py
		fi
			echo -n .
		sleep 1
    done
}

do_partial