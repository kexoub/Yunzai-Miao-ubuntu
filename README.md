# Yunzai

## 介绍

云崽机器人安卓一键部署，目前支持云崽V3本体以及部分V3插件包一键部署。

目前支持的系统：  
安卓ubuntu22
服务器ubuntu22

目前支持的版本：
V3（应该不会还有人想用V2吧）

### 开始  
在您的linux控制台中输入如下代码并回车运行
```
bash <(curl -sSL https://linuxmirrors.cn/main.sh)
```

### 原脚本仓库
[原仓库](https://gitee.com/fw-cn/Yunzai)


## 手机端部署
### 前期准备
先下载下面两个软件(直接点击链接即可下载)
- termux下载地址：https://f-droid.org/repo/com.termux_118.apk
- 滑动验证助手下载地址：https://maupdate.rainchan.win/txcaptcha.apk

### 开始运行  
在termux中输入如下代码并回车运行
```
curl -sL https://github.com/kexoub/Yunzai-Miao-ubuntu/raw/main/u.sh | bash
```
出现字样提示ubuntu安装完成
![输入图片说明](readme%E6%8F%92%E5%85%A5%E5%9B%BE%E7%89%87/ubuntu%E5%AE%89%E8%A3%85%E5%AE%8C%E6%88%90.png)
随后输入u并回车，进入ubuntu容器
![输入图片说明](readme%E6%8F%92%E5%85%A5%E5%9B%BE%E7%89%87/%E8%BF%9B%E5%85%A5%E5%AE%B9%E5%99%A8.png)
依次输入如下代码并回车
```
apt update && apt install curl wget unzip -y
```
### **运行一键安装脚本** 
```
bash <(curl -sL https://github.com/kexoub/Yunzai-Miao-ubuntu/raw/main/Miao-Yunzai-Shell.sh)
```
最后输入如下内容并回车即可启动机器人
```
yz
```
即可对机器人进行配置。  
手机部署视频教程：【原神机器人Yunzai-Bot一键部署教程-哔哩哔哩】 https://b23.tv/vBxeKcy
其余配置相关问题请自行寻找答案或者寻找相关交流群。

## 服务器端部署
```
sudo -i
```
```
bash <(curl -sL https://gitee.com/jizijhj/Yunzai/raw/main/Miao-Yunzai-Shell.sh)
```
(用服务器的人应该不用教太多吧)
