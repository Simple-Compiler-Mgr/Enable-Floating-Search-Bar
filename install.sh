#!/system/bin/sh

MODDIR=${0%/*}

# 版本检查
CURRENT_VERSION=$(grep_prop version $MODDIR/module.prop)
CURRENT_VERSION_CODE=$(grep_prop versionCode $MODDIR/module.prop)

# 兼容性警告
ui_print "警告: 此模块仅适用于基于AOSP的类原生ROM或PixelUI"
ui_print "如果您的设备不符合要求,请按音量键取消安装"
ui_print "3秒后继续安装..."
sleep 3

# 打印安装信息
ui_print "- Pixel Floating Search Bar 正在安装..."
ui_print "- 当前版本: $CURRENT_VERSION (版本代码: $CURRENT_VERSION_CODE)"

# 创建服务脚本
ui_print "- 创建服务脚本..."
cat << EOF > $MODDIR/service.sh
#!/system/bin/sh

LOG_FILE=$MODDIR/floating_search_bar.log

log_message() {
    echo "\$(date): \$1" >> \$LOG_FILE
}

enable_floating_search_bar() {
    device_config put launcher ENABLE_FLOATING_SEARCH_BAR true
    setprop persist.sys.pixel_floating_search_bar true
    log_message "启用浮动搜索栏"
}

apply_settings() {
    if [ "\$(getprop persist.sys.pixel_floating_search_bar)" = "true" ]; then
        enable_floating_search_bar
    fi
}

# 在启动时应用设置
apply_settings

# 监听属性变化
while true
do
    CURRENT_STATE=\$(device_config get launcher ENABLE_FLOATING_SEARCH_BAR)
    if [ "\$CURRENT_STATE" != "true" ]; then
        log_message "检测到浮动搜索栏被关闭，正在重新启用"
        enable_floating_search_bar
    fi
    sleep 5
done
EOF

# 设置服务脚本权限
set_perm $MODDIR/service.sh 0 0 0755

# 启用浮动搜索栏
ui_print "- 正在启用浮动搜索栏..."
device_config put launcher ENABLE_FLOATING_SEARCH_BAR true
setprop persist.sys.pixel_floating_search_bar true

# 检查命令是否成功执行
if [ $? -eq 0 ]; then
    ui_print "- 浮动搜索栏已成功启用"
else
    ui_print "- 警告: 无法启用浮动搜索栏,请检查权限"
fi

# 创建一个标记文件,表示模块已安装
touch $MODDIR/module_installed

# 设置权限
set_perm_recursive $MODDIR 0 0 0755 0644

# 安装完成
ui_print "- 安装完成!"
ui_print "- 服务已设置,将持续监控并保持浮动搜索栏启用状态"
ui_print "作者B站:Simple Compiler"
ui_print "- 请重启设备以使更改生效"
