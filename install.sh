#!/system/bin/sh

MODDIR=${0%/*}

# 添加错误检查函数
check_error() {
    if [ $? -ne 0 ]; then
        ui_print "! Error: $1"
        exit 1
    fi
}

# 检查必要文件是否存在
if [ ! -f "$MODDIR/module.prop" ]; then
    ui_print "! Error: module.prop not found"
    exit 1
fi

# 版本检查
CURRENT_VERSION=$(grep_prop version "$MODDIR/module.prop")
check_error "Failed to read version"
CURRENT_VERSION_CODE=$(grep_prop versionCode "$MODDIR/module.prop")
check_error "Failed to read versionCode"

# 检查是否成功获取到版本信息
if [ -z "$CURRENT_VERSION" ] || [ -z "$CURRENT_VERSION_CODE" ]; then
    ui_print "! Error: Failed to read version information"
    ui_print "Version: $CURRENT_VERSION"
    ui_print "Version Code: $CURRENT_VERSION_CODE"
    exit 1
fi

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
if ! cat << 'EOF' > "$MODDIR/service.sh"
#!/system/bin/sh

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
EOF
then
    ui_print "! Error: Failed to create service.sh"
    exit 1
fi

# 设置服务脚本权限
set_perm "$MODDIR/service.sh" 0 0 0755
check_error "Failed to set service.sh permissions"

# 启用浮动搜索栏
ui_print "- 正在启用浮动搜索栏..."
device_config put launcher ENABLE_FLOATING_SEARCH_BAR true
settings put secure launcher.enable_floating_search_bar 1

# 检查命令是否成功执行
if [ $? -eq 0 ]; then
    ui_print "- 浮动搜索栏已成功启用"
else
    ui_print "- 警告: 无法启用浮动搜索栏,请检查权限"
fi

# 创建一个标记文件,表示模块已安装
touch "$MODDIR/module_installed"
check_error "Failed to create module_installed file"

# 设置权限
set_perm_recursive "$MODDIR" 0 0 0755 0644
check_error "Failed to set directory permissions"

# 安装完成
ui_print "- 安装完成!"
ui_print "- 服务已设置,将在系统启动后持续监控并保持浮动搜索栏启用状态"
ui_print "作者B站:Simple Compiler"
ui_print "- 请重启设备以使更改生效"
