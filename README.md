# Pixel Floating Search Bar

## 描述
这个Magisk模块启用Google Pixel设备上的浮动搜索栏功能。它专为基于AOSP的类原生ROM或PixelUI设计。

## 版本信息
- 版本：v1.1
- 版本代码：2
- 作者：Simple-Compiler
- 最低Magisk版本要求：19000

## 功能
- 启用Google Pixel浮动搜索栏
- 每5分钟自动重新启用浮动搜索栏，确保功能持续可用

## 安装要求
- 基于AOSP的类原生ROM或PixelUI
- Magisk 19.0或更高版本

## 安装步骤
1. 在Magisk Manager中刷入此模块
2. 重启设备
3. 享受Pixel风格的浮动搜索栏！

## 技术细节
- 模块ID：pixel_floating_search_bar
- 安装脚本：使用标准的Magisk模块模板
- 服务脚本：每5分钟执行一次`device_config put launcher ENABLE_FLOATING_SEARCH_BAR true`命令
- 权限设置：模块文件夹权限设置为0755，文件权限设置为0644

## 注意事项
- 此模块仅适用于基于AOSP的类原生ROM或PixelUI
- 如果遇到问题，请检查设备是否符合兼容性要求
- 安装过程中会显示版本信息和兼容性警告

## 故障排除
如果浮动搜索栏未显示：
1. 确保您的ROM兼容此模块
2. 在终端中手动执行`device_config put launcher ENABLE_FLOATING_SEARCH_BAR true`
3. 如果仍然不工作，请检查Magisk日志以获取更多信息

## 更新日志
### v1.1
- 添加版本检查功能
- 优化安装脚本
- 更新模块描述

### v1.0
- 初始版本发布

## 联系方式
作者B站：Simple Compiler


## 免责声明
本模块按原样提供，作者不对因使用此模块造成的任何损失负责。请在安装前备份重要数据。


## 其他
### v1.2
这个新版本的脚本做了以下改进：
1.使用持久化的系统属性 persist.sys.pixel_floating_search_bar 来保存设置状态。
2.在启动时检查并应用设置。
3.每5秒检查一次浮动搜索栏的状态，如果被关闭则重新启用。
4.不再频繁重启启动器，以减少对用户体验的影响。
### v1.3
1.增加了更详细的日志记录，包括当前状态、持久化属性、系统属性和最近活动。
2.每次检测到浮动搜索栏被关闭时，不仅重新启用它，还会强制停止并重新启动启动器。
3.检查间隔缩短到2秒，以更快地响应变化。
4.添加了 debug_info 函数，在每次重新启用时记录详细信息。
### v1.4
1.使用多种方法设置浮动搜索栏状态（device_config, settings, 和 setprop）。
2.检查间隔缩短到1秒，以更快地响应变化。
3.增加了更详细的调试信息，包括使用 settings 命令检查的状态。
4.在脚本开始时就记录调试信息，以便了解初始状态。
5.添加了对当前前台应用的检查。
### v1.5
1.用 inotifywait 命令来监听系统设置文件的变化，而不是定期检查。这样可以更快地响应设置的变化。
2.当检测到设置文件变化时，立即检查浮动搜索栏的状态并在需要时重新启用。
3.保留了详细的日志记录，以便于排查问题。
### v1.5 Rebuild
1.添加了一个拦截库，尝试拦截可能导致设置改变的系统调用。
2.持续监控并每秒强制设置一次浮动搜索栏状态。
3.增加了更多的调试信息，包括Launcher进程的状态。
请注意，这个方法使用了一些高级技术，可能需要root权限才能正常工作。同时，由于持续监控和强制设置，可能会增加一些系统负担。

## v1.6 
1.添加了错误检查函数
2.检查必要文件是否存在
3.验证版本信息是否成功读取
4. 添加了更多的错误处理和日志输出
5.使用引号包裹所有的文件路径
6.使用 'EOF' 来防止变量扩展
