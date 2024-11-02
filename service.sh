#!/system/bin/sh

# 确保只有一个实例在运行
PIDFILE=/data/adb/modules/pixel_floating_search_bar/floating_search.pid

if [ -f $PIDFILE ]; then
    PID=$(cat $PIDFILE)
    if [ -d "/proc/$PID" ]; then
        exit 1
    fi
fi

echo $$ > $PIDFILE

# 持续监控并强制设置
while true
do
    # 启用浮动搜索栏
    device_config put launcher ENABLE_FLOATING_SEARCH_BAR true
    settings put secure launcher.enable_floating_search_bar 1
    
    # 检查当前状态
    CURRENT_STATE_1=$(device_config get launcher ENABLE_FLOATING_SEARCH_BAR)
    CURRENT_STATE_2=$(settings get secure launcher.enable_floating_search_bar)
    
    # 如果状态不正确，重启启动器
    if [ "$CURRENT_STATE_1" != "true" ] || [ "$CURRENT_STATE_2" != "1" ]; then
        am force-stop com.google.android.apps.nexuslauncher
        am start -n com.google.android.apps.nexuslauncher/.NexusLauncherActivity
    fi
    
    sleep 1
done & 