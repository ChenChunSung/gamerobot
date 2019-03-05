adb="/usr/local/google/home/oceanchen/platform-tools/adb -s 8BDAX00AB6"
color=0

check_outstanding_craft()
{
    sleep 2
    color=$($adb shell "screencap -x 915 -y 915")

    if [ "$color" = "FF527B95" ]; then 
        echo "outstanding check color Matched" 
        $adb shell "input tap 915 915"
        sleep 1
    else
        echo "outstanding check color is NOT Matched $color"  
    fi;
}

check_item_deletable()
{
    sleep 1
    color=$($adb shell "screencap -x 1275 -y 670")

    if [ "$color" = "FF3568AC" ]; then 
        echo "check item can be deleted color Matched" 
        $adb shell "input tap 1275 670"
    else
        echo "check item can be deleted color is NOT Matched $color"
    fi;
}

select_knife_category()
{
    sleep 1
    color=$($adb shell "screencap -x 364 -y 924")

    if [ "$color" = "FF8899BB" ]; then 
        echo "select knife category color Matched" 
        $adb shell "input tap 364 924"
    else
        echo "select knife category color is NOT Matched $color"  
    fi;
}

select_ax_category()
{
    sleep 1
    color=$($adb shell "screencap -x 715 -y 929")

    if [ "$color" = "FF8899BB" ]; then 
        echo "select ax category color Matched" 
        $adb shell "input tap 715 929"
    else
        echo "select ax category color is NOT Matched $color"  
    fi;
}

collect_item()
{
    count=0
    while [[ ("$color" != "FF3B5069") && (count -le "100") ]]
    do
        color=$($adb shell screencap -x 1361 -y 1013)
        ((count++))
        sleep 1
        echo $count " collect item color is NOT Matched $color"
    done

    if [ "$count" = "101" ]; then 
        touch hit_error
        echo "touhc hit error"
        exit 1
    fi;

    echo "collect item color Matched $color"

    if [ "$color" = "FF3B5069" ]; then 
        echo "collect item color Matched" 
        $adb shell "input tap 1397 1017"
        check_outstanding_craft
        $adb shell "input tap 1160 1017"
        check_outstanding_craft
        $adb shell "input tap 957 1017"
        check_outstanding_craft
        $adb shell "input tap 756 1017"
        check_outstanding_craft
        $adb shell "input tap 591 1017"
        check_outstanding_craft
    else
        echo "collect item color is NOT Matched $color"  
    fi;
}

create_item()
{
    sleep 1
    color=$($adb shell "screencap -x 549 -y 1008")

    if [ "$color" = "FFFFFFFF" ]; then 
        echo "create item color Matched" 
        $adb shell "input tap 549 1008"
    else
        echo "create item color is NOT Matched $color"  
    fi;  
}

check_star_selected_and_click()
{
    sleep 1
    color=$($adb shell "screencap -x 203 -y 1022")

    if [ "$color" = "FF2A4F69" ]; then 
        echo "need to check star color Matched" 
        $adb shell "input tap 203 1022"
    else
        echo "need to check star color is NOT Matched $color"  
    fi;
}

click_first_started_item()
{
    sleep 1
    color=$($adb shell "screencap -x 203 -y 1022")

    if [ "$color" = "FF7DE3FF" ]; then 
        echo "start lighted and click item color Matched" 
        $adb shell "input tap 300 700"
        $adb shell "input tap 300 700"
        $adb shell "input tap 300 700"
        $adb shell "input tap 300 700"
        $adb shell "input tap 300 700"
    else
        echo "start lighted and click item color is NOT Matched $color"  
    fi;
}

collect_material()
{
    sleep 1
    echo "Collect all of the material"
    $adb shell "input tap 2150 500"
}

open_feature_list()
{
    sleep 1
    color=$($adb shell "screencap -x 2070 -y 990")

    if [ "$color" = "FF39597C" ]; then 
        echo "open feature button color Matched" 
        $adb shell "input tap 2070 990"
    else
        echo "open feature button color is NOT Matched $color" 
        $adb shell "input tap 2070 990" 
    fi;
}

open_warehouse()
{
    sleep 1
    color=$($adb shell "screencap -x 1244 -y 994")

    if [ "$color" = "FF3F7496" ]; then 
        echo "open warehouse button color Matched" 
        $adb shell "input tap 1244 994"
    else
        echo "open warehouse button color is NOT Matched $color"  
    fi;
}

open_item_info()
{
    sleep 1
    color=$($adb shell "screencap -x 393 -y 774")

    if [ "$color" = "FFFFFFFF" ]; then 
        echo "click item info color Matched" 
        $adb shell "input tap 393 774"
    else
        echo "click item info color is NOT Matched $color"  
    fi;
}

delete_item()
{
    sleep 1
    for i in `seq 1 10`;
    do
        color=$($adb shell "screencap -x 395 -y 914")

        if [ "$color" = "FFE7EDF7" ]; then 
            echo "click item delete color Matched : $i"
            $adb shell "input tap 395 914"
            if [ "$i" -eq "1" ]; then
               check_item_deletable
            fi
            sleep 1
        else
            #echo "click item delete color is NOT Matched $color" 
            echo "click  : $i" 
        fi;
    done
}

click_exsit()
{
    sleep 1
    color=$($adb shell "screencap -x 2121 -y 33")

    if [ "$color" = "FFFFFFFF" ]; then 
        echo "click exist icon color Matched" 
        $adb shell "input tap 2121 33"
    else
        echo "click exist icon color is NOT Matched $color"
        $adb shell input tap 1713 192
    fi;
}

all()
{
    collect_item
    create_item
    check_star_selected_and_click
    click_first_started_item
    collect_material
    open_feature_list
    open_warehouse
    select_ax_category
    open_item_info
    delete_item
    click_exsit
    click_exsit
}

$1