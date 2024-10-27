#!/system/bin/sh

MODDIR=${0%/*}

# 兼容性警告
ui_print "警告: 此模块仅适用于基于AOSP的类原生ROM或PixelUI"
ui_print "如果您的设备不符合要求,请按音量键取消安装"
ui_print "3秒后继续安装..."
sleep 3

# 打印安装信息
ui_print "- Pixel Floating Search Bar 正在安装..."

# 创建服务脚本
ui_print "- 创建服务脚本..."
cat << EOF > $MODDIR/service.sh
#!/system/bin/sh
while true
do
    device_config put launcher ENABLE_FLOATING_SEARCH_BAR true
    sleep 300
done
EOF

# 设置服务脚本权限
set_perm $MODDIR/service.sh 0 0 0755

# 启用浮动搜索栏
ui_print "- 正在启用浮动搜索栏..."
device_config put launcher ENABLE_FLOATING_SEARCH_BAR true

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
ui_print "- 服务已设置,将每5分钟自动启用浮动搜索栏"
ui_print "作者B站:Simple Compiler"
ui_print "- 请重启设备以使更改生效"
