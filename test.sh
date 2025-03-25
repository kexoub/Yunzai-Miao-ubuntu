#!/bin/bash
cd ~

function Centrol()
{
    a=$(stty size)
    b=${#str}
    c=${a#* }
    d=$(($((c/2))-$((b/2))+b))
    printf "%*s\n" $d $str
}
function Yunzai()
{
	clear
str=*********************************************
Centrol
echo
str=Yunzai-Bot一键安装
Centrol
str=项目地址：[gitee]https://gitee.com/Le-niao/Yunzai-Bot
Centrol
str=[github]https://github.com/Le-niao/Yunzai-Bot
Centrol
echo       
str=*********************************************
Centrol           
echo 1.部署Yunzai-Bot并安装喵喵插件
echo
echo 2.启动机器人
echo
echo 3.关闭机器人
echo
echo 4.插件管理
echo
echo 5.启动报错解决
echo
echo 6.重新配置机器人QQ号（可能需要重新验证）
echo
echo 7.安装python3.8版本
echo
echo 8.安装python3.10版本
echo 
echo 9.安装ffmpeg
echo
echo 10.更改主人QQ
echo 
echo 11.没记住各种快捷代码？再看一次！
echo
echo 12.友情链接
echo
echo 13.觉得这个脚本不好用？转接到其他脚本！
echo          
echo 0.退出脚本
echo
str=*********************************************
Centrol
}
function YunzaiNum()
{
    read -p "请输入上述操作前对应的数字：" yunzaiNum
    case $yunzaiNum in
		0)
            exit 0
            ;;
        1)
            YunzaiBotInstall
            ;;
        2)
            Run
            ;;
        3)
            Stop
            ;;
        4)
            Plugin
            ;;
        5)
            Repaire
            ;;
        6)
            Reconfig
            ;;
        7)
            PythonInstall_1
            ;;
        8)
            PythonInstall_2
            ;;
        9)
            FfmpegInstall
            ;;
        10)
            MasterQQ
            ;;
		11)
			Review
			;;
		12)
			LineLink
			;;
        13)
            Change
            ;;
        999)
            test
            ;;
        *)
            clear
            echo
            figlet ?  ?  ?
            echo -e '\n\n\n'
            echo '您输入的数字不是可用选项，请确认输入正确'
            echo
            echo '您输入的数字不是可用选项，请确认输入正确'
            echo
            echo '您输入的数字不是可用选项，请确认输入正确'
            sleep 3s
            Yunzai
            YunzaiNum
            ;;
    esac
}
function YunzaiBotInstall()
{	
	clear
	echo '您正在进行机器人部署步骤！请确保个人网络全程通畅！'
	sleep 3s

    #安装git
    if ! type git >/dev/null 2>&1; then
        echo '正在准备安装git'
	    sleep 0.5s
        echo '正在准备安装git'
	    sleep 0.5s
        echo '正在准备安装git'
	    sleep 0.5s
        apt update
        apt install git -y
        echo 'git安装完成'
        sleep 1s
    else
        echo '已安装git，不再重复安装'
        sleep 1.5s
    fi

    #安装nodejs
	if ! type npm >/dev/null 2>&1; then
        rm -rf /root/node
		echo '未检测到nodejs，准备进行安装'
        echo '正在准备安装nodejs中……'
	    sleep 0.5s
	    echo '正在准备安装nodejs中……'
	    sleep 0.5s
	    echo '正在准备安装nodejs中……'
	    sleep 0.5s
	    #下载nodejs
        git clone --depth=1 https://gitee.com/fw-cn/yunzai-bot-nodejs.git ./node/
        if [ $(uname -m) == "aarch64" ]; then
            cp /root/node/node-v17.9.0-linux-arm64.tar.gz /home/
            rm -rf /root/node
            cd /home/
            #解压
            mkdir node17.9.0
            tar -zxvf node-v17.9.0-linux-arm64.tar.gz -C node17.9.0 --strip-components 1
            rm -rf node-v17.9.0-linux-arm64.tar.gz
        elif [ $(uname -m) == "x86_64" ]; then
            cp /root/node/node-v17.9.0-linux-x64.tar.gz /home/
            rm -rf /root/node
            cd /home/
            #解压
            mkdir node17.9.0
            tar -zxvf node-v17.9.0-linux-x64.tar.gz -C node17.9.0 --strip-components 1
            rm -rf node-v17.9.0-linux-x64.tar.gz
        fi
        #进行软链接
        ln -sf /home/node17.9.0/bin/node /usr/local/bin
        ln -sf /home/node17.9.0/bin/npm /usr/local/bin
        ln -sf /home/node17.9.0/bin/npx /usr/local/bin
        PATH=/usr/local/node17.9.0/bin:$PATH
        if ! type npm >/dev/null 2>&1; then
            echo 'nodejs安装失败，请重新运行脚本重试，或自行下载';
            exit
        else
            echo 'nodejs安装成功'
            sleep 1.5s
        fi
    else
        echo '已安装nodejs，不再重复安装'
        sleep 1.5s
	fi

    #安装redis
    if ! type redis-server >/dev/null 2>&1; then
        echo '正在准备安装并启动redis'
	    sleep 0.5s
	    echo '正在准备安装并启动redis'
	    sleep 0.5s
	    echo '正在准备安装并启动redis'
	    sleep 0.5s
        apt-get install redis -y
        redis-server --daemonize yes --save 900 1 --save 300 10
        echo 'redis安装且启动成功'
	    sleep 1.5s
    else
        echo '已安装redis，不再重复安装'
        redis-server --daemonize yes --save 900 1 --save 300 10
        echo '已启动redis'
    fi

    #安装chroimum
    if ! type chromium-browser >/dev/null 2>&1; then
        echo '正在准备安装chromuim及中文字体'
	    sleep 0.5s
	    echo '正在准备安装chromuim及中文字体'
	    sleep 0.5
	    echo '正在准备安装chromuim及中文字体'chro
	    sleep 0.5
        apt install chromium-browser -y
        apt install -y --force-yes --no-install-recommends fonts-wqy-microhei
	    echo '安装成功'
	    sleep 1.5s
    else
        echo '已安装chromium,正在安装中文字体'
        sleep 0.5s
        echo '已安装chromium,正在安装中文字体'
        sleep 0.5s
        echo '已安装chromium,正在安装中文字体'
        sleep 0.5s
        apt install -y --force-yes --no-install-recommends fonts-wqy-microhei
        echo '安装成功'
        sleep 1.5s
    fi

	#克隆云崽项目
    cd ~/
	if [ -e Yunzai-Bot ];then
		echo -e '已有机器人文件或同名文件\n请选择删除文件重新下载，或选择忽略'
		read -p '输入1删除并重新下载，输入0忽略（别忘记回车）：' number
		if [ $number == 1 ];then
			#删除文件夹
			echo '正在删除已有文件……'
			rm -rf Yunzai-Bot
			echo '删除完成'
			sleep 1s
			echo '正在准备重新部署机器人项目'
			sleep 1s
			git clone --depth=1 https://gitee.com/Le-niao/Yunzai-Bot.git
			sleep 1s
			echo '机器人项目部署完成'
		elif [ $number == 0 ];then
			echo '已忽略，不再重新下载机器人项目文件'
		fi
	else
		echo '正在准备下载机器人项目文件……'
		sleep 1s
		git clone --depth=1 https://gitee.com/Le-niao/Yunzai-Bot.git
		echo '机器人项目文件下载完成'
		sleep 3s
	fi		
	
	#安装云崽依赖
    cd ~/Yunzai-Bot
	echo '正在准备安装机器人依赖……'
	sleep 1s
    npm install pnpm -g
	ln -sf /home/node17.9.0/bin/pnpm /usr/local/bin
    pnpm install -P
    echo '机器人依赖部署完成'
	sleep 1.5s
	
	#部署喵喵插件
	echo '准备安装喵喵插件，支持查询游戏内角色面板、群面板排行等信息'
    sleep 1s
	cd ~/Yunzai-Bot/plugins
	if  [ -e miao-plugin ];then
	read -p '已有喵喵插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载喵喵插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf miao-plugin
			git clone --depth=1 https://gitee.com/yoimiya-kokomi/miao-plugin.git
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/yoimiya-kokomi/miao-plugin.git
		echo '喵喵插件安装完成'
		sleep 1s
	fi
    cd ~/Yunzai-Bot && pnpm add image-size axios express multer body-parser jsonwebtoken systeminformation -w
	
	#写入启动代码 
    echo echo 正在启动机器人 > /usr/bin/yz
    sed -i -e '1a redis-server --daemonize yes --save 900 1 --save 300 10 && cd ~/Yunzai-Bot && node app' /usr/bin/yz
    chmod 777 /usr/bin/yz
    echo echo 正在后台启动机器人 > /usr/bin/yzstart
	sed -i -e '1a cd ~/Yunzai-Bot && pnpm start' /usr/bin/yzstart
	chmod 777 /usr/bin/yzstart
    echo echo 查看机器人日志 > /usr/bin/yzlog
    sed -i -e '1a cd ~/Yunzai-Bot && pnpm run log' /usr/bin/yzlog 
    chmod 777 /usr/bin/yzlog
    echo echo 正在停止机器人 > /usr/bin/yzstop
    sed -i -e '1a cd ~/Yunzai-Bot && pnpm stop' /usr/bin/yzstop
    chmod 777 /usr/bin/yzstop
    echo echo 正在启动长楠脚本 > /usr/bin/cn
    sed -i -e '1a bash <(curl -sL https://gitee.com/fw-cn/Yunzai/raw/master/Yunzai-Bot-Shell.sh)' /usr/bin/cn
    chmod 777 /usr/bin/cn
	clear

    echo -e '\033[32m执行完成\033[0m'
    echo -e "重新打开本脚本请输入：\033[47;32mcn\033[0m"
    echo -e "启动机器人请输入\033[47;32myz\033[0m"
    echo -e "机器人后台启动运行（即不显示代码启动）请输入：\033[47;32myzstart\033[0m"
    echo -e "显示机器人日志请输入：\033[47;32myzlog\033[0m"
    echo -e "停止机器人后台运行请输入：\033[47;32myzstop\033[0m"
	echo -e "已安装喵喵、图鉴插件，机器人正常运行后输入【\033[47;34m#喵喵帮助\033[0m】、【\033[47;34m#图鉴帮助\033[0m】以分别查看帮助面板"
    echo -e '现在请输入\033[43;32mnode app\033[0m或\033[43;32myz\033[0m以启动机器人并进行配置'
    echo '结束，跑路'
    echo '赞美乐神'
    exit
}

#启动机器人
function Run()
{
	if [ -e /root/Yunzai-Bot ];then
    clear
    echo '正在启动云崽机器人'
	sleep 1s
	redis-server --daemonize yes --save 900 1 --save 300 10 && cd ~/Yunzai-Bot && node app
	else
	echo '请先安装云崽后再进行该操作！'
	sleep 1s
	echo '请先安装云崽后再进行该操作！'
	sleep 1s
	echo '请先安装云崽后再进行该操作！'
	sleep 1s
	Yunzai
	YunzaiNum
	fi
}

#关闭机器人
function Stop()
{
	if [ -e /root/Yunzai-Bot ];then
	echo '正在关闭机器人'
	sleep 1s
	cd ~/Yunzai-Bot && pnpm stop
	else
	echo '请先安装云崽后再进行该操作！'
	sleep 1s
	echo '请先安装云崽后再进行该操作！'
	sleep 1s
	echo '请先安装云崽后再进行该操作！'
	sleep 1s
	Yunzai
	YunzaiNum
	fi
}

#插件管理
function Plugin()
{
function PluginIndex()
{
	clear
    cat <<out
*******************************************************

                    plugin插件管理

*******************************************************

	1.安装插件          |          2.删除插件
	 
	3.返回              |          0.退出脚本

*******************************************************
out
}
function PluginIndexNum()
{
	read -p '请输入数字选项并回车：' indexNum
	case $indexNum in
        0)
			exit
            ;;
        1)
            PluginInstall
            ;;
        2)
            DelPlugin
            ;;
		3)
            Yunzai
			YunzaiNum
			;;
        *)
            clear
            echo
            figlet ?  ?  ?
            echo -e '\n\n\n'
            echo '你输入的数字不是可用选项，请确认输入内容正确'
            echo
            echo '你输入的数字不是可用选项，请确认输入内容正确'
            echo
            echo '你输入的数字不是可用选项，请确认输入内容正确'
            sleep 3s
            PluginIndex
            PluginIndexNum
            ;;
    esac
}
function PluginInstall()
{
function InstallList()
{
	clear
    cat <<out
*******************************************************

                     plugin插件列表
            本列表来源：渔火云崽插件索引目录
      gitee.com/yhArcadia/Yunzai-Bot-plugins-index

*******************************************************

 1.【锅巴插件】#锅巴帮助          可视化的云崽管理
 2.【抽卡插件】#抽卡帮助          更优化的抽卡体验
 3.【成就插件】#成就帮助            科学的成就录入
 4.【白纸插件】#白纸帮助          b站直播投稿及动态推送
 5.【闲心插件】#闲心帮助          b站推送与群聊小游戏
 6.【土块插件】#土块帮助          ai绘图为主的娱乐插件
 7.【小飞插件】#小飞帮助          群聊娱乐插件
 8.【麟插件】#lin帮助/#ai帮助     部分群聊娱乐功能
 9.【椰奶插件】#椰奶帮助          群聊管理与娱乐功能
10.【小月插件】#小月帮助          提供群聊娱乐功能
11.【虚空插件】#虚空帮助          群内决斗等娱乐功能
12.【清凉图插件】#清凉图帮助      获取一些比较清凉的图片
13.【小叶插件】#小叶帮助          模拟刷取圣遗物功能
14.【榴莲插件】#榴莲帮助          原神地下地图与b站推送
15.【ap插件】ap帮助               提供ai绘图与搜图等功能
16.【脆脆鲨插件】#脆脆鲨帮助       基于云崽的功能插件
17.【光遇插件】sky帮助            为云崽提供光遇相关插件
18.【拓展插件】#拓展帮助          为云崽提供拓展功能
19.【碎月插件】暂无帮助指令       疯狂星期四等娱乐功能 
20.【Atlas插件】暂无帮助指令      提供原神各种图鉴信息
21.【止水插件】暂无帮助指令        提供搜剧功能
22.【自动化插件】暂无帮助指令     自动群名片与一些小功能
23.【WeLM插件】#welm帮助          提供机器人对话功能
24.【图鉴插件】#图鉴帮助          原神各种图鉴资源查询

 0.返回

*******************************************************
out
}
function PluginInstallNum()
{
    read -p '请输入数字选项并回车：' pluginInstallNum
    case $pluginInstallNum in
        0)
            PluginIndex
			PluginIndexNum
            ;;
        1)
            guoba
            ;;
        2)
            gacha
            ;;
        3)
            achievement
            ;;
        4)
            zhi
            ;;
        5)
            xianxin
            ;;
        6)
            earthk
            ;;
        7)
            xiaofei
            ;;
        8)
            lin
            ;;
        9)
			yenai
			;;
		10)
			xiaoyue
			;;
		11)
			akasha
			;;
		12)
			xwy
			;;
		13)
			xiaoye
			;;
		14)
			liulian
			;;
		15)
			ap
			;;
		16)
			cuicuisha
			;;
		17)
			sky
			;;
		18)
			tuozhan
			;;
		19)
			suiyue
			;;
		20)
			altas
			;;
		21)
			zhishui
			;;
		22)
			auto
			;;
		23)
			welm
			;;
        24)
            xiaoyao
            ;;
        *)
            clear
            echo
            figlet ?  ?  ?
            echo '\n\n\n'
            echo '您输入的数字不是可安装插件，请确认输入内容正确'
            echo
            echo '您输入的数字不是可安装插件，请确认输入内容正确'
            echo
            echo '您输入的数字不是可安装插件，请确认输入内容正确'
            sleep 3s
            InstallList
            PluginInstallNum
            ;;
	esac
}

#锅巴插件安装
function guoba()
{
	cd ~/Yunzai-Bot/plugins
	if [ -e Guoba-Plugin ];then
	read -p '已有锅巴插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载锅巴插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf Guoba-Plugin
			git clone --depth=1 https://gitee.com/guoba-yunzai/guoba-plugin.git ./Guoba-Plugin/
			cd ~/Yunzai-Bot && pnpm add image-size axios express multer body-parser jsonwebtoken systeminformation -w
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/guoba-yunzai/guoba-plugin.git ./Guoba-Plugin/
		cd ~/Yunzai-Bot && pnpm add image-size axios express multer body-parser jsonwebtoken systeminformation -w
		echo '锅巴插件安装成功'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#抽卡插件安装
function gacha()
{	
	cd ~/Yunzai-Bot/plugins
	if  [ -e flower-plugin ];then
	read -p '已有抽卡插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载抽卡插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf flower-plugin
			git clone --depth=1 https://gitee.com/Nwflower/flower-plugin.git ./flower-plugin/
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/Nwflower/flower-plugin.git ./flower-plugin/
		echo '抽卡插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#成就插件安装
function achievement()
{	
	cd ~/Yunzai-Bot/plugins
	if  [ -e achievement ];then
	read -p '已有成就插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载成就插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf achievement
			git clone --depth=1 https://gitee.com/zolay-poi/achievements-plugin.git ./achievements-plugin/
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/zolay-poi/achievements-plugin.git ./achievements-plugin/
		echo '成就插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#白纸插件安装
function zhi()
{	
	cd ~/Yunzai-Bot/plugins
	if  [ -e zhi ];then
	read -p '已有白纸插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载白纸插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf zhi-plugin
			git clone --depth=1 https://gitee.com/headmastertan/zhi-plugin.git ./zhi-plugin/
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/headmastertan/zhi-plugin.git ./zhi-plugin/
		echo '白纸插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#闲心插件安装
function xianxin()
{	
	cd ~/Yunzai-Bot/plugins
	if  [ -e xianxin-plugin ];then
	read -p '已有闲心插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载闲心插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf xianxin-plugin
			git clone --depth=1 https://gitee.com/xianxincoder/xianxin-plugin.git ./xianxin-plugin/
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/xianxincoder/xianxin-plugin.git ./xianxin-plugin/
		echo '闲心插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#光遇插件安装
function sky()
{
	cd ~/Yunzai-Bot/plugins
	if  [ -e Tlon-Sky ];then
	read -p '已有光遇插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载光遇插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf Tlon-Sky
			git clone --depth=1 https://gitee.com/Tloml-Starry/Tlon-Sky.git ./Tlon-Sky/
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/Tloml-Starry/Tlon-Sky.git ./Tlon-Sky/
		echo '光遇插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#土块插件安装
function earthk()
{
	cd ~/Yunzai-Bot/plugins
	if  [ -e earth-k-plugin ];then
	read -p '已有土块插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载土块插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf earth-k-plugin
			git clone --depth=1 https://gitee.com/SmallK111407/earth-k-plugin.git ./earth-k-plugin/
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/SmallK111407/earth-k-plugin.git ./earth-k-plugin/
		echo '土块插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#小飞插件安装
function xiaofei()
{
	cd ~/Yunzai-Bot/plugins
	if  [ -e xiaofei-plugin ];then
	read -p '已有小飞插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载小飞插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf xiaofei-plugin
			git clone --depth=1 https://gitee.com/xfdown/xiaofei-plugin.git ./xiaofei-plugin/
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/xfdown/xiaofei-plugin.git ./xiaofei-plugin/
		echo '小飞插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#麟插件安装
function lin()
{	
	cd ~/Yunzai-Bot/plugins
	if  [ -e lin-plugin ];then
	read -p '已有麟插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载麟插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf lin-plugin
			git clone --depth=1 https://gitee.com/go-farther-and-farther/lin-plugin.git ./lin-plugin/
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/go-farther-and-farther/lin-plugin.git ./lin-plugin/
		echo '麟插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#椰奶插件安装
function yenai()
{
	cd ~/Yunzai-Bot/plugins
	if  [ -e yenai-plugin ];then
	read -p '已有椰奶插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载椰奶插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf yenai-plugin
			git clone --depth=1 https://gitee.com/yeyang52/yenai-plugin.git ./yenai-plugin/
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/yeyang52/yenai-plugin.git ./yenai-plugin/
		echo '椰奶插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#小月插件安装
function xiaoyue()
{	
	cd ~/Yunzai-Bot/plugins
	if  [ -e xiaoyue-plugin ];then
	read -p '已有小月插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载小月插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf recreation-plugin
			git clone --depth=1 https://gitee.com/yunxiyuan/xiaoyue-plugin.git ./xiaoyue-plugin
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/yunxiyuan/xiaoyue-plugin.git ./xiaoyue-plugin
		echo '小月插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#小叶插件安装
function xiaoye()
{
	cd ~/Yunzai-Bot/plugins
	if  [ -e xiaoye-plugin ];then
	read -p '已有小叶插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载小叶插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf xiaoye-plugin
			git clone --depth=1 https://gitee.com/xiaoye12123/xiaoye-plugin.git ./xiaoye-plugin/
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/xiaoye12123/xiaoye-plugin.git ./xiaoye-plugin/
		echo '小叶插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#榴莲插件安装
function liulian()
{
	cd ~/Yunzai-Bot/plugins
	if  [ -e liulian-plugin ];then
	read -p '已有榴莲插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载榴莲插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf liulian-plugin
			git clone --depth=1 https://gitee.com/huifeidemangguomao/liulian-plugin.git ./liulian-plugin/
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/huifeidemangguomao/liulian-plugin.git ./liulian-plugin/
		echo '榴莲插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#部署逍遥图鉴插件
function xiaoyao()
{
	cd ~/Yunzai-Bot/plugins
	if  [ -e xiaoyao-cvs-plugin ];then
	read -p '已有图鉴插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载图鉴插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf xiaoyao-cv-plugin
			git clone --depth=1 https://gitee.com/Ctrlcvs/xiaoyao-cvs-plugin.git
			echo '已删除原图鉴并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/Ctrlcvs/xiaoyao-cvs-plugin.git
		echo '图鉴插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#ap插件安装
function ap()
{
	cd ~/Yunzai-Bot/plugins
	if  [ -e ap-plugin ];then
	read -p '已有ap插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载ap插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf ap-plugin
			git clone --depth=1 https://gitee.com/yhArcadia/ap-plugin.git ./ap-plugin/
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/yhArcadia/ap-plugin.git ./ap-plugin/
		echo 'ap插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#脆脆鲨插件安装
function cuicuisha()
{
	cd ~/Yunzai-Bot/plugins
	if  [ -e Jinmaocuicuisha-plugin ];then
	read -p '已有脆脆鲨插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载脆脆鲨插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf Jinmaocuicuisha-plugin
			git clone --depth=1 https://gitee.com/JMCCS/jinmaocuicuisha.git ./Jinmaocuicuisha-plugin/
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/JMCCS/jinmaocuicuisha.git ./Jinmaocuicuisha-plugin/
		echo '脆脆鲨插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#拓展插件安装
function tuozhan()
{
	cd ~/Yunzai-Bot/plugins
	if  [ -e expand-plugin ];then
	read -p '已有拓展插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载拓展插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf expand-plugin
			git clone --depth=1 https://gitee.com/SmallK111407/expand-plugin.git ./expand-plugin/
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/SmallK111407/expand-plugin.git ./expand-plugin/
		echo '拓展插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#清凉图插件安装
function xwy()
{
	cd ~/Yunzai-Bot/plugins
	if  [ -e yunzai-c-v-plugin ];then
	read -p '已有清凉图插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载清凉图插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf yunzai-c-v-plugin
			git clone --depth=1 https://gitee.com/xwy231321/yunzai-c-v-plugin.git ./yunzai-c-v-plugin/
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/xwy231321/yunzai-c-v-plugin.git ./yunzai-c-v-plugin/
		echo '清凉图插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#止水插件安装
function zhishui()
{
	cd ~/Yunzai-Bot/plugins
	if  [ -e zhishui-plugin ];then
	read -p '已有止水插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载止水插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf zhishui-plugin
			git clone --depth=1 https://gitee.com/fjcq/zhishui-plugin.git ./zhishui-plugin/
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/fjcq/zhishui-plugin.git ./zhishui-plugin/
		echo '止水插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#自动化插件安装
function auto()
{
	cd ~/Yunzai-Bot/plugins
	if  [ -e auto-plugin ];then
	read -p '已有自动化插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载自动化插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf auto-plugin
			git clone --depth=1 https://gitee.com/Nwflower/auto-plugin.git ./auto-plugin/
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/Nwflower/auto-plugin.git ./auto-plugin/
		echo '自动化插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#碎月插件安装
function suiyue()
{
	cd ~/Yunzai-Bot/plugins
	if  [ -e suiyue ];then
	read -p '已有碎月插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载碎月插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf suiyue
			git clone --depth=1 https://gitee.com/Acceleratorsky/suiyue.git ./suiyue/
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/Acceleratorsky/suiyue.git ./suiyue/
		echo '碎月插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#atlas插件安装
function altas()
{
	cd ~/Yunzai-Bot/plugins
	if  [ -e Altas ];then
	read -p '已有altas图鉴插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载altas图鉴插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf Altas
			git clone --depth=1 https://gitee.com/Nwflower/atlas ./Altas/
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/Nwflower/atlas ./Altas/
		echo 'altas图鉴插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#welm插件安装
function welm()
{
	cd ~/Yunzai-Bot/plugins
	if  [ -e WeLM-plugin ];then
	read -p '已有welm插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载welm插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf WeLM-plugin
			git clone -b master --depth=1 https://gitee.com/shuciqianye/yunzai-custom-dialogue-welm.git ./WeLM-plugin/
			cd ~/Yunzai-Bot && pnpm add image-size axios express multer body-parser jsonwebtoken systeminformation -w
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone -b master --depth=1 https://gitee.com/shuciqianye/yunzai-custom-dialogue-welm.git ./WeLM-plugin/
		cd ~/Yunzai-Bot && pnpm add image-size axios express multer body-parser jsonwebtoken systeminformation -w
		echo 'welm插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#虚空插件安装

function akasha()
{
	cd ~/Yunzai-Bot/plugins
	if  [ -e akasha-terminal-plugin ];then
	read -p '已有虚空插件，是否删除原有插件重新下载，输入1重新下载，输入0忽略：' num
		if [ $num == 0 ];then
			echo '已忽略，不再重新下载虚空插件'
			sleep 1s
		elif [ $num == 1 ];then
			rm -rf akasha-terminal-plugin
			git clone --depth=1 https://gitee.com/go-farther-and-farther/akasha-terminal-plugin.git ./akasha-terminal-plugin/
			echo '已删除原插件并重新下载'
			sleep 1s
		fi
	else
		git clone --depth=1 https://gitee.com/go-farther-and-farther/akasha-terminal-plugin.git ./akasha-terminal-plugin/
		echo '虚空插件安装完成'
		sleep 1s
	fi
	InstallList
	PluginInstallNum
}

#进行一次plugin插件列表运行

InstallList
PluginInstallNum

}

#插件删除，摆烂了，就这样吧

function DelPlugin()
{
	clear
    echo -e '\n\n'
	echo '**************    已安装插件    ***************'
    echo -e '\n'
    for file in `ls ~/Yunzai-Bot/plugins`;do
        if [ "$file" != "example" ] && [ "$file" != "other" ] && [ "$file" != "system" ] && [ "$file" != "genshin" ];then
		    echo -e "\t\t\033[32m$file\033[0m"
            echo
        fi
	done
    echo
    echo '***********************************************'
    echo -e '\n\n'
    echo '请输入你要删除的插件名称,输入0并回车以返回'
    echo
	read -p '请在删除前三思，请勿误删：' pluginname
	if [ -e ~/Yunzai-Bot/plugins/$pluginname ];then
		rm -rf ~/Yunzai-Bot/plugins/$pluginname
        echo
		echo -e '正在删除插件…… '
        sleep 1s
		if [ -e ~/Yunzai-Bot/plugins/$pluginname ];then
            echo
			echo -e '插件删除失败，请重新删除'
			sleep 1.5s
            PluginIndex
            PluginIndexNum
		else
            echo
			echo -e '插件删除成功'
            sleep 1s
            PluginIndex
            PluginIndexNum
			fi
	elif [ $pluginname == 0 ];then
        PluginIndex
        PluginIndexNum
    else
        echo
		echo '输入的插件名称不正确或不存在该插件！请确保你输入了正确的插件全称！'
		sleep 1s
        DelPlugin
	fi
}

#判断是否已经有云崽项目后再进行插件管理

cd ~
if  [ -e /root/Yunzai-Bot ];then
PluginIndex
PluginIndexNum
else
echo "请先安装云崽后再进行插件管理！"
sleep 1s
echo "请先安装云崽后再进行插件管理！"
sleep 1s
echo "请先安装云崽后再进行插件管理！"
sleep 1s
fi

}

#报错修复

function Repaire()
{
function RepaireList()
{
	clear
    cat <<run
*******************************************************

                 请按照报错内容进行选择
				 
*******************************************************

1.QQ版本过低

2.cannot find package 'oicq'

3.等待后续补充

4.返回

0.退出脚本

*******************************************************
run
}
function RepaireNum()
{
    read -p '请按照你所出现的报错的内容进行选择：' repaireNum
	case $repaireNum in
        0)
			exit
            ;;
        1)
            QQ-repaire
            ;;
        2)
            oicq-repaire
            ;;
        3)
            waiting
            ;;
		4)
			Yunzai
			YunzaiNum
			;;
        *)
            clear
            echo
            figlet ?  ?  ?
            echo -e '\n\n\n'
            echo '您输入的数字不是可用选项，请确认输入正确'
            echo
            echo '您输入的数字不是可用选项，请确认输入正确'
            echo
            echo '您输入的数字不是可用选项，请确认输入正确'
            sleep 3s
            RepaireList
            RepaireNum
            ;;
    esac
}
function QQ-repaire()
{
function QQ-repaire-list()
{
    clear
    cat <<out
*******************************************************

                QQ版本过低

            请依次尝试下列解决选项

*******************************************************

1.修改端口与device文件

2.修改端口与subid

3.go-cqhttp获取token

4.你在想什么，上面这些都寄了的话，那就老老实实换号吧

0.返回

*******************************************************
out
}
function QQ-repaire-num()
{
    read -p '请输入数字选项：' num
    case $num in
        0)
            RepaireList
            RepaireNum
            ;;
        1)
            device
            ;;
        2)
            subid
            ;;
        3)
            token
            ;;
        4)
            GG
            ;;
        *)
            clear
            echo
            figlet ?  ?  ?
            echo -e '\n\n\n'
            echo '您输入的数字不是可用选项，请确认输入正确'
            echo
            echo '您输入的数字不是可用选项，请确认输入正确'
            echo
            echo '您输入的数字不是可用选项，请确认输入正确'
            sleep 3s
            QQ-repaire-list
            QQ-repaire-num
            ;;
    esac
}

function device()
{
	echo '如果该选项执行后仍然提示QQ版本过低，请继续使用后续方案，或尝试进行扫码登录'
	read -p '请输入你的机器人QQ号并回车：' QQnumber
    sed -i '/platform/d' /root/Yunzai-Bot/config/config/qq.yaml
    echo platform: 4 >> /root/Yunzai-Bot/config/config/qq.yaml
    cd ~/Yunzai-Bot/data/$QQnumber
    curl -o device-$QQnumber.json https://gitee.com/fw-cn/Yunzai/raw/master/QQrepaire
	echo '已尝试进行修复'
	read -p '是否立刻启动机器人，输入1启动，输入0不启动：' num
	if [ $num == 1 ];then
		redis-server --daemonize yes --save 900 1 --save 300 10 && cd ~/Yunzai-Bot && node app
		exit
	else
		echo '不启动机器人，请后续自行启动查看是否修复完成'
		sleep 1s
	fi
	QQ-repaire-list
	QQ-repaire-num
}

function subid()
{
    echo '如果该选项执行后仍然提示QQ版本过低，请继续使用后续方案，或尝试进行扫码登录'
    read -p '请输入你的机器人QQ号并回车：' QQnumber
    sed -i '/platform/d' /root/Yunzai-Bot/config/config/qq.yaml
    echo platform: 4 >> /root/Yunzai-Bot/config/config/qq.yaml
    sed -i 's/537064315/537128930/' /root/Yunzai-Bot/node_modules/oicq/lib/core/device.js
    cd ~/Yunzai-Bot/data/$QQnumber
    curl -o device-$QQnumber.json https://gitee.com/fw-cn/Yunzai/raw/master/QQrepaire
	echo '已尝试进行修复'
	read -p '是否立刻启动机器人，输入1启动，输入0不启动：' num
	if [ $num == 1 ];then
		redis-server --daemonize yes --save 900 1 --save 300 10 && cd ~/Yunzai-Bot && node app
		exit
	else
		echo '不启动机器人，请后续自行启动查看是否修复完成'
		sleep 1s
	fi
	QQ-repaire-list
	QQ-repaire-num
}

function token()
{
    echo 明天做，别急
    sleep 3s
    QQ-repaire-list
	QQ-repaire-num
}

QQ-repaire-list
QQ-repaire-num

}

function oicq-repaire()
{
    echo '正在尝试进行解决……'
    cd ~/Yunzai-Bot && pnpm add image-size axios express multer body-parser jsonwebtoken systeminformation oicq -w
    echo '已尝试进行解决'
    sleep 2s
	RepaireList
	RepaireNum
}
function waiting()
{
    echo '等待后续补充'
    sleep 2s
	RepaireList
	RepaireNum
}

#进行一次报错修复列表的运行
RepaireList
RepaireNum

}

#重新配置机器人QQ
function Reconfig()
{
    redis-server --daemonize yes --save 900 1 --save 300 10
    cd ~/Yunzai-Bot && pnpm run login
}

#安装python3.8
function PythonInstall_1()
{
	#安装python3.8相关
    echo '正在准备安装python3.8及pip'
    sleep 0.5s
    echo '正在准备安装python3.8及pip'
    sleep 0.5s
    echo '正在准备安装python3.8及pip'
    sleep 0.5s
	#安装python和pip
    apt install git python3.8 python3-pip -y
	#进行软链接
    ln -sf python3.8 /usr/bin/python
    ln -sf /usr/bin/pip3 /usr/bin/pip
	#更新pip
    python -m pip install --upgrade pip
    echo 'python3.8及pip安装成功'
    echo -e 你当前的默认python版本是$(python --version)
    sleep 3s
	Yunzai
	YunzaiNum
}

#安装python3.10
function PythonInstall_2()
{
    echo -e '正在准备安装python3.10，该步骤\033[31m可能需要半个小时\033[0m甚至\033[31m更久\033[0m，请耐心等待'
    sleep 0.5s
    echo -e '正在准备安装python3.10，该步骤\033[31m可能需要半个小时\033[0m甚至\033[31m更久\033[0m，请耐心等待'
    sleep 0.5s
    echo -e '正在准备安装python3.10，该步骤\033[31m可能需要半个小时\033[0m甚至\033[31m更久\033[0m，请耐心等待'
    sleep 3s
    cd ~
    #安装依赖
    apt update
    apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev wget make libbz2-dev -y
    #从仓库克隆python3.10包
    git clone --depth=1 https://gitee.com/fw-cn/Yunzai-Bot-Python3.10.0
    cp /root/Yunzai-Bot-Python3.10.0/Python-3.10.0.tgz /home/
    rm -rf Yunzai-Bot-Python3.10.0
    cd /home/
    #解压
    tar -zxvf Python-3.10.0.tgz
    cd Python-3.10.0
    ./configure --enable-optimizations
    make
    make install
    rm -rf Python-3.10.0.tgz
    #软链接
    ln -sf /usr/local/bin/python3 /usr/bin/python
    ln -sf /usr/local/bin/pip3 /usr/bin/pip
    echo 'python3.10安装完成'
    echo -e 你当前的默认python版本是$(python --version)
    sleep 1.5s
	Yunzai
	YunzaiNum
}

#ffmpeg安装
function FfmpegInstall()
{
    clear
	echo -e '正在准备安装ffmpeg……'
    sleep 0.5s
    echo -e '正在准备安装ffmpeg……'
    sleep 0.5s
    echo -e '正在准备安装ffmpeg……'
	sleep 3s
    if ! type git >/dev/null 2>&1; then
        apt update && apt install git -y
    fi
    git clone --depth=1 https://gitee.com/fw-cn/yunzai-ffmpeg
    if [ $(uname -m) == "aarch64" ]; then
        cp /root/yunzai-ffmpeg/arm.tar.gz /home/
        rm -rf /root/yunzai-ffmpeg
        cd /home/
        mkdir ffmpeg5.1.1
        tar -xvf arm.tar.gz -C ffmpeg5.1.1 --strip-components 1
        rm -rf arm.tar.gz
    elif [ $(uname -m) == "x86_64" ]; then
        cp /root/yunzai-ffmpeg/amd.tar.gz /home/
        rm -rf /root/yunzai-ffmpeg
        cd /home/
        mkdir ffmpeg5.1.1
        tar -xvf amd.tar.gz -C ffmpeg5.1.1 --strip-components 1
        rm -rf amd.tar.gz
    fi
    #软链接
    ln -sf /home/ffmpeg5.1.1/ffmpeg /usr/local/bin/ffmpeg
    ln -sf /home/ffmpeg5.1.1/ffprobe /usr/local/bin/ffprobe
    echo 'ffmpeg安装完成'
    echo -e 你当前的ffmpeg是：\\n$(ffmpeg -version)
    Yunzai
    YunzaiNum
}

#更改主人QQ
function MasterQQ()
{
    cd ~/Yunzai-Bot/config/config
    read -p '请输入主人QQ：' yourmasterQQ
    sed -i '7d' other.yaml
    sed -i "/masterQQ:/ a\  - \\$yourmasterQQ" other.yaml
    sleep 1s
    echo '已修改主人QQ'
    sleep 1s
	Yunzai
	YunzaiNum
}

#重新看一遍
function Review()
{
	clear
	echo '————————'
	echo
	echo '这里是所有快捷代码，一定要好好记住哦'
	echo
	echo '————————'
	echo
    echo -e "重新打开本脚本请输入：\033[47;32mcn\033[0m"
    echo -e "启动机器人请输入\033[47;32myz\033[0m"
    echo -e "机器人后台启动运行（即不显示代码启动）请输入：\033[47;32myzstart\033[0m"
    echo -e "显示机器人日志请输入：\033[47;32myzlog\033[0m"
    echo -e "停止机器人后台运行请输入：\033[47;32myzstop\033[0m"
	echo
	echo '该界面五秒钟后自动返回'
	sleep 1s
	echo '5'
	sleep 1s
	echo '4'
	sleep 1s
	echo '3'
	sleep 1s
	echo '2'
	sleep 1s
	echo '1'
	sleep 1s
	echo '0'
	Yunzai
	YunzaiNum
}

#友情链接
function LineLink()
{
    if ! type figlet >/dev/null 2>&1; then
        apt-get update
        apt-get install figlet -y
    fi
	clear
	echo
    echo -e '\033[32m*******************************************************\033[0m'
    echo
	figlet E a r t h - K
	echo -e '土块官网：\033[36mhttps://tukuai.one/\033[0m'
    echo
    echo -e '\033[32m*******************************************************\033[0m'
    echo
    figlet t r s s . m e
    echo -e '时雨星空TRSS官网：\033[36mhttps://trss.me/\033[0m'
    echo
    echo -e '\033[32m*******************************************************\033[0m'
    echo
    figlet Y X Y - Y X Y
    echo -e '云溪院个人主页：\033[36mhttps://gitee.com/yunxiyuan\033[0m'
    echo
    echo -e '\033[32m*******************************************************\033[0m'
    echo
	read -p '键入任意字符回车或直接回车以返回' str
	if [ $str == 1 ];then
		Yunzai
		YunzaiNum
	else
		Yunzai
		YunzaiNum
	fi
}

#其他脚本转接
function Change()
{
function ChangeList()
{
    clear
    cat <<out
*******************************************************

                您正在转接到其他脚本
                   祝您使用愉快
                
*******************************************************

     1.云溪院云崽安装脚本  |    2.时雨星空trss.me脚本

     0.返回

*******************************************************
out
}
function ChangeListNum()
{
    read -p '请输入数字选项：' ChangeListNum
    case $ChangeListNum in
        0)
            Yunzai
            YunzaiNum
            ;;
        1)
            yxy
            ;;
        2)
            trss
            ;;
        *)
            clear
            echo
            figlet ?  ?  ?
            echo -e '\n\n\n'
            echo '您输入的数字不是可用选项，请确认输入正确'
            echo
            echo '您输入的数字不是可用选项，请确认输入正确'
            echo
            echo '您输入的数字不是可用选项，请确认输入正确'
            sleep 3s
            ChangeList
            ChangeListNum
    esac
}
function yxy()
{
	clear
    echo ' '
    echo -e '\033[32m*******************************************************\033[0m'
    echo ' '
    figlet Y X Y - Y X Y
    echo ' '
    echo -e '\033[32m*******************************************************\033[0m'
    echo ' '
    echo -e '云溪院脚本是一款由\033[36m云溪院\033[0m开发并公开的云崽一键安装脚本
    '
    echo '该脚本提供：

    云崽一键安装与云崽各项快捷指令写入

    自选云崽插件安装
    
    python与ffmpeg等各种环境需求安装
    
    常见的各种报错修复
    '
    echo -e '云溪院个人主页：

    \033[36mhttps://gitee.com/yunxiyuan\033[0m'
    echo ' '
    echo -e '\033[32m*******************************************************\033[0m
    '
    echo '您正在准备转接到云溪院云崽安装脚本，是否进行转接？'
    echo ' '
    read -p '输入1并回车确定，输入其他任意字符并回车返回：' yxynum
    if [ $yxynum == 1 ];then
        echo ' '
        echo '正在准备转接到云溪院……'
        sleep 1s
        bash <(curl -sL gitee.com/yunxiyuan/txyz/raw/tx/txyz)
    else
        ChangeList
        ChangeListNum
    fi
}
function trss()
{
	clear
    echo ' '
    echo -e '\033[32m*******************************************************\033[0m
    '
    figlet T R S S . M E
    echo ' '
    echo -e '\033[32m*******************************************************\033[0m
    '
    echo -e '
    trss.me是一款由\033[36m时雨、星空\033[0m开发并公布的一款多功能脚本
    '
    echo '该脚本提供：

    更加容器化的文件管理

    更优的tmux终端管理，多会话并行运行

    更合理的micro与ranger文件管理

    阿里云盘与百度云盘的传输与管理

    更实用的资源监控与进程管理

    各类信息显示
    '
    echo ''
    echo -e '官方网址：

    \033[36mhttps://trss.me/\033[0m'
    echo '
    请自行打开官方网址，按照文档教程进行操作
    '
    echo -e '\033[32m*******************************************************\033[0m'
    echo -e '
    \033[31m注意！该脚本小白勿入！\033[0m
    '
    read -p '输入任意字符并回车，或直接回车以返回：' trssnum
    if [ $trssnum == * ];then
        ChangeList
        ChangeListNum
    fi
}
ChangeList
ChangeListNum
}

function test()
{
	echo 'test'
}

if [ $(id -u) == 0 ];then
#脚本多处使用figlet，干脆直接检测一下装上得了
    if ! type figlet >/dev/null 2>&1; then
        apt-get update
        apt-get install figlet -y
    fi
    Yunzai
    YunzaiNum
else
    echo '当前运行环境不支持！'
    echo '手机用户请确保是否已安装并进入容器内，服务器用户请确保是否已切换root'
fi