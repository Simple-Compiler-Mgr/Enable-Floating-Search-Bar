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


##其他
v1.2
这个新版本的脚本做了以下改进：
使用持久化的系统属性 persist.sys.pixel_floating_search_bar 来保存设置状态。
在启动时检查并应用设置。
每5秒检查一次浮动搜索栏的状态，如果被关闭则重新启用。
不再频繁重启启动器，以减少对用户体验的影响。
v1.3
增加了更详细的日志记录，包括当前状态、持久化属性、系统属性和最近活动。
每次检测到浮动搜索栏被关闭时，不仅重新启用它，还会强制停止并重新启动启动器。
检查间隔缩短到2秒，以更快地响应变化。
添加了 debug_info 函数，在每次重新启用时记录详细信息。
